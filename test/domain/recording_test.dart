import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_box_score/domain/models.dart';
import 'package:ultimate_box_score/domain/recording.dart';

void main() {
  final game = Game(
    id: 'game',
    eventId: 'event',
    teamId: 'team',
    teamName: '本队',
    teamType: TeamType.mixed,
    opponentName: '对手',
    openingMode: PossessionMode.offense,
    status: GameStatus.inProgress,
    createdAt: DateTime(2026),
    startedAt: DateTime(2026),
    softCapAcknowledged: false,
    totalCapAcknowledged: false,
  );
  const roster = [
    GamePlayerSnapshot(
      id: 'ra',
      gameId: 'game',
      playerId: 'a',
      name: '甲',
      gender: PlayerGender.male,
      position: PlayerPosition.handler,
      archivedAtStart: false,
    ),
    GamePlayerSnapshot(
      id: 'rb',
      gameId: 'game',
      playerId: 'b',
      name: '乙',
      gender: PlayerGender.female,
      position: PlayerPosition.cutter,
      archivedAtStart: false,
    ),
  ];
  const participants = [
    PointParticipant(
      id: 'pa',
      pointId: 'point',
      gameRosterId: 'ra',
      displayOrder: 0,
      unknown: false,
    ),
    PointParticipant(
      id: 'pb',
      pointId: 'point',
      gameRosterId: 'rb',
      displayOrder: 1,
      unknown: false,
    ),
  ];

  RecordedAction action(
    int sequence,
    RecordedActionKind kind, {
    String? actor,
    String? target,
    String? related,
    bool voided = false,
  }) {
    return RecordedAction(
      id: '$sequence',
      gameId: game.id,
      pointId: 'point',
      sequence: sequence,
      kind: kind,
      actorParticipantId: actor,
      targetParticipantId: target,
      relatedActionId: related,
      createdAt: DateTime(2026),
      voidedAt: voided ? DateTime(2026, 1, 2) : null,
    );
  }

  RecordingState replay(List<RecordedAction> actions) {
    return RecordingReducer.replay(
      game: game,
      participants: participants,
      roster: roster,
      actions: actions,
    );
  }

  test('records actor to target events and derives attempt stats', () {
    final state = replay([
      action(1, RecordedActionKind.startPoint),
      action(2, RecordedActionKind.pickup, actor: 'pa'),
      action(3, RecordedActionKind.receiverDrop, actor: 'pa', target: 'pb'),
      action(4, RecordedActionKind.defensiveBlock, actor: 'pb'),
      action(5, RecordedActionKind.pickup, actor: 'pb'),
      action(6, RecordedActionKind.passerTurnover, actor: 'pb'),
    ]);

    expect(state.stage, RecordingStage.defense);
    expect(state.stats['a']?.touches, 1);
    expect(state.stats['a']?.throws, 1);
    expect(state.stats['b']?.ds, 1);
    expect(state.stats['b']?.touches, 1);
    expect(state.stats['b']?.throws, 1);
    expect(state.stats['b']?.turnovers, 2);
    expect(state.stats['b']?.receiverDrops, 1);
    expect(state.stats['b']?.passerTurnovers, 1);
  });

  test('goal catch equals pass followed by goal confirmation', () {
    final direct = replay([
      action(1, RecordedActionKind.startPoint),
      action(2, RecordedActionKind.pickup, actor: 'pa'),
      action(3, RecordedActionKind.goalCatch, actor: 'pa', target: 'pb'),
    ]);
    final confirmed = replay([
      action(1, RecordedActionKind.startPoint),
      action(2, RecordedActionKind.pickup, actor: 'pa'),
      action(3, RecordedActionKind.completedPass, actor: 'pa', target: 'pb'),
      action(4, RecordedActionKind.confirmGoal, actor: 'pb', related: '3'),
    ]);

    expect(confirmed.ourScore, direct.ourScore);
    expect(confirmed.stats['a']?.throws, direct.stats['a']?.throws);
    expect(confirmed.stats['a']?.assists, direct.stats['a']?.assists);
    expect(confirmed.stats['b']?.touches, direct.stats['b']?.touches);
    expect(confirmed.stats['b']?.catches, direct.stats['b']?.catches);
    expect(confirmed.stats['b']?.goals, direct.stats['b']?.goals);
    expect(confirmed.stats['a']?.pointsPlayed, 1);
    expect(confirmed.stats['b']?.pointsPlayed, 1);
  });

  test('voiding goal confirmation leaves its pass and holder intact', () {
    final state = replay([
      action(1, RecordedActionKind.startPoint),
      action(2, RecordedActionKind.pickup, actor: 'pa'),
      action(3, RecordedActionKind.completedPass, actor: 'pa', target: 'pb'),
      action(
        4,
        RecordedActionKind.confirmGoal,
        actor: 'pb',
        related: '3',
        voided: true,
      ),
    ]);

    expect(state.ourScore, 0);
    expect(state.stage, RecordingStage.offense);
    expect(state.holderParticipantId, 'pb');
    expect(state.stats['a']?.throws, 1);
    expect(state.stats['b']?.catches, 1);
    expect(state.stats['b']?.goals, 0);
  });

  test('a defensive block requires a later pickup to establish possession', () {
    final state = replay([
      action(1, RecordedActionKind.startPoint),
      action(2, RecordedActionKind.pickup, actor: 'pa'),
      action(3, RecordedActionKind.passerTurnover, actor: 'pa'),
      action(4, RecordedActionKind.defensiveBlock, actor: 'pa'),
    ]);

    expect(state.stage, RecordingStage.awaitingPickup);
    expect(state.holderParticipantId, isNull);
    expect(state.stats['a']?.ds, 1);
    expect(state.stats['a']?.touches, 1);
  });

  test('ABBA ratio does not reset at halftime', () {
    expect(
      List.generate(
        8,
        (completed) =>
            RecordingRules.requiredRatio(GenderRatio.fourMale, completed),
      ),
      [
        GenderRatio.fourMale,
        GenderRatio.fourFemale,
        GenderRatio.fourFemale,
        GenderRatio.fourMale,
        GenderRatio.fourMale,
        GenderRatio.fourFemale,
        GenderRatio.fourFemale,
        GenderRatio.fourMale,
      ],
    );
  });
}
