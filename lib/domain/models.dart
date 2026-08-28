enum TeamType { mixed, single }

enum PlayerGender { male, female }

enum PlayerPosition { cutter, handler, any }

enum PossessionMode { offense, defense }

enum GenderRatio { fourMale, fourFemale }

enum GameStatus { draft, inProgress, completed }

enum RecordingStage {
  betweenPoints,
  halftime,
  awaitingPickup,
  offense,
  defense,
}

enum RecordedActionKind {
  startPoint,
  startHalftime,
  endHalftime,
  pickup,
  completedPass,
  receiverDrop,
  passerTurnover,
  goalCatch,
  confirmGoal,
  defensiveBlock,
  opponentThrowaway,
  opponentGoal,
  abandonPoint,
}

enum ExportScopeKind { all, team, event, game }

enum AppLanguagePreference { system, english, simplifiedChinese }

T enumByName<T extends Enum>(Iterable<T> values, String name) {
  return values.firstWhere((value) => value.name == name);
}

class Team {
  const Team({
    required this.id,
    required this.name,
    required this.type,
    required this.archived,
  });

  final String id;
  final String name;
  final TeamType type;
  final bool archived;
}

class Player {
  const Player({
    required this.id,
    required this.teamId,
    required this.name,
    required this.gender,
    required this.position,
    required this.archived,
    this.number,
  });

  final String id;
  final String teamId;
  final String name;
  final PlayerGender gender;
  final String? number;
  final PlayerPosition position;
  final bool archived;
}

class CompetitionEvent {
  const CompetitionEvent({
    required this.id,
    required this.teamId,
    required this.name,
    required this.archived,
    required this.createdAt,
    this.startDate,
    this.endDate,
    this.location,
    this.notes,
  });

  final String id;
  final String teamId;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? notes;
  final bool archived;
  final DateTime createdAt;
}

class LinePreset {
  const LinePreset({
    required this.id,
    required this.eventId,
    required this.name,
    required this.memberPlayerIds,
  });

  final String id;
  final String eventId;
  final String name;
  final List<String> memberPlayerIds;
}

class Game {
  const Game({
    required this.id,
    required this.eventId,
    required this.teamId,
    required this.teamName,
    required this.teamType,
    required this.opponentName,
    required this.openingMode,
    required this.status,
    required this.createdAt,
    required this.softCapAcknowledged,
    required this.totalCapAcknowledged,
    this.softCapMinutes,
    this.totalCapMinutes,
    this.maxPoints,
    this.firstRatio,
    this.startedAt,
    this.completedAt,
  });

  final String id;
  final String eventId;
  final String teamId;
  final String teamName;
  final TeamType teamType;
  final String opponentName;
  final PossessionMode openingMode;
  final int? softCapMinutes;
  final int? totalCapMinutes;
  final int? maxPoints;
  final GenderRatio? firstRatio;
  final GameStatus status;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final bool softCapAcknowledged;
  final bool totalCapAcknowledged;

  bool get isMixed => teamType == TeamType.mixed;
}

class GamePlayerSnapshot {
  const GamePlayerSnapshot({
    required this.id,
    required this.gameId,
    required this.playerId,
    required this.name,
    required this.gender,
    required this.position,
    required this.archivedAtStart,
    this.number,
  });

  final String id;
  final String gameId;
  final String playerId;
  final String name;
  final PlayerGender gender;
  final String? number;
  final PlayerPosition position;
  final bool archivedAtStart;
}

class PointRecord {
  const PointRecord({
    required this.id,
    required this.gameId,
    required this.number,
    required this.createdAt,
  });

  final String id;
  final String gameId;
  final int number;
  final DateTime createdAt;
}

class PointParticipant {
  const PointParticipant({
    required this.id,
    required this.pointId,
    required this.displayOrder,
    required this.unknown,
    this.gameRosterId,
  });

  final String id;
  final String pointId;
  final String? gameRosterId;
  final int displayOrder;
  final bool unknown;
}

class RecordedAction {
  const RecordedAction({
    required this.id,
    required this.gameId,
    required this.sequence,
    required this.kind,
    required this.createdAt,
    this.pointId,
    this.actorParticipantId,
    this.targetParticipantId,
    this.relatedActionId,
  });

  final String id;
  final String gameId;
  final String? pointId;
  final int sequence;
  final RecordedActionKind kind;
  final String? actorParticipantId;
  final String? targetParticipantId;
  final String? relatedActionId;
  final DateTime createdAt;
}

class PlayerStats {
  const PlayerStats({
    this.pointsPlayed = 0,
    this.goals = 0,
    this.assists = 0,
    this.ds = 0,
    this.turnovers = 0,
    this.touches = 0,
    this.catches = 0,
    this.throws = 0,
    this.receiverDrops = 0,
    this.passerTurnovers = 0,
  });

  final int pointsPlayed;
  final int goals;
  final int assists;
  final int ds;
  final int turnovers;
  final int touches;
  final int catches;
  final int throws;
  final int receiverDrops;
  final int passerTurnovers;

  PlayerStats add({
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
    return PlayerStats(
      pointsPlayed: this.pointsPlayed + pointsPlayed,
      goals: this.goals + goals,
      assists: this.assists + assists,
      ds: this.ds + ds,
      turnovers: this.turnovers + turnovers,
      touches: this.touches + touches,
      catches: this.catches + catches,
      throws: this.throws + throws,
      receiverDrops: this.receiverDrops + receiverDrops,
      passerTurnovers: this.passerTurnovers + passerTurnovers,
    );
  }

  PlayerStats merge(PlayerStats other) {
    return add(
      pointsPlayed: other.pointsPlayed,
      goals: other.goals,
      assists: other.assists,
      ds: other.ds,
      turnovers: other.turnovers,
      touches: other.touches,
      catches: other.catches,
      throws: other.throws,
      receiverDrops: other.receiverDrops,
      passerTurnovers: other.passerTurnovers,
    );
  }

  List<int> get csvValues => [
    pointsPlayed,
    goals,
    assists,
    ds,
    turnovers,
    touches,
    catches,
    throws,
    receiverDrops,
    passerTurnovers,
  ];
}

class RecordingState {
  const RecordingState({
    required this.stage,
    required this.nextPointMode,
    required this.ourScore,
    required this.opponentScore,
    required this.completedPoints,
    required this.halftimeTaken,
    required this.currentParticipants,
    required this.stats,
    this.currentMode,
    this.currentPointId,
    this.holderParticipantId,
    this.lastCatchActionId,
    this.pointAbandoned = false,
  });

  final RecordingStage stage;
  final PossessionMode nextPointMode;
  final PossessionMode? currentMode;
  final int ourScore;
  final int opponentScore;
  final int completedPoints;
  final bool halftimeTaken;
  final String? currentPointId;
  final List<String> currentParticipants;
  final String? holderParticipantId;
  final String? lastCatchActionId;
  final bool pointAbandoned;
  final Map<String, PlayerStats> stats;

  bool get pointInProgress => switch (stage) {
    RecordingStage.awaitingPickup ||
    RecordingStage.offense ||
    RecordingStage.defense => true,
    RecordingStage.betweenPoints || RecordingStage.halftime => false,
  };

  int get nextPointNumber => completedPoints + 1;
}

class EventBundle {
  const EventBundle({
    required this.event,
    required this.team,
    required this.teamPlayers,
    required this.roster,
    required this.lines,
    required this.games,
  });

  final CompetitionEvent event;
  final Team team;
  final List<Player> teamPlayers;
  final List<Player> roster;
  final List<LinePreset> lines;
  final List<Game> games;
}

class GameBundle {
  const GameBundle({
    required this.game,
    required this.roster,
    required this.points,
    required this.participants,
    required this.actions,
    required this.lines,
    required this.state,
  });

  final Game game;
  final List<GamePlayerSnapshot> roster;
  final List<PointRecord> points;
  final List<PointParticipant> participants;
  final List<RecordedAction> actions;
  final List<LinePreset> lines;
  final RecordingState state;

  GamePlayerSnapshot? snapshot(String id) {
    for (final player in roster) {
      if (player.id == id) return player;
    }
    return null;
  }

  PointParticipant? participant(String id) {
    for (final player in participants) {
      if (player.id == id) return player;
    }
    return null;
  }

  GamePlayerSnapshot? participantSnapshot(String participantId) {
    final item = participant(participantId);
    final rosterId = item?.gameRosterId;
    return rosterId == null ? null : snapshot(rosterId);
  }

  List<PointParticipant> participantsForPoint(String pointId) {
    final result =
        participants
            .where((participant) => participant.pointId == pointId)
            .toList()
          ..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
    return result;
  }

  PointRecord? point(String id) {
    for (final point in points) {
      if (point.id == id) return point;
    }
    return null;
  }
}

class ExportScope {
  const ExportScope._(this.kind, this.id);

  const ExportScope.all() : this._(ExportScopeKind.all, null);
  const ExportScope.team(String id) : this._(ExportScopeKind.team, id);
  const ExportScope.event(String id) : this._(ExportScopeKind.event, id);
  const ExportScope.game(String id) : this._(ExportScopeKind.game, id);

  final ExportScopeKind kind;
  final String? id;
}

int compareJerseyAndName({
  required String? numberA,
  required String nameA,
  required String? numberB,
  required String nameB,
}) {
  final a = numberA?.trim();
  final b = numberB?.trim();
  final aMissing = a == null || a.isEmpty;
  final bMissing = b == null || b.isEmpty;
  if (aMissing != bMissing) return aMissing ? 1 : -1;
  if (!aMissing && !bMissing) {
    final aNumber = int.tryParse(a);
    final bNumber = int.tryParse(b);
    if (aNumber != null && bNumber != null) {
      final byNumber = aNumber.compareTo(bNumber);
      if (byNumber != 0) return byNumber;
    } else if (aNumber != null || bNumber != null) {
      return aNumber != null ? -1 : 1;
    } else {
      final byText = a.compareTo(b);
      if (byText != 0) return byText;
    }
  }
  return nameA.compareTo(nameB);
}

const statCsvHeaders = [
  'points_played',
  'goals',
  'assists',
  'ds',
  'turnovers',
  'touches',
  'catches',
  'throws',
  'receiver_drops',
  'passer_turnovers',
];
