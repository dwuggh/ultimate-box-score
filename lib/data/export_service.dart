import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:csv/csv.dart';
import 'package:file_selector/file_selector.dart' as selector;
import 'package:share_plus/share_plus.dart';

import '../domain/models.dart';
import 'database.dart';
import 'repository.dart';

class ExportArtifact {
  const ExportArtifact({required this.fileName, required this.bytes});

  final String fileName;
  final Uint8List bytes;
}

class ExportService {
  ExportService(this.database, this.games);

  final AppDatabase database;
  final GameRepository games;

  Future<ExportArtifact> build(ExportScope scope) async {
    final exportedAt = DateTime.now().toUtc();
    final allTeams = await database.select(database.teamEntries).get();
    final allPlayers = await database.select(database.playerEntries).get();
    final allEvents = await database
        .select(database.competitionEventEntries)
        .get();
    final allEventRoster = await database
        .select(database.eventRosterEntries)
        .get();
    final allLines = await database.select(database.linePresetEntries).get();
    final allLineMembers = await database
        .select(database.linePresetMemberEntries)
        .get();
    final allGames = await database.select(database.gameEntries).get();
    final allSnapshots = await database
        .select(database.gameRosterEntries)
        .get();
    final allPoints = await database.select(database.pointEntries).get();
    final allParticipants = await database
        .select(database.pointParticipantEntries)
        .get();
    final allActions = await database
        .select(database.recordedActionEntries)
        .get();
    final allSettings = await database.select(database.appSettingEntries).get();

    late final Set<String> gameIds;
    late final Set<String> eventIds;
    late final Set<String> teamIds;
    switch (scope.kind) {
      case ExportScopeKind.all:
        gameIds = allGames.map((row) => row.id).toSet();
        eventIds = allEvents.map((row) => row.id).toSet();
        teamIds = allTeams.map((row) => row.id).toSet();
      case ExportScopeKind.team:
        teamIds = {scope.id!};
        eventIds = allEvents
            .where((row) => teamIds.contains(row.teamId))
            .map((row) => row.id)
            .toSet();
        gameIds = allGames
            .where((row) => teamIds.contains(row.teamId))
            .map((row) => row.id)
            .toSet();
      case ExportScopeKind.event:
        eventIds = {scope.id!};
        final event = allEvents.firstWhere((row) => row.id == scope.id);
        teamIds = {event.teamId};
        gameIds = allGames
            .where((row) => eventIds.contains(row.eventId))
            .map((row) => row.id)
            .toSet();
      case ExportScopeKind.game:
        gameIds = {scope.id!};
        final game = allGames.firstWhere((row) => row.id == scope.id);
        eventIds = {game.eventId};
        teamIds = {game.teamId};
    }

    final teams = allTeams.where((row) => teamIds.contains(row.id)).toList();
    final events = allEvents.where((row) => eventIds.contains(row.id)).toList();
    final eventRoster = allEventRoster
        .where((row) => eventIds.contains(row.eventId))
        .toList();
    final lines = allLines
        .where((row) => eventIds.contains(row.eventId))
        .toList();
    final lineIds = lines.map((row) => row.id).toSet();
    final lineMembers = allLineMembers
        .where((row) => lineIds.contains(row.lineId))
        .toList();
    final gameRows = allGames.where((row) => gameIds.contains(row.id)).toList();
    final snapshots = allSnapshots
        .where((row) => gameIds.contains(row.gameId))
        .toList();
    final points = allPoints
        .where((row) => gameIds.contains(row.gameId))
        .toList();
    final pointIds = points.map((row) => row.id).toSet();
    final participants = allParticipants
        .where((row) => pointIds.contains(row.pointId))
        .toList();
    final actions = allActions
        .where((row) => gameIds.contains(row.gameId))
        .toList();
    final settings = scope.kind == ExportScopeKind.all
        ? allSettings
        : <AppSettingRecord>[];
    final referencedPlayerIds = <String>{
      ...eventRoster.map((row) => row.playerId),
      ...snapshots.map((row) => row.playerId),
    };
    final players = allPlayers.where((row) {
      if (scope.kind == ExportScopeKind.all ||
          scope.kind == ExportScopeKind.team ||
          scope.kind == ExportScopeKind.event) {
        return teamIds.contains(row.teamId);
      }
      return referencedPlayerIds.contains(row.id);
    }).toList();

    teams.sort((a, b) => a.id.compareTo(b.id));
    players.sort((a, b) => a.id.compareTo(b.id));
    events.sort((a, b) => a.id.compareTo(b.id));
    gameRows.sort((a, b) => a.id.compareTo(b.id));
    points.sort((a, b) {
      final byGame = a.gameId.compareTo(b.gameId);
      return byGame != 0 ? byGame : a.createdAt.compareTo(b.createdAt);
    });
    actions.sort((a, b) {
      final byGame = a.gameId.compareTo(b.gameId);
      return byGame != 0 ? byGame : a.sequence.compareTo(b.sequence);
    });

    final scores = <Map<String, Object?>>[];
    final gameStats = <Map<String, Object?>>[];
    for (final game in gameRows) {
      final bundle = await games.getGameBundle(game.id);
      scores.add({
        'game_id': game.id,
        'our_score': bundle.state.ourScore,
        'opponent_score': bundle.state.opponentScore,
      });
      for (final entry in bundle.state.stats.entries) {
        gameStats.add({
          'game_id': game.id,
          'player_id': entry.key,
          ..._statsJson(entry.value),
        });
      }
    }
    final teamStats = <Map<String, Object?>>[];
    if (scope.kind == ExportScopeKind.all ||
        scope.kind == ExportScopeKind.team) {
      for (final teamId in teamIds.toList()..sort()) {
        final stats = await games.getTeamStats(teamId);
        for (final entry in stats.entries) {
          teamStats.add({
            'team_id': teamId,
            'player_id': entry.key,
            ..._statsJson(entry.value),
          });
        }
      }
    }

    final manifest = <String, Object?>{
      'formatVersion': 1,
      'app': 'ultimate_box_score',
      'appVersion': '1.0.0+1',
      'scope': scope.kind.name,
      'scopeId': scope.id,
      'exportedAt': exportedAt.toIso8601String(),
    };
    final data = <String, Object?>{
      'manifest': manifest,
      'teams': [for (final row in teams) _teamJson(row)],
      'players': [for (final row in players) _playerJson(row)],
      'events': [for (final row in events) _eventJson(row)],
      'eventRoster': [for (final row in eventRoster) _eventRosterJson(row)],
      'lines': [for (final row in lines) _lineJson(row)],
      'lineMembers': [for (final row in lineMembers) _lineMemberJson(row)],
      'games': [for (final row in gameRows) _gameJson(row)],
      'gameRosterSnapshots': [for (final row in snapshots) _snapshotJson(row)],
      'points': [for (final row in points) _pointJson(row)],
      'pointParticipants': [
        for (final row in participants) _participantJson(row),
      ],
      'actions': [for (final row in actions) _actionJson(row)],
      'scores': scores,
      'gamePlayerStats': gameStats,
      'teamPlayerStats': teamStats,
      'appSettings': [for (final row in settings) _settingJson(row)],
    };

    final archive = Archive();
    _addText(
      archive,
      'manifest.json',
      const JsonEncoder.withIndent('  ').convert(manifest),
    );
    _addText(
      archive,
      'data.json',
      const JsonEncoder.withIndent('  ').convert(data),
    );
    _addCsv(archive, 'teams.csv', [
      const ['id', 'name', 'team_type', 'archived', 'created_at', 'updated_at'],
      ...teams.map(_teamCsv),
    ]);
    _addCsv(archive, 'players.csv', [
      const [
        'id',
        'team_id',
        'name',
        'gender',
        'number',
        'position',
        'archived',
        'created_at',
        'updated_at',
      ],
      ...players.map(_playerCsv),
    ]);
    _addCsv(archive, 'events.csv', [
      const [
        'id',
        'team_id',
        'name',
        'start_date',
        'end_date',
        'location',
        'notes',
        'archived',
        'created_at',
        'updated_at',
      ],
      ...events.map(_eventCsv),
    ]);
    _addCsv(archive, 'event_roster.csv', [
      const ['event_id', 'player_id', 'added_at'],
      ...eventRoster.map(_eventRosterCsv),
    ]);
    _addCsv(archive, 'lines.csv', [
      const ['id', 'event_id', 'name', 'created_at', 'updated_at'],
      ...lines.map(_lineCsv),
    ]);
    _addCsv(archive, 'line_members.csv', [
      const ['line_id', 'player_id'],
      ...lineMembers.map(_lineMemberCsv),
    ]);
    _addCsv(archive, 'games.csv', [
      const [
        'id',
        'event_id',
        'team_id',
        'team_name',
        'team_type',
        'opponent_name',
        'opening_mode',
        'soft_cap_minutes',
        'total_cap_minutes',
        'max_points',
        'first_ratio',
        'status',
        'created_at',
        'started_at',
        'completed_at',
      ],
      ...gameRows.map(_gameCsv),
    ]);
    _addCsv(archive, 'game_roster_snapshots.csv', [
      const [
        'id',
        'game_id',
        'player_id',
        'name',
        'gender',
        'number',
        'position',
        'archived_at_start',
      ],
      ...snapshots.map(_snapshotCsv),
    ]);
    _addCsv(archive, 'points.csv', [
      const ['id', 'game_id', 'point_number', 'created_at'],
      ...points.map(_pointCsv),
    ]);
    _addCsv(archive, 'point_participants.csv', [
      const ['id', 'point_id', 'game_roster_id', 'display_order', 'unknown'],
      ...participants.map(_participantCsv),
    ]);
    _addCsv(archive, 'actions.csv', [
      const [
        'id',
        'game_id',
        'point_id',
        'sequence',
        'kind',
        'actor_participant_id',
        'target_participant_id',
        'related_action_id',
        'created_at',
        'voided_at',
      ],
      ...actions.map(_actionCsv),
    ]);
    _addMapCsv(archive, 'scores.csv', const [
      'game_id',
      'our_score',
      'opponent_score',
    ], scores);
    _addMapCsv(archive, 'game_player_stats.csv', [
      'game_id',
      'player_id',
      ...statCsvHeaders,
    ], gameStats);
    _addMapCsv(archive, 'team_player_stats.csv', [
      'team_id',
      'player_id',
      ...statCsvHeaders,
    ], teamStats);
    _addCsv(archive, 'app_settings.csv', [
      const ['key', 'value'],
      ...settings.map(_settingCsv),
    ]);

    final stamp = exportedAt.toIso8601String().replaceAll(RegExp(r'[:.]'), '-');
    return ExportArtifact(
      fileName: 'ultimate-box-score-${scope.kind.name}-$stamp.zip',
      bytes: ZipEncoder().encodeBytes(archive),
    );
  }

  Future<bool> buildAndDeliver(ExportScope scope) async {
    final artifact = await build(scope);
    if (Platform.isLinux) {
      final location = await selector.getSaveLocation(
        suggestedName: artifact.fileName,
        acceptedTypeGroups: const [
          selector.XTypeGroup(label: 'ZIP', extensions: ['zip']),
        ],
      );
      if (location == null) return false;
      await selector.XFile.fromData(
        artifact.bytes,
        mimeType: 'application/zip',
        name: artifact.fileName,
      ).saveTo(location.path);
      return true;
    }
    await SharePlus.instance.share(
      ShareParams(
        title: '导出 Ultimate Box Score 数据',
        files: [XFile.fromData(artifact.bytes, mimeType: 'application/zip')],
        fileNameOverrides: [artifact.fileName],
      ),
    );
    return true;
  }

  static void _addText(Archive archive, String name, String value) {
    archive.addFile(ArchiveFile.string(name, value));
  }

  static void _addCsv(Archive archive, String name, List<List<Object?>> rows) {
    if (rows.isEmpty) {
      _addText(archive, name, '\ufeff');
      return;
    }
    _addText(archive, name, '\ufeff${csv.encode(rows)}');
  }

  static void _addMapCsv(
    Archive archive,
    String name,
    List<String> headers,
    List<Map<String, Object?>> rows,
  ) {
    _addCsv(archive, name, [
      headers,
      for (final row in rows) [for (final header in headers) row[header]],
    ]);
  }

  static Map<String, Object?> _statsJson(PlayerStats value) => {
    for (var index = 0; index < statCsvHeaders.length; index++)
      statCsvHeaders[index]: value.csvValues[index],
  };

  static Map<String, Object?> _teamJson(TeamRecord row) => {
    'id': row.id,
    'name': row.name,
    'teamType': row.teamType,
    'archived': row.archived,
    'createdAt': row.createdAt.toUtc().toIso8601String(),
    'updatedAt': row.updatedAt.toUtc().toIso8601String(),
  };

  static List<Object?> _teamCsv(TeamRecord row) => [
    row.id,
    row.name,
    row.teamType,
    row.archived,
    row.createdAt.toUtc().toIso8601String(),
    row.updatedAt.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _playerJson(PlayerRecord row) => {
    'id': row.id,
    'teamId': row.teamId,
    'name': row.name,
    'gender': row.gender,
    'number': row.number,
    'position': row.position,
    'archived': row.archived,
    'createdAt': row.createdAt.toUtc().toIso8601String(),
    'updatedAt': row.updatedAt.toUtc().toIso8601String(),
  };

  static List<Object?> _playerCsv(PlayerRecord row) => [
    row.id,
    row.teamId,
    row.name,
    row.gender,
    row.number,
    row.position,
    row.archived,
    row.createdAt.toUtc().toIso8601String(),
    row.updatedAt.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _eventJson(CompetitionEventRecord row) => {
    'id': row.id,
    'teamId': row.teamId,
    'name': row.name,
    'startDate': row.startDate?.toUtc().toIso8601String(),
    'endDate': row.endDate?.toUtc().toIso8601String(),
    'location': row.location,
    'notes': row.notes,
    'archived': row.archived,
    'createdAt': row.createdAt.toUtc().toIso8601String(),
    'updatedAt': row.updatedAt.toUtc().toIso8601String(),
  };

  static List<Object?> _eventCsv(CompetitionEventRecord row) => [
    row.id,
    row.teamId,
    row.name,
    row.startDate?.toUtc().toIso8601String(),
    row.endDate?.toUtc().toIso8601String(),
    row.location,
    row.notes,
    row.archived,
    row.createdAt.toUtc().toIso8601String(),
    row.updatedAt.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _eventRosterJson(EventRosterRecord row) => {
    'eventId': row.eventId,
    'playerId': row.playerId,
    'addedAt': row.addedAt.toUtc().toIso8601String(),
  };

  static List<Object?> _eventRosterCsv(EventRosterRecord row) => [
    row.eventId,
    row.playerId,
    row.addedAt.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _lineJson(LinePresetRecord row) => {
    'id': row.id,
    'eventId': row.eventId,
    'name': row.name,
    'createdAt': row.createdAt.toUtc().toIso8601String(),
    'updatedAt': row.updatedAt.toUtc().toIso8601String(),
  };

  static List<Object?> _lineCsv(LinePresetRecord row) => [
    row.id,
    row.eventId,
    row.name,
    row.createdAt.toUtc().toIso8601String(),
    row.updatedAt.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _lineMemberJson(LinePresetMemberRecord row) => {
    'lineId': row.lineId,
    'playerId': row.playerId,
  };

  static List<Object?> _lineMemberCsv(LinePresetMemberRecord row) => [
    row.lineId,
    row.playerId,
  ];

  static Map<String, Object?> _gameJson(GameRecord row) => {
    'id': row.id,
    'eventId': row.eventId,
    'teamId': row.teamId,
    'teamName': row.teamName,
    'teamType': row.teamType,
    'opponentName': row.opponentName,
    'openingMode': row.openingMode,
    'softCapMinutes': row.softCapMinutes,
    'totalCapMinutes': row.totalCapMinutes,
    'maxPoints': row.maxPoints,
    'firstRatio': row.firstRatio,
    'status': row.status,
    'createdAt': row.createdAt.toUtc().toIso8601String(),
    'startedAt': row.startedAt?.toUtc().toIso8601String(),
    'completedAt': row.completedAt?.toUtc().toIso8601String(),
  };

  static List<Object?> _gameCsv(GameRecord row) => [
    row.id,
    row.eventId,
    row.teamId,
    row.teamName,
    row.teamType,
    row.opponentName,
    row.openingMode,
    row.softCapMinutes,
    row.totalCapMinutes,
    row.maxPoints,
    row.firstRatio,
    row.status,
    row.createdAt.toUtc().toIso8601String(),
    row.startedAt?.toUtc().toIso8601String(),
    row.completedAt?.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _snapshotJson(GameRosterRecord row) => {
    'id': row.id,
    'gameId': row.gameId,
    'playerId': row.playerId,
    'name': row.name,
    'gender': row.gender,
    'number': row.number,
    'position': row.position,
    'archivedAtStart': row.archivedAtStart,
  };

  static List<Object?> _snapshotCsv(GameRosterRecord row) => [
    row.id,
    row.gameId,
    row.playerId,
    row.name,
    row.gender,
    row.number,
    row.position,
    row.archivedAtStart,
  ];

  static Map<String, Object?> _pointJson(PointRecordRow row) => {
    'id': row.id,
    'gameId': row.gameId,
    'pointNumber': row.pointNumber,
    'createdAt': row.createdAt.toUtc().toIso8601String(),
  };

  static List<Object?> _pointCsv(PointRecordRow row) => [
    row.id,
    row.gameId,
    row.pointNumber,
    row.createdAt.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _participantJson(PointParticipantRecord row) => {
    'id': row.id,
    'pointId': row.pointId,
    'gameRosterId': row.gameRosterId,
    'displayOrder': row.displayOrder,
    'unknown': row.unknown,
  };

  static List<Object?> _participantCsv(PointParticipantRecord row) => [
    row.id,
    row.pointId,
    row.gameRosterId,
    row.displayOrder,
    row.unknown,
  ];

  static Map<String, Object?> _actionJson(RecordedActionRecord row) => {
    'id': row.id,
    'gameId': row.gameId,
    'pointId': row.pointId,
    'sequence': row.sequence,
    'kind': row.kind,
    'actorParticipantId': row.actorParticipantId,
    'targetParticipantId': row.targetParticipantId,
    'relatedActionId': row.relatedActionId,
    'createdAt': row.createdAt.toUtc().toIso8601String(),
    'voidedAt': row.voidedAt?.toUtc().toIso8601String(),
  };

  static List<Object?> _actionCsv(RecordedActionRecord row) => [
    row.id,
    row.gameId,
    row.pointId,
    row.sequence,
    row.kind,
    row.actorParticipantId,
    row.targetParticipantId,
    row.relatedActionId,
    row.createdAt.toUtc().toIso8601String(),
    row.voidedAt?.toUtc().toIso8601String(),
  ];

  static Map<String, Object?> _settingJson(AppSettingRecord row) => {
    'key': row.key,
    'value': row.value,
  };

  static List<Object?> _settingCsv(AppSettingRecord row) => [
    row.key,
    row.value,
  ];
}
