import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_box_score/data/database.dart';
import 'package:ultimate_box_score/data/repository.dart';
import 'package:ultimate_box_score/domain/app_error.dart';
import 'package:ultimate_box_score/domain/models.dart';

void main() {
  const legacyGameTable =
      'CREATE TABLE game_entries ('
      'id TEXT NOT NULL PRIMARY KEY, '
      'opponent_name TEXT NOT NULL'
      ')';
  const legacyPointTable =
      'CREATE TABLE point_entries ('
      'id TEXT NOT NULL PRIMARY KEY, '
      'game_id TEXT NOT NULL, '
      'point_number INTEGER NOT NULL, '
      'created_at INTEGER NOT NULL'
      ')';
  const legacyActionTable =
      'CREATE TABLE recorded_action_entries ('
      'id TEXT NOT NULL PRIMARY KEY, '
      'game_id TEXT NOT NULL, '
      'point_id TEXT, '
      'sequence INTEGER NOT NULL, '
      'kind TEXT NOT NULL, '
      'actor_participant_id TEXT, '
      'target_participant_id TEXT, '
      'related_action_id TEXT, '
      'created_at INTEGER NOT NULL, '
      'voided_at INTEGER, '
      'UNIQUE (game_id, sequence)'
      ')';

  late AppDatabase database;
  late SettingsRepository settings;
  late TeamRepository teams;
  late EventRepository events;
  late GameRepository games;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    settings = SettingsRepository(database);
    teams = TeamRepository(database);
    events = EventRepository(database, teams);
    games = GameRepository(database, events);
  });

  tearDown(() => database.close());

  test(
    'language preference defaults, persists, and handles invalid data',
    () async {
      expect(
        await settings.watchLanguagePreference().first,
        AppLanguagePreference.system,
      );

      await settings.setLanguagePreference(
        AppLanguagePreference.simplifiedChinese,
      );
      expect(
        await settings.watchLanguagePreference().first,
        AppLanguagePreference.simplifiedChinese,
      );

      await (database.update(database.appSettingEntries)
            ..where((row) => row.key.equals('preferredLocale')))
          .write(const AppSettingEntriesCompanion(value: Value('invalid')));
      expect(
        await settings.watchLanguagePreference().first,
        AppLanguagePreference.system,
      );

      await settings.setLanguagePreference(AppLanguagePreference.system);
      expect(
        await settings.watchLanguagePreference().first,
        AppLanguagePreference.system,
      );
    },
  );

  test('migrates the legacy localized opponent placeholder', () async {
    await database.close();
    database = AppDatabase(
      NativeDatabase.memory(
        setup: (rawDatabase) {
          rawDatabase
            ..execute(legacyGameTable)
            ..execute(legacyPointTable)
            ..execute(legacyActionTable)
            ..execute(
              "INSERT INTO game_entries (id, opponent_name) "
              "VALUES ('game', '未命名对手')",
            )
            ..execute('PRAGMA user_version = 2');
        },
      ),
    );

    final row = await database
        .customSelect('SELECT opponent_name FROM game_entries')
        .getSingle();

    expect(row.read<String>('opponent_name'), isEmpty);
  });

  test('migration deletes voided actions and their empty points', () async {
    await database.close();
    database = AppDatabase(
      NativeDatabase.memory(
        setup: (rawDatabase) {
          rawDatabase
            ..execute(legacyGameTable)
            ..execute(legacyPointTable)
            ..execute(legacyActionTable)
            ..execute(
              "INSERT INTO game_entries (id, opponent_name) "
              "VALUES ('game', 'opponent')",
            )
            ..execute(
              'INSERT INTO point_entries '
              '(id, game_id, point_number, created_at) VALUES '
              "('active-point', 'game', 1, 1), "
              "('undone-point', 'game', 2, 2)",
            )
            ..execute(
              'INSERT INTO recorded_action_entries '
              '(id, game_id, point_id, sequence, kind, created_at, voided_at) '
              'VALUES '
              "('active', 'game', 'active-point', 1, 'startPoint', 1, NULL), "
              "('undone', 'game', 'undone-point', 2, 'startPoint', 2, 3)",
            )
            ..execute('PRAGMA user_version = 3');
        },
      ),
    );

    final actions = await database
        .customSelect('SELECT id FROM recorded_action_entries')
        .get();
    final points = await database
        .customSelect('SELECT id FROM point_entries')
        .get();
    final actionColumns = await database
        .customSelect("PRAGMA table_info('recorded_action_entries')")
        .get();

    expect(actions.map((row) => row.read<String>('id')), ['active']);
    expect(points.map((row) => row.read<String>('id')), ['active-point']);
    expect(
      actionColumns.map((row) => row.read<String>('name')),
      isNot(contains('voided_at')),
    );
  });

  Future<
    ({
      String teamId,
      String eventId,
      String gameId,
      String a,
      String b,
      String c,
    })
  >
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
    final c = await teams.savePlayer(
      teamId: teamId,
      name: '丙',
      gender: PlayerGender.male,
      position: PlayerPosition.handler,
      number: '3',
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
    return (teamId: teamId, eventId: eventId, gameId: gameId, a: a, b: b, c: c);
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

  test('game bundle watcher stays live after event bundle watcher', () async {
    final fixture = await createFixture();
    final eventBundles = StreamIterator(
      events.watchEventBundle(fixture.eventId),
    );
    expect(await eventBundles.moveNext(), isTrue);

    final gameBundles = StreamIterator(games.watchGameBundle(fixture.gameId));
    try {
      expect(await gameBundles.moveNext(), isTrue);
      final (participantA, _) = await startPoint(
        fixture.gameId,
        fixture.a,
        fixture.b,
      );
      expect(
        await gameBundles.moveNext().timeout(const Duration(seconds: 1)),
        isTrue,
      );
      expect(gameBundles.current.state.stage, RecordingStage.awaitingPickup);

      await games.recordPickup(fixture.gameId, participantA);

      expect(
        await gameBundles.moveNext().timeout(const Duration(seconds: 1)),
        isTrue,
      );
      expect(gameBundles.current.state.stage, RecordingStage.offense);
      expect(gameBundles.current.state.holderParticipantId, participantA);
      expect(gameBundles.current.actions.last.kind, RecordedActionKind.pickup);
    } finally {
      await gameBundles.cancel();
      await eventBundles.cancel();
    }
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

    expect(
      () => games.startGame(second),
      throwsA(
        isA<AppException>().having(
          (error) => error.code,
          'code',
          AppErrorCode.anotherGameActive,
        ),
      ),
    );
  });

  test(
    'undo permanently removes the latest action and restores state',
    () async {
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
      final goalAction = bundle.actions.last;
      final actionCount = bundle.actions.length;

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
      expect(bundle.state.stage, RecordingStage.offense);
      expect(bundle.state.holderParticipantId, participantA);
      expect(bundle.actions, hasLength(actionCount - 1));
      expect(
        bundle.actions.map((action) => action.id),
        isNot(contains(goalAction.id)),
      );
      expect(await games.getTeamStats(fixture.teamId), isEmpty);
    },
  );

  test('undoing point start removes its point and participants', () async {
    final fixture = await createFixture();
    await startPoint(fixture.gameId, fixture.a, fixture.b);

    var bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.points, hasLength(1));
    expect(bundle.participants, hasLength(3));

    await games.undoLast(fixture.gameId);
    bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.actions, isEmpty);
    expect(bundle.points, isEmpty);
    expect(bundle.participants, isEmpty);
    expect(bundle.state.stage, RecordingStage.betweenPoints);
    expect(bundle.state.nextPointNumber, 1);

    await startPoint(fixture.gameId, fixture.a, fixture.b);
    bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.points.single.number, 1);
  });

  test(
    'one-for-one substitution persists, transfers holder, and undoes',
    () async {
      final fixture = await createFixture();
      final (participantA, participantB) = await startPoint(
        fixture.gameId,
        fixture.a,
        fixture.b,
      );
      var bundle = await games.getGameBundle(fixture.gameId);
      final rosterC = bundle.roster.singleWhere(
        (player) => player.playerId == fixture.c,
      );
      await games.recordPickup(fixture.gameId, participantA);
      await games.substitutePlayer(
        gameId: fixture.gameId,
        outgoingParticipantId: participantA,
        incomingRosterId: rosterC.id,
      );

      bundle = await games.getGameBundle(fixture.gameId);
      final participantC = bundle.state.holderParticipantId!;
      expect(bundle.participantSnapshot(participantC)?.playerId, fixture.c);
      expect(bundle.state.currentParticipants, hasLength(3));
      expect(bundle.actions.last.kind, RecordedActionKind.substitution);

      await games.undoLast(fixture.gameId);
      bundle = await games.getGameBundle(fixture.gameId);
      expect(bundle.state.holderParticipantId, participantA);
      expect(bundle.state.currentParticipants.take(2), [
        participantA,
        participantB,
      ]);
      expect(
        bundle.participantsForPoint(bundle.state.currentPointId!),
        hasLength(3),
      );

      await games.substitutePlayer(
        gameId: fixture.gameId,
        outgoingParticipantId: participantA,
        incomingRosterId: rosterC.id,
      );
      bundle = await games.getGameBundle(fixture.gameId);
      final activeC = bundle.state.holderParticipantId!;
      await games.recordGoalCatch(fixture.gameId, participantB);
      bundle = await games.getGameBundle(fixture.gameId);
      expect(bundle.state.stats[fixture.a]?.touches, 1);
      expect(bundle.state.stats[fixture.a]?.pointsPlayed, 1);
      expect(bundle.state.stats[fixture.b]?.pointsPlayed, 1);
      expect(bundle.state.stats[fixture.c]?.pointsPlayed, 1);
      expect(bundle.state.stats[fixture.c]?.assists, 1);
      expect(activeC, isNot(participantA));
    },
  );

  test('pickup holder can score and complete a target-score game', () async {
    final fixture = await createFixture(maxPoints: 1);
    final (participantA, _) = await startPoint(
      fixture.gameId,
      fixture.a,
      fixture.b,
    );

    await games.recordPickup(fixture.gameId, participantA);
    await games.confirmHolderGoal(fixture.gameId);

    final bundle = await games.getGameBundle(fixture.gameId);
    expect(bundle.game.status, GameStatus.completed);
    expect(bundle.state.ourScore, 1);
    expect(bundle.state.stats[fixture.a]?.touches, 1);
    expect(bundle.state.stats[fixture.a]?.goals, 1);
    expect(bundle.state.stats[fixture.a]?.catches ?? 0, 0);
    expect(bundle.state.stats[fixture.a]?.assists ?? 0, 0);
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
