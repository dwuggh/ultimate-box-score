import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_box_score/data/database.dart';
import 'package:ultimate_box_score/data/repository.dart';
import 'package:ultimate_box_score/domain/models.dart';

void main() {
  late AppDatabase database;
  late TeamRepository teams;
  late EventRepository events;
  late GameRepository games;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    teams = TeamRepository(database);
    events = EventRepository(database, teams);
    games = GameRepository(database, events);
  });

  tearDown(() => database.close());

  Future<({String teamId, String eventId, String gameId, String a, String b})>
  createFixture({int? maxPoints}) async {
    final teamId = await teams.saveTeam(name: '飞盘队', type: TeamType.mixed);
    final a = await teams.savePlayer(
      teamId: teamId,
      name: '甲',
      gender: PlayerGender.male,
      position: PlayerPosition.handler,
      number: '1',
    );
    final b = await teams.savePlayer(
      teamId: teamId,
      name: '乙',
      gender: PlayerGender.female,
      position: PlayerPosition.cutter,
      number: '2',
    );
    final eventId = await events.saveEvent(
      EventSaveRequest(teamId: teamId, name: '周末联赛'),
    );
    await events.saveLine(eventId: eventId, name: 'O Line', playerIds: {a, b});
    final gameId = await games.saveDraft(
      GameDraftRequest(
        eventId: eventId,
        opponentName: '对手',
        openingMode: PossessionMode.offense,
        maxPoints: maxPoints,
      ),
    );
    await games.startGame(gameId);
    return (teamId: teamId, eventId: eventId, gameId: gameId, a: a, b: b);
  }

  Future<(String, String)> startPoint(
    String gameId,
    String playerA,
    String playerB,
  ) async {
    var bundle = await games.getGameBundle(gameId);
    final rosterA = bundle.roster.singleWhere(
      (player) => player.playerId == playerA,
    );
    final rosterB = bundle.roster.singleWhere(
      (player) => player.playerId == playerB,
    );
    await games.startPoint(gameId, [rosterA.id, rosterB.id]);
    bundle = await games.getGameBundle(gameId);
    final pointId = bundle.state.currentPointId!;
    final pointParticipants = bundle.participantsForPoint(pointId);
    final participantA = pointParticipants.singleWhere(
      (item) => item.gameRosterId == rosterA.id,
    );
    final participantB = pointParticipants.singleWhere(
      (item) => item.gameRosterId == rosterB.id,
    );
    return (participantA.id, participantB.id);
  }

  test('event defaults to all players and accepts reusable lines', () async {
    final fixture = await createFixture();
    final bundle = await events.getEventBundle(fixture.eventId);

    expect(
      bundle.roster.map((player) => player.id),
      containsAll([fixture.a, fixture.b]),
    );
    expect(bundle.lines.single.name, 'O Line');
    expect(bundle.lines.single.memberPlayerIds, [fixture.a, fixture.b]);
  });

  test(
    'persists actor-target actions and immutable roster snapshots',
    () async {
      final fixture = await createFixture();
      final (participantA, participantB) = await startPoint(
        fixture.gameId,
        fixture.a,
        fixture.b,
      );
      await games.recordPickup(fixture.gameId, participantA);
      await games.recordPass(fixture.gameId, participantB);
      await games.confirmHolderGoal(fixture.gameId);
      await teams.savePlayer(
        id: fixture.a,
        teamId: fixture.teamId,
        name: '甲（改名）',
        gender: PlayerGender.male,
        position: PlayerPosition.handler,
        number: '99',
      );

      final restored = await GameRepository(
        database,
        events,
      ).getGameBundle(fixture.gameId);
      final pass = restored.actions.singleWhere(
        (action) => action.kind == RecordedActionKind.completedPass,
      );
      expect(pass.actorParticipantId, participantA);
      expect(pass.targetParticipantId, participantB);
      expect(restored.state.ourScore, 1);
      expect(restored.state.stats[fixture.a]?.assists, 1);
      expect(restored.state.stats[fixture.b]?.goals, 1);
      expect(
        restored.roster.singleWhere((row) => row.playerId == fixture.a).name,
        '甲',
      );
    },
  );

  test('only one game can be in progress globally', () async {
    final fixture = await createFixture();
    final second = await games.saveDraft(
      GameDraftRequest(
        eventId: fixture.eventId,
        opponentName: '另一队',
        openingMode: PossessionMode.defense,
      ),
    );

    expect(() => games.startGame(second), throwsA(isA<StateError>()));
  });

  test('team totals include completed games and undo is auditable', () async {
    final fixture = await createFixture(maxPoints: 1);
    final (participantA, participantB) = await startPoint(
      fixture.gameId,
      fixture.a,
      fixture.b,
    );
    await games.recordPickup(fixture.gameId, participantA);
    await games.recordGoalCatch(fixture.gameId, participantB);

    var bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.game.status, GameStatus.completed);
    expect((await games.getTeamStats(fixture.teamId))[fixture.b]?.goals, 1);

    await games.updateMutableGame(
      gameId: fixture.gameId,
      opponentName: bundle.game.opponentName,
      maxPoints: 2,
    );
    await games.reopenGame(fixture.gameId);
    await games.undoLast(fixture.gameId);
    bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.game.status, GameStatus.inProgress);
    expect(bundle.state.ourScore, 0);
    expect(bundle.actions.last.voided, isTrue);
    expect(await games.getTeamStats(fixture.teamId), isEmpty);
  });

  test('manual completion can restore an abandoned point on reopen', () async {
    final fixture = await createFixture();
    final (participantA, _) = await startPoint(
      fixture.gameId,
      fixture.a,
      fixture.b,
    );
    await games.recordPickup(fixture.gameId, participantA);
    await games.completeGame(fixture.gameId);

    var bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.state.pointAbandoned, isTrue);
    expect(bundle.state.stats[fixture.a]?.pointsPlayed, 1);

    await games.reopenGame(fixture.gameId);
    bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.state.stage, RecordingStage.offense);
    expect(bundle.state.holderParticipantId, participantA);
    expect(bundle.state.stats[fixture.a]?.pointsPlayed ?? 0, 0);
  });
}
