import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:file_selector/file_selector.dart' as selector;

import '../domain/app_error.dart';
import '../domain/models.dart';
import 'database.dart';

class BackupPreview {
  const BackupPreview({
    required this.exportedAt,
    required this.teamCount,
    required this.playerCount,
    required this.eventCount,
    required this.gameCount,
    required this.actionCount,
  });

  final DateTime exportedAt;
  final int teamCount;
  final int playerCount;
  final int eventCount;
  final int gameCount;
  final int actionCount;
}

class BackupCandidate {
  const BackupCandidate({required this.bytes, required this.preview});

  final Uint8List bytes;
  final BackupPreview preview;
}

class ImportService {
  ImportService(this.database);

  final AppDatabase database;

  Future<BackupCandidate?> chooseBackup() async {
    final file = await selector.openFile(
      acceptedTypeGroups: const [
        selector.XTypeGroup(
          label: 'Ultimate Box Score backup',
          extensions: ['zip'],
        ),
      ],
    );
    if (file == null) return null;
    final bytes = await file.readAsBytes();
    return inspect(bytes);
  }

  BackupCandidate inspect(Uint8List bytes) {
    final data = _BackupData.decode(bytes);
    return BackupCandidate(bytes: bytes, preview: data.preview);
  }

  Future<void> restore(Uint8List bytes) async {
    final data = _BackupData.decode(bytes);
    await database.transaction(() async {
      await database.batch((batch) {
        batch
          ..deleteAll(database.recordedActionEntries)
          ..deleteAll(database.pointParticipantEntries)
          ..deleteAll(database.pointEntries)
          ..deleteAll(database.gameRosterEntries)
          ..deleteAll(database.gameEntries)
          ..deleteAll(database.linePresetMemberEntries)
          ..deleteAll(database.linePresetEntries)
          ..deleteAll(database.eventRosterEntries)
          ..deleteAll(database.competitionEventEntries)
          ..deleteAll(database.playerEntries)
          ..deleteAll(database.teamEntries)
          ..deleteAll(database.appSettingEntries)
          ..insertAll(database.teamEntries, data.teams)
          ..insertAll(database.playerEntries, data.players)
          ..insertAll(database.competitionEventEntries, data.events)
          ..insertAll(database.eventRosterEntries, data.eventRoster)
          ..insertAll(database.linePresetEntries, data.lines)
          ..insertAll(database.linePresetMemberEntries, data.lineMembers)
          ..insertAll(database.gameEntries, data.games)
          ..insertAll(database.gameRosterEntries, data.snapshots)
          ..insertAll(database.pointEntries, data.points)
          ..insertAll(database.pointParticipantEntries, data.participants)
          ..insertAll(database.recordedActionEntries, data.actions)
          ..insertAll(database.appSettingEntries, data.settings);
      });
    });
  }
}

class _BackupData {
  const _BackupData({
    required this.preview,
    required this.teams,
    required this.players,
    required this.events,
    required this.eventRoster,
    required this.lines,
    required this.lineMembers,
    required this.games,
    required this.snapshots,
    required this.points,
    required this.participants,
    required this.actions,
    required this.settings,
  });

  final BackupPreview preview;
  final List<TeamRecord> teams;
  final List<PlayerRecord> players;
  final List<CompetitionEventRecord> events;
  final List<EventRosterRecord> eventRoster;
  final List<LinePresetRecord> lines;
  final List<LinePresetMemberRecord> lineMembers;
  final List<GameRecord> games;
  final List<GameRosterRecord> snapshots;
  final List<PointRecordRow> points;
  final List<PointParticipantRecord> participants;
  final List<RecordedActionRecord> actions;
  final List<AppSettingRecord> settings;

  static _BackupData decode(Uint8List bytes) {
    try {
      final archive = ZipDecoder().decodeBytes(bytes, verify: true);
      final file = archive.findFile('data.json');
      if (file == null) throw const FormatException('Missing data.json');
      final raw = jsonDecode(utf8.decode(file.readBytes()!));
      if (raw is! Map) throw const FormatException('Invalid data root');
      return _BackupData.fromJson(Map<String, dynamic>.from(raw));
    } on AppException {
      rethrow;
    } catch (_) {
      throw const AppException(AppErrorCode.invalidBackup);
    }
  }

  factory _BackupData.fromJson(Map<String, dynamic> data) {
    final manifest = _map(data, 'manifest');
    if (_string(manifest, 'app') != 'ultimate_box_score') {
      throw const AppException(AppErrorCode.invalidBackup);
    }
    if (_integer(manifest, 'formatVersion') != 2) {
      throw const AppException(AppErrorCode.unsupportedBackup);
    }
    if (_string(manifest, 'scope') != ExportScopeKind.all.name) {
      throw const AppException(AppErrorCode.backupMustContainAllData);
    }
    final exportedAt = _date(manifest, 'exportedAt');

    final teamMaps = _maps(data, 'teams');
    final playerMaps = _maps(data, 'players');
    final eventMaps = _maps(data, 'events');
    final eventRosterMaps = _maps(data, 'eventRoster');
    final lineMaps = _maps(data, 'lines');
    final lineMemberMaps = _maps(data, 'lineMembers');
    final gameMaps = _maps(data, 'games');
    final snapshotMaps = _maps(data, 'gameRosterSnapshots');
    final pointMaps = _maps(data, 'points');
    final participantMaps = _maps(data, 'pointParticipants');
    final actionMaps = _maps(data, 'actions');
    final settingMaps = _maps(data, 'appSettings');

    final teams = [
      for (final row in teamMaps)
        TeamRecord(
          id: _string(row, 'id'),
          name: _string(row, 'name'),
          teamType: _enumName<TeamType>(row, 'teamType', TeamType.values),
          archived: _boolean(row, 'archived'),
          createdAt: _date(row, 'createdAt'),
          updatedAt: _date(row, 'updatedAt'),
        ),
    ];
    final players = [
      for (final row in playerMaps)
        PlayerRecord(
          id: _string(row, 'id'),
          teamId: _string(row, 'teamId'),
          name: _string(row, 'name'),
          gender: _enumName<PlayerGender>(row, 'gender', PlayerGender.values),
          number: _nullableString(row, 'number'),
          position: _enumName<PlayerPosition>(
            row,
            'position',
            PlayerPosition.values,
          ),
          archived: _boolean(row, 'archived'),
          createdAt: _date(row, 'createdAt'),
          updatedAt: _date(row, 'updatedAt'),
        ),
    ];
    final events = [
      for (final row in eventMaps)
        CompetitionEventRecord(
          id: _string(row, 'id'),
          teamId: _string(row, 'teamId'),
          name: _string(row, 'name'),
          startDate: _nullableDate(row, 'startDate'),
          endDate: _nullableDate(row, 'endDate'),
          location: _nullableString(row, 'location'),
          notes: _nullableString(row, 'notes'),
          archived: _boolean(row, 'archived'),
          createdAt: _date(row, 'createdAt'),
          updatedAt: _date(row, 'updatedAt'),
        ),
    ];
    final eventRoster = [
      for (final row in eventRosterMaps)
        EventRosterRecord(
          eventId: _string(row, 'eventId'),
          playerId: _string(row, 'playerId'),
          addedAt: _date(row, 'addedAt'),
        ),
    ];
    final lines = [
      for (final row in lineMaps)
        LinePresetRecord(
          id: _string(row, 'id'),
          eventId: _string(row, 'eventId'),
          name: _string(row, 'name'),
          createdAt: _date(row, 'createdAt'),
          updatedAt: _date(row, 'updatedAt'),
        ),
    ];
    final lineMembers = [
      for (final row in lineMemberMaps)
        LinePresetMemberRecord(
          lineId: _string(row, 'lineId'),
          playerId: _string(row, 'playerId'),
        ),
    ];
    final games = [
      for (final row in gameMaps)
        GameRecord(
          id: _string(row, 'id'),
          eventId: _string(row, 'eventId'),
          teamId: _string(row, 'teamId'),
          teamName: _string(row, 'teamName'),
          teamType: _enumName<TeamType>(row, 'teamType', TeamType.values),
          opponentName: _string(row, 'opponentName'),
          openingMode: _enumName<PossessionMode>(
            row,
            'openingMode',
            PossessionMode.values,
          ),
          softCapMinutes: _nullableInteger(row, 'softCapMinutes'),
          totalCapMinutes: _nullableInteger(row, 'totalCapMinutes'),
          maxPoints: _nullableInteger(row, 'maxPoints'),
          firstRatio: _nullableEnumName<GenderRatio>(
            row,
            'firstRatio',
            GenderRatio.values,
          ),
          status: _enumName<GameStatus>(row, 'status', GameStatus.values),
          createdAt: _date(row, 'createdAt'),
          startedAt: _nullableDate(row, 'startedAt'),
          completedAt: _nullableDate(row, 'completedAt'),
          softCapAcknowledged: _optionalBoolean(row, 'softCapAcknowledged'),
          totalCapAcknowledged: _optionalBoolean(row, 'totalCapAcknowledged'),
        ),
    ];
    final snapshots = [
      for (final row in snapshotMaps)
        GameRosterRecord(
          id: _string(row, 'id'),
          gameId: _string(row, 'gameId'),
          playerId: _string(row, 'playerId'),
          name: _string(row, 'name'),
          gender: _enumName<PlayerGender>(row, 'gender', PlayerGender.values),
          number: _nullableString(row, 'number'),
          position: _enumName<PlayerPosition>(
            row,
            'position',
            PlayerPosition.values,
          ),
          archivedAtStart: _boolean(row, 'archivedAtStart'),
        ),
    ];
    final points = [
      for (final row in pointMaps)
        PointRecordRow(
          id: _string(row, 'id'),
          gameId: _string(row, 'gameId'),
          pointNumber: _integer(row, 'pointNumber'),
          createdAt: _date(row, 'createdAt'),
        ),
    ];
    final participants = [
      for (final row in participantMaps)
        PointParticipantRecord(
          id: _string(row, 'id'),
          pointId: _string(row, 'pointId'),
          gameRosterId: _nullableString(row, 'gameRosterId'),
          displayOrder: _integer(row, 'displayOrder'),
          unknown: _boolean(row, 'unknown'),
        ),
    ];
    final actions = [
      for (final row in actionMaps)
        RecordedActionRecord(
          id: _string(row, 'id'),
          gameId: _string(row, 'gameId'),
          pointId: _nullableString(row, 'pointId'),
          sequence: _integer(row, 'sequence'),
          kind: _enumName<RecordedActionKind>(
            row,
            'kind',
            RecordedActionKind.values,
          ),
          actorParticipantId: _nullableString(row, 'actorParticipantId'),
          targetParticipantId: _nullableString(row, 'targetParticipantId'),
          relatedActionId: _nullableString(row, 'relatedActionId'),
          createdAt: _date(row, 'createdAt'),
        ),
    ];
    final gameIds = games.map((row) => row.id).toSet();
    final settings = [
      for (final row in settingMaps)
        if (_string(row, 'key') != 'selectedGameId' ||
            gameIds.contains(_nullableString(row, 'value')))
          AppSettingRecord(
            key: _string(row, 'key'),
            value: _nullableString(row, 'value'),
          ),
    ];

    _validateRelations(
      teams: teams,
      players: players,
      events: events,
      eventRoster: eventRoster,
      lines: lines,
      lineMembers: lineMembers,
      games: games,
      snapshots: snapshots,
      points: points,
      participants: participants,
      actions: actions,
      settings: settings,
    );

    return _BackupData(
      preview: BackupPreview(
        exportedAt: exportedAt,
        teamCount: teams.length,
        playerCount: players.length,
        eventCount: events.length,
        gameCount: games.length,
        actionCount: actions.length,
      ),
      teams: teams,
      players: players,
      events: events,
      eventRoster: eventRoster,
      lines: lines,
      lineMembers: lineMembers,
      games: games,
      snapshots: snapshots,
      points: points,
      participants: participants,
      actions: actions,
      settings: settings,
    );
  }
}

void _validateRelations({
  required List<TeamRecord> teams,
  required List<PlayerRecord> players,
  required List<CompetitionEventRecord> events,
  required List<EventRosterRecord> eventRoster,
  required List<LinePresetRecord> lines,
  required List<LinePresetMemberRecord> lineMembers,
  required List<GameRecord> games,
  required List<GameRosterRecord> snapshots,
  required List<PointRecordRow> points,
  required List<PointParticipantRecord> participants,
  required List<RecordedActionRecord> actions,
  required List<AppSettingRecord> settings,
}) {
  final teamIds = _unique(teams.map((row) => row.id));
  final playerIds = _unique(players.map((row) => row.id));
  final eventIds = _unique(events.map((row) => row.id));
  final lineIds = _unique(lines.map((row) => row.id));
  final gameIds = _unique(games.map((row) => row.id));
  _unique(snapshots.map((row) => row.id));
  _unique(snapshots.map((row) => '${row.gameId}:${row.playerId}'));
  _unique(points.map((row) => row.id));
  _unique(participants.map((row) => row.id));
  final actionIds = _unique(actions.map((row) => row.id));
  _unique(settings.map((row) => row.key));
  _unique(eventRoster.map((row) => '${row.eventId}:${row.playerId}'));
  _unique(lineMembers.map((row) => '${row.lineId}:${row.playerId}'));

  final eventsById = {for (final row in events) row.id: row};
  final snapshotsById = {for (final row in snapshots) row.id: row};
  final pointsById = {for (final row in points) row.id: row};
  final participantsById = {for (final row in participants) row.id: row};
  bool invalid =
      players.any((row) => !teamIds.contains(row.teamId)) ||
      events.any((row) => !teamIds.contains(row.teamId)) ||
      eventRoster.any(
        (row) =>
            !eventIds.contains(row.eventId) ||
            !playerIds.contains(row.playerId),
      ) ||
      lines.any((row) => !eventIds.contains(row.eventId)) ||
      lineMembers.any(
        (row) =>
            !lineIds.contains(row.lineId) || !playerIds.contains(row.playerId),
      ) ||
      games.any(
        (row) =>
            !eventIds.contains(row.eventId) || !teamIds.contains(row.teamId),
      ) ||
      snapshots.any((row) => !gameIds.contains(row.gameId)) ||
      points.any((row) => !gameIds.contains(row.gameId)) ||
      participants.any((row) {
        final point = pointsById[row.pointId];
        final snapshot = row.gameRosterId == null
            ? null
            : snapshotsById[row.gameRosterId];
        return point == null ||
            row.unknown != (row.gameRosterId == null) ||
            (snapshot != null && snapshot.gameId != point.gameId) ||
            (row.gameRosterId != null && snapshot == null);
      });
  final sequenceKeys = <String>{};
  for (final action in actions) {
    final point = action.pointId == null ? null : pointsById[action.pointId];
    final actor = action.actorParticipantId == null
        ? null
        : participantsById[action.actorParticipantId];
    final target = action.targetParticipantId == null
        ? null
        : participantsById[action.targetParticipantId];
    if (!gameIds.contains(action.gameId) ||
        !sequenceKeys.add('${action.gameId}:${action.sequence}') ||
        (point != null && point.gameId != action.gameId) ||
        (action.pointId != null && point == null) ||
        (actor != null && actor.pointId != action.pointId) ||
        (target != null && target.pointId != action.pointId) ||
        (action.actorParticipantId != null && actor == null) ||
        (action.targetParticipantId != null && target == null) ||
        (action.relatedActionId != null &&
            !actionIds.contains(action.relatedActionId)) ||
        (action.kind == RecordedActionKind.substitution.name &&
            (actor == null || target == null || actor.id == target.id))) {
      invalid = true;
    }
  }
  if (games.where((row) => row.status == GameStatus.inProgress.name).length >
      1) {
    invalid = true;
  }
  for (final game in games) {
    final event = eventsById[game.eventId];
    if (event == null || event.teamId != game.teamId) {
      invalid = true;
    }
  }
  if (invalid) throw const AppException(AppErrorCode.invalidBackup);
}

Set<String> _unique(Iterable<String> values) {
  final result = <String>{};
  for (final value in values) {
    if (value.isEmpty || !result.add(value)) {
      throw const AppException(AppErrorCode.invalidBackup);
    }
  }
  return result;
}

Map<String, dynamic> _map(Map<String, dynamic> source, String key) {
  final value = source[key];
  if (value is! Map) throw const FormatException();
  return Map<String, dynamic>.from(value);
}

List<Map<String, dynamic>> _maps(Map<String, dynamic> source, String key) {
  final value = source[key];
  if (value is! List) throw const FormatException();
  return [
    for (final item in value)
      if (item is Map)
        Map<String, dynamic>.from(item)
      else
        throw const FormatException(),
  ];
}

String _string(Map<String, dynamic> row, String key) {
  final value = row[key];
  if (value is! String) throw const FormatException();
  return value;
}

String? _nullableString(Map<String, dynamic> row, String key) {
  final value = row[key];
  if (value == null) return null;
  if (value is! String) throw const FormatException();
  return value;
}

int _integer(Map<String, dynamic> row, String key) {
  final value = row[key];
  if (value is! int) throw const FormatException();
  return value;
}

int? _nullableInteger(Map<String, dynamic> row, String key) {
  final value = row[key];
  if (value == null) return null;
  if (value is! int) throw const FormatException();
  return value;
}

bool _boolean(Map<String, dynamic> row, String key) {
  final value = row[key];
  if (value is! bool) throw const FormatException();
  return value;
}

bool _optionalBoolean(Map<String, dynamic> row, String key) {
  if (!row.containsKey(key)) return false;
  return _boolean(row, key);
}

DateTime _date(Map<String, dynamic> row, String key) {
  final value = DateTime.tryParse(_string(row, key));
  if (value == null) throw const FormatException();
  return value;
}

DateTime? _nullableDate(Map<String, dynamic> row, String key) {
  final raw = _nullableString(row, key);
  if (raw == null) return null;
  final value = DateTime.tryParse(raw);
  if (value == null) throw const FormatException();
  return value;
}

String _enumName<T extends Enum>(
  Map<String, dynamic> row,
  String key,
  Iterable<T> values,
) {
  final value = _string(row, key);
  if (!values.any((item) => item.name == value)) {
    throw const FormatException();
  }
  return value;
}

String? _nullableEnumName<T extends Enum>(
  Map<String, dynamic> row,
  String key,
  Iterable<T> values,
) {
  final value = _nullableString(row, key);
  if (value == null) return null;
  if (!values.any((item) => item.name == value)) {
    throw const FormatException();
  }
  return value;
}
