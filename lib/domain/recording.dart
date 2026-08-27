import 'models.dart';

class RecordingRules {
  const RecordingRules._();

  static GenderRatio? inferFirstRatio(Iterable<GamePlayerSnapshot> lineup) {
    final selected = lineup.toList();
    if (selected.length != 7) return null;
    final maleCount = selected
        .where((player) => player.gender == PlayerGender.male)
        .length;
    if (maleCount == 4) return GenderRatio.fourMale;
    if (maleCount == 3) return GenderRatio.fourFemale;
    return null;
  }

  static GenderRatio requiredRatio(
    GenderRatio firstRatio,
    int completedPoints,
  ) {
    final useFirst = completedPoints % 4 == 0 || completedPoints % 4 == 3;
    if (useFirst) return firstRatio;
    return firstRatio == GenderRatio.fourMale
        ? GenderRatio.fourFemale
        : GenderRatio.fourMale;
  }

  static List<LineupWarning> lineupWarnings({
    required Iterable<GamePlayerSnapshot> lineup,
    GenderRatio? requiredRatio,
  }) {
    final selected = lineup.toList();
    final warnings = <LineupWarning>[];
    if (selected.length != 7) {
      warnings.add(LineupWarning.playerCount(selected.length));
    }
    if (requiredRatio == null) return warnings;
    final maleCount = selected
        .where((player) => player.gender == PlayerGender.male)
        .length;
    final femaleCount = selected.length - maleCount;
    final expectedMale = requiredRatio == GenderRatio.fourMale ? 4 : 3;
    final expectedFemale = 7 - expectedMale;
    if (maleCount != expectedMale || femaleCount != expectedFemale) {
      warnings.add(
        LineupWarning.genderRatio(
          maleCount: maleCount,
          femaleCount: femaleCount,
          expectedMale: expectedMale,
          expectedFemale: expectedFemale,
        ),
      );
    }
    return warnings;
  }
}

enum LineupWarningKind { playerCount, genderRatio }

final class LineupWarning {
  const LineupWarning.playerCount(this.playerCount)
    : kind = LineupWarningKind.playerCount,
      maleCount = null,
      femaleCount = null,
      expectedMale = null,
      expectedFemale = null;

  const LineupWarning.genderRatio({
    required this.maleCount,
    required this.femaleCount,
    required this.expectedMale,
    required this.expectedFemale,
  }) : kind = LineupWarningKind.genderRatio,
       playerCount = null;

  final LineupWarningKind kind;
  final int? playerCount;
  final int? maleCount;
  final int? femaleCount;
  final int? expectedMale;
  final int? expectedFemale;
}

class RecordingReducer {
  const RecordingReducer._();

  static RecordingState replay({
    required Game game,
    required Iterable<PointParticipant> participants,
    required Iterable<GamePlayerSnapshot> roster,
    required Iterable<RecordedAction> actions,
  }) {
    final participantsById = {
      for (final participant in participants) participant.id: participant,
    };
    final snapshotsById = {for (final player in roster) player.id: player};
    final participantsByPoint = <String, List<PointParticipant>>{};
    for (final participant in participants) {
      participantsByPoint
          .putIfAbsent(participant.pointId, () => [])
          .add(participant);
    }
    for (final list in participantsByPoint.values) {
      list.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    }

    var stage = RecordingStage.betweenPoints;
    var nextPointMode = game.openingMode;
    PossessionMode? currentMode;
    var ourScore = 0;
    var opponentScore = 0;
    var completedPoints = 0;
    var halftimeTaken = false;
    String? currentPointId;
    var currentParticipants = <String>[];
    String? holderParticipantId;
    String? lastCatchActionId;
    var pointAbandoned = false;
    final stats = <String, PlayerStats>{};
    final activeById = <String, RecordedAction>{};

    String? statKeyFor(String? participantId) {
      if (participantId == null) return null;
      final participant = participantsById[participantId];
      if (participant == null) return null;
      if (participant.unknown) return 'unknown';
      return snapshotsById[participant.gameRosterId]?.playerId;
    }

    void addStats(
      String? participantId, {
      int pointsPlayed = 0,
      int goals = 0,
      int assists = 0,
      int ds = 0,
      int turnovers = 0,
      int touches = 0,
      int catches = 0,
      int throws = 0,
      int receiverDrops = 0,
      int passerTurnovers = 0,
    }) {
      final key = statKeyFor(participantId);
      if (key == null) return;
      stats[key] = (stats[key] ?? const PlayerStats()).add(
        pointsPlayed: pointsPlayed,
        goals: goals,
        assists: assists,
        ds: ds,
        turnovers: turnovers,
        touches: touches,
        catches: catches,
        throws: throws,
        receiverDrops: receiverDrops,
        passerTurnovers: passerTurnovers,
      );
    }

    void creditLineup() {
      for (final participantId in currentParticipants) {
        if (participantsById[participantId]?.unknown ?? true) continue;
        addStats(participantId, pointsPlayed: 1);
      }
    }

    void finishPoint(PossessionMode nextMode) {
      creditLineup();
      completedPoints += 1;
      nextPointMode = nextMode;
      currentMode = null;
      currentPointId = null;
      currentParticipants = <String>[];
      holderParticipantId = null;
      lastCatchActionId = null;
      pointAbandoned = false;
      stage = RecordingStage.betweenPoints;
    }

    final activeActions = actions.where((action) => !action.voided).toList()
      ..sort((a, b) => a.sequence.compareTo(b.sequence));

    for (final action in activeActions) {
      activeById[action.id] = action;
      switch (action.kind) {
        case RecordedActionKind.startPoint:
          currentPointId = action.pointId;
          currentParticipants = [
            for (final participant
                in participantsByPoint[action.pointId] ?? const [])
              participant.id,
          ];
          currentMode = nextPointMode;
          holderParticipantId = null;
          lastCatchActionId = null;
          pointAbandoned = false;
          stage = nextPointMode == PossessionMode.offense
              ? RecordingStage.awaitingPickup
              : RecordingStage.defense;
        case RecordedActionKind.startHalftime:
          halftimeTaken = true;
          stage = RecordingStage.halftime;
          currentMode = null;
        case RecordedActionKind.endHalftime:
          nextPointMode = game.openingMode == PossessionMode.offense
              ? PossessionMode.defense
              : PossessionMode.offense;
          stage = RecordingStage.betweenPoints;
        case RecordedActionKind.pickup:
          addStats(action.actorParticipantId, touches: 1);
          holderParticipantId = action.actorParticipantId;
          currentMode = PossessionMode.offense;
          lastCatchActionId = null;
          stage = RecordingStage.offense;
        case RecordedActionKind.completedPass:
          addStats(action.actorParticipantId, throws: 1);
          addStats(action.targetParticipantId, catches: 1, touches: 1);
          holderParticipantId = action.targetParticipantId;
          lastCatchActionId = action.id;
          currentMode = PossessionMode.offense;
          stage = RecordingStage.offense;
        case RecordedActionKind.receiverDrop:
          addStats(action.actorParticipantId, throws: 1);
          addStats(action.targetParticipantId, turnovers: 1, receiverDrops: 1);
          holderParticipantId = null;
          lastCatchActionId = null;
          currentMode = PossessionMode.defense;
          stage = RecordingStage.defense;
        case RecordedActionKind.passerTurnover:
          addStats(
            action.actorParticipantId,
            throws: 1,
            turnovers: 1,
            passerTurnovers: 1,
          );
          holderParticipantId = null;
          lastCatchActionId = null;
          currentMode = PossessionMode.defense;
          stage = RecordingStage.defense;
        case RecordedActionKind.goalCatch:
          addStats(action.actorParticipantId, throws: 1, assists: 1);
          addStats(
            action.targetParticipantId,
            catches: 1,
            touches: 1,
            goals: 1,
          );
          ourScore += 1;
          finishPoint(PossessionMode.defense);
        case RecordedActionKind.confirmGoal:
          final related = activeById[action.relatedActionId];
          addStats(related?.actorParticipantId, assists: 1);
          addStats(action.actorParticipantId, goals: 1);
          ourScore += 1;
          finishPoint(PossessionMode.defense);
        case RecordedActionKind.defensiveBlock:
          addStats(action.actorParticipantId, ds: 1);
          holderParticipantId = null;
          lastCatchActionId = null;
          currentMode = PossessionMode.offense;
          stage = RecordingStage.awaitingPickup;
        case RecordedActionKind.opponentThrowaway:
          holderParticipantId = null;
          lastCatchActionId = null;
          currentMode = PossessionMode.offense;
          stage = RecordingStage.awaitingPickup;
        case RecordedActionKind.opponentGoal:
          opponentScore += 1;
          finishPoint(PossessionMode.offense);
        case RecordedActionKind.abandonPoint:
          creditLineup();
          pointAbandoned = true;
          currentMode = null;
          currentPointId = null;
          currentParticipants = <String>[];
          holderParticipantId = null;
          lastCatchActionId = null;
          stage = RecordingStage.betweenPoints;
      }
    }

    return RecordingState(
      stage: stage,
      nextPointMode: nextPointMode,
      currentMode: currentMode,
      ourScore: ourScore,
      opponentScore: opponentScore,
      completedPoints: completedPoints,
      halftimeTaken: halftimeTaken,
      currentPointId: currentPointId,
      currentParticipants: List.unmodifiable(currentParticipants),
      holderParticipantId: holderParticipantId,
      lastCatchActionId: lastCatchActionId,
      pointAbandoned: pointAbandoned,
      stats: Map.unmodifiable(stats),
    );
  }
}
