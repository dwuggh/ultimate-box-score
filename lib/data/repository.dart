import 'package:drift/drift.dart';

import '../domain/models.dart';
import '../domain/recording.dart';
import 'database.dart';
import 'id_factory.dart';

String? _optionalText(String? value) {
  final normalized = value?.trim();
  return normalized == null || normalized.isEmpty ? null : normalized;
}

class EventSaveRequest {
  const EventSaveRequest({
    required this.teamId,
    required this.name,
    this.startDate,
    this.endDate,
    this.location,
    this.notes,
  });

  final String teamId;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? notes;
}

class GameDraftRequest {
  const GameDraftRequest({
    required this.eventId,
    required this.opponentName,
    required this.openingMode,
    this.softCapMinutes,
    this.totalCapMinutes,
    this.maxPoints,
    this.firstRatio,
  });

  final String eventId;
  final String opponentName;
  final PossessionMode openingMode;
  final int? softCapMinutes;
  final int? totalCapMinutes;
  final int? maxPoints;
  final GenderRatio? firstRatio;
}

class TeamRepository {
  TeamRepository(this.database);

  final AppDatabase database;

  Stream<List<Team>> watchTeams() {
    final query = database.select(database.teamEntries)
      ..orderBy([
        (row) => OrderingTerm.asc(row.archived),
        (row) => OrderingTerm.asc(row.name),
      ]);
    return query.watch().map((rows) => rows.map(_teamFromRecord).toList());
  }

  Future<Team?> getTeam(String id) async {
    final record = await (database.select(
      database.teamEntries,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    return record == null ? null : _teamFromRecord(record);
  }

  Future<String> saveTeam({
    String? id,
    required String name,
    required TeamType type,
  }) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) throw ArgumentError('队伍名称不能为空');
    final teamId = id ?? newId();
    final now = DateTime.now();
    final existing = id == null
        ? null
        : await (database.select(
            database.teamEntries,
          )..where((row) => row.id.equals(teamId))).getSingleOrNull();
    await database
        .into(database.teamEntries)
        .insertOnConflictUpdate(
          TeamEntriesCompanion.insert(
            id: teamId,
            name: normalizedName,
            teamType: type.name,
            archived: Value(existing?.archived ?? false),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
    return teamId;
  }

  Future<void> setTeamArchived(String id, bool archived) async {
    await (database.update(
      database.teamEntries,
    )..where((row) => row.id.equals(id))).write(
      TeamEntriesCompanion(
        archived: Value(archived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<List<Player>> watchPlayers(String teamId) {
    final query = database.select(database.playerEntries)
      ..where((row) => row.teamId.equals(teamId));
    return query.watch().map((rows) {
      final players = rows.map(_playerFromRecord).toList();
      players.sort(comparePlayers);
      return players;
    });
  }

  Future<List<Player>> getPlayers(String teamId) async {
    final records = await (database.select(
      database.playerEntries,
    )..where((row) => row.teamId.equals(teamId))).get();
    final players = records.map(_playerFromRecord).toList();
    players.sort(comparePlayers);
    return players;
  }

  Future<String> savePlayer({
    String? id,
    required String teamId,
    required String name,
    required PlayerGender gender,
    required PlayerPosition position,
    String? number,
  }) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) throw ArgumentError('球员姓名不能为空');
    if (await getTeam(teamId) == null) throw StateError('队伍不存在');
    final playerId = id ?? newId();
    final now = DateTime.now();
    final existing = id == null
        ? null
        : await (database.select(
            database.playerEntries,
          )..where((row) => row.id.equals(playerId))).getSingleOrNull();
    await database
        .into(database.playerEntries)
        .insertOnConflictUpdate(
          PlayerEntriesCompanion.insert(
            id: playerId,
            teamId: teamId,
            name: normalizedName,
            gender: gender.name,
            number: Value(_optionalText(number)),
            position: position.name,
            archived: Value(existing?.archived ?? false),
            createdAt: existing?.createdAt ?? now,
            updatedAt: now,
          ),
        );
    return playerId;
  }

  Future<void> setPlayerArchived(String id, bool archived) async {
    await (database.update(
      database.playerEntries,
    )..where((row) => row.id.equals(id))).write(
      PlayerEntriesCompanion(
        archived: Value(archived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  static int comparePlayers(Player a, Player b) {
    final archived = a.archived == b.archived ? 0 : (a.archived ? 1 : -1);
    if (archived != 0) return archived;
    return compareJerseyAndName(
      numberA: a.number,
      nameA: a.name,
      numberB: b.number,
      nameB: b.name,
    );
  }

  static Team _teamFromRecord(TeamRecord record) => Team(
    id: record.id,
    name: record.name,
    type: enumByName(TeamType.values, record.teamType),
    archived: record.archived,
  );

  static Player _playerFromRecord(PlayerRecord record) => Player(
    id: record.id,
    teamId: record.teamId,
    name: record.name,
    gender: enumByName(PlayerGender.values, record.gender),
    number: record.number,
    position: enumByName(PlayerPosition.values, record.position),
    archived: record.archived,
  );
}

class EventRepository {
  EventRepository(this.database, this.teams);

  final AppDatabase database;
  final TeamRepository teams;

  Stream<List<CompetitionEvent>> watchEvents() {
    final query = database.select(database.competitionEventEntries)
      ..orderBy([
        (row) => OrderingTerm.asc(row.archived),
        (row) => OrderingTerm.desc(row.startDate),
        (row) => OrderingTerm.desc(row.createdAt),
      ]);
    return query.watch().map((rows) => rows.map(_eventFromRecord).toList());
  }

  Stream<EventBundle> watchEventBundle(String eventId) {
    return database
        .customSelect(
          'SELECT 1',
          readsFrom: {
            database.competitionEventEntries,
            database.teamEntries,
            database.playerEntries,
            database.eventRosterEntries,
            database.linePresetEntries,
            database.linePresetMemberEntries,
            database.gameEntries,
          },
        )
        .watch()
        .asyncMap((_) => getEventBundle(eventId));
  }

  Future<CompetitionEvent?> getEvent(String id) async {
    final record = await (database.select(
      database.competitionEventEntries,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    return record == null ? null : _eventFromRecord(record);
  }

  Future<String> saveEvent(EventSaveRequest request, {String? id}) async {
    final normalizedName = request.name.trim();
    if (normalizedName.isEmpty) throw ArgumentError('活动名称不能为空');
    if (request.startDate != null &&
        request.endDate != null &&
        request.endDate!.isBefore(request.startDate!)) {
      throw ArgumentError('结束日期不能早于开始日期');
    }
    final eventId = id ?? newId();
    final now = DateTime.now();
    final existing = id == null
        ? null
        : await (database.select(
            database.competitionEventEntries,
          )..where((row) => row.id.equals(eventId))).getSingleOrNull();
    final team = await teams.getTeam(request.teamId);
    final keepsExistingTeam = existing?.teamId == request.teamId;
    if (team == null || (team.archived && !keepsExistingTeam)) {
      throw StateError('请选择有效队伍');
    }
    if (existing != null && existing.teamId != request.teamId) {
      final games = await (database.select(
        database.gameEntries,
      )..where((row) => row.eventId.equals(eventId))).get();
      if (games.isNotEmpty) throw StateError('已有比赛的活动不能更换队伍');
    }

    await database.transaction(() async {
      await database
          .into(database.competitionEventEntries)
          .insertOnConflictUpdate(
            CompetitionEventEntriesCompanion.insert(
              id: eventId,
              teamId: request.teamId,
              name: normalizedName,
              startDate: Value(request.startDate),
              endDate: Value(request.endDate),
              location: Value(_optionalText(request.location)),
              notes: Value(_optionalText(request.notes)),
              archived: Value(existing?.archived ?? false),
              createdAt: existing?.createdAt ?? now,
              updatedAt: now,
            ),
          );
      if (existing == null || existing.teamId != request.teamId) {
        await (database.delete(
          database.eventRosterEntries,
        )..where((row) => row.eventId.equals(eventId))).go();
        final players = (await teams.getPlayers(request.teamId))
            .where((player) => !player.archived);
        for (final player in players) {
          await database
              .into(database.eventRosterEntries)
              .insert(
                EventRosterEntriesCompanion.insert(
                  eventId: eventId,
                  playerId: player.id,
                  addedAt: now,
                ),
              );
        }
      }
    });
    return eventId;
  }

  Future<void> setRoster(String eventId, Set<String> playerIds) async {
    final event = await getEvent(eventId);
    if (event == null) throw StateError('活动不存在');
    final validPlayers = await teams.getPlayers(event.teamId);
    final validIds = validPlayers.map((player) => player.id).toSet();
    if (!validIds.containsAll(playerIds)) throw StateError('活动阵容包含其他队伍的球员');
    final existing = await (database.select(
      database.eventRosterEntries,
    )..where((row) => row.eventId.equals(eventId))).get();
    final existingIds = existing.map((row) => row.playerId).toSet();
    final removed = existingIds.difference(playerIds);
    final added = playerIds.difference(existingIds);

    await database.transaction(() async {
      if (removed.isNotEmpty) {
        final lines = await (database.select(
          database.linePresetEntries,
        )..where((row) => row.eventId.equals(eventId))).get();
        final lineIds = lines.map((line) => line.id).toList();
        if (lineIds.isNotEmpty) {
          await (database.delete(database.linePresetMemberEntries)..where(
                (row) => row.lineId.isIn(lineIds) & row.playerId.isIn(removed),
              ))
              .go();
        }
        await (database.delete(database.eventRosterEntries)..where(
              (row) => row.eventId.equals(eventId) & row.playerId.isIn(removed),
            ))
            .go();
      }
      final now = DateTime.now();
      for (final playerId in added) {
        await database
            .into(database.eventRosterEntries)
            .insert(
              EventRosterEntriesCompanion.insert(
                eventId: eventId,
                playerId: playerId,
                addedAt: now,
              ),
            );
      }
    });
  }

  Future<String> saveLine({
    String? id,
    required String eventId,
    required String name,
    required Set<String> playerIds,
  }) async {
    final normalizedName = name.trim();
    if (normalizedName.isEmpty) throw ArgumentError('阵线名称不能为空');
    final roster = await (database.select(
      database.eventRosterEntries,
    )..where((row) => row.eventId.equals(eventId))).get();
    final rosterIds = roster.map((row) => row.playerId).toSet();
    if (!rosterIds.containsAll(playerIds)) throw StateError('阵线只能包含活动阵容球员');
    final existingLines = await (database.select(
      database.linePresetEntries,
    )..where((row) => row.eventId.equals(eventId))).get();
    if (existingLines.any(
      (line) =>
          line.id != id &&
          line.name.toLowerCase() == normalizedName.toLowerCase(),
    )) {
      throw ArgumentError('阵线名称不能重复');
    }
    final lineId = id ?? newId();
    final now = DateTime.now();
    final existing = id == null
        ? null
        : await (database.select(
            database.linePresetEntries,
          )..where((row) => row.id.equals(lineId))).getSingleOrNull();
    await database.transaction(() async {
      await database
          .into(database.linePresetEntries)
          .insertOnConflictUpdate(
            LinePresetEntriesCompanion.insert(
              id: lineId,
              eventId: eventId,
              name: normalizedName,
              createdAt: existing?.createdAt ?? now,
              updatedAt: now,
            ),
          );
      await (database.delete(
        database.linePresetMemberEntries,
      )..where((row) => row.lineId.equals(lineId))).go();
      for (final playerId in playerIds) {
        await database
            .into(database.linePresetMemberEntries)
            .insert(
              LinePresetMemberEntriesCompanion.insert(
                lineId: lineId,
                playerId: playerId,
              ),
            );
      }
    });
    return lineId;
  }

  Future<void> deleteLine(String id) async {
    await (database.delete(
      database.linePresetEntries,
    )..where((row) => row.id.equals(id))).go();
  }

  Future<void> setArchived(String id, bool archived) async {
    await (database.update(
      database.competitionEventEntries,
    )..where((row) => row.id.equals(id))).write(
      CompetitionEventEntriesCompanion(
        archived: Value(archived),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteEmptyEvent(String id) async {
    final game =
        await (database.select(database.gameEntries)
              ..where((row) => row.eventId.equals(id))
              ..limit(1))
            .getSingleOrNull();
    if (game != null) throw StateError('只能永久删除没有比赛的活动');
    await (database.delete(
      database.competitionEventEntries,
    )..where((row) => row.id.equals(id))).go();
  }

  Future<EventBundle> getEventBundle(String eventId) async {
    final eventRecord = await (database.select(
      database.competitionEventEntries,
    )..where((row) => row.id.equals(eventId))).getSingleOrNull();
    if (eventRecord == null) throw StateError('活动不存在');
    final event = _eventFromRecord(eventRecord);
    final team = await teams.getTeam(event.teamId);
    if (team == null) throw StateError('活动队伍不存在');
    final teamPlayers = await teams.getPlayers(event.teamId);
    final rosterRecords = await (database.select(
      database.eventRosterEntries,
    )..where((row) => row.eventId.equals(eventId))).get();
    final rosterIds = rosterRecords.map((row) => row.playerId).toSet();
    final roster = teamPlayers
        .where((player) => rosterIds.contains(player.id))
        .toList();
    final lines = await getLines(eventId, players: teamPlayers);
    final gameRecords =
        await (database.select(database.gameEntries)
              ..where((row) => row.eventId.equals(eventId))
              ..orderBy([
                (row) => OrderingTerm.desc(row.startedAt),
                (row) => OrderingTerm.desc(row.createdAt),
              ]))
            .get();
    return EventBundle(
      event: event,
      team: team,
      teamPlayers: teamPlayers,
      roster: roster,
      lines: lines,
      games: gameRecords.map(GameRepository.gameFromRecord).toList(),
    );
  }

  Future<List<LinePreset>> getLines(
    String eventId, {
    List<Player>? players,
  }) async {
    final lineRecords =
        await (database.select(database.linePresetEntries)
              ..where((row) => row.eventId.equals(eventId))
              ..orderBy([(row) => OrderingTerm.asc(row.name)]))
            .get();
    final memberRecords = lineRecords.isEmpty
        ? <LinePresetMemberRecord>[]
        : await (database.select(database.linePresetMemberEntries)..where(
                (row) => row.lineId.isIn(lineRecords.map((line) => line.id)),
              ))
              .get();
    final availablePlayers =
        players ?? await teams.getPlayers((await getEvent(eventId))!.teamId);
    final playersById = {
      for (final player in availablePlayers) player.id: player,
    };
    return [
      for (final line in lineRecords)
        LinePreset(
          id: line.id,
          eventId: line.eventId,
          name: line.name,
          memberPlayerIds:
              (memberRecords
                  .where((member) => member.lineId == line.id)
                  .map((member) => member.playerId)
                  .toList()
                ..sort((a, b) {
                  final playerA = playersById[a];
                  final playerB = playersById[b];
                  if (playerA == null || playerB == null) {
                    return a.compareTo(b);
                  }
                  return TeamRepository.comparePlayers(playerA, playerB);
                })),
        ),
    ];
  }

  static CompetitionEvent _eventFromRecord(CompetitionEventRecord record) =>
      CompetitionEvent(
        id: record.id,
        teamId: record.teamId,
        name: record.name,
        startDate: record.startDate,
        endDate: record.endDate,
        location: record.location,
        notes: record.notes,
        archived: record.archived,
        createdAt: record.createdAt,
      );
}

class GameRepository {
  GameRepository(this.database, this.events);

  final AppDatabase database;
  final EventRepository events;

  Stream<List<Game>> watchGames() {
    final query = database.select(database.gameEntries)
      ..orderBy([
        (row) => OrderingTerm.asc(row.status),
        (row) => OrderingTerm.desc(row.startedAt),
        (row) => OrderingTerm.desc(row.createdAt),
      ]);
    return query.watch().map((rows) => rows.map(gameFromRecord).toList());
  }

  Stream<GameBundle> watchGameBundle(String gameId) {
    return database
        .customSelect(
          'SELECT 1',
          readsFrom: {
            database.gameEntries,
            database.gameRosterEntries,
            database.pointEntries,
            database.pointParticipantEntries,
            database.recordedActionEntries,
            database.linePresetEntries,
            database.linePresetMemberEntries,
            database.playerEntries,
          },
        )
        .watch()
        .asyncMap((_) => getGameBundle(gameId));
  }

  Stream<Map<String, PlayerStats>> watchTeamStats(String teamId) {
    return database
        .customSelect(
          'SELECT 1',
          readsFrom: {
            database.gameEntries,
            database.gameRosterEntries,
            database.pointEntries,
            database.pointParticipantEntries,
            database.recordedActionEntries,
          },
        )
        .watch()
        .asyncMap((_) => getTeamStats(teamId));
  }

  Stream<String?> watchSelectedGameId() {
    return (database.select(database.appSettingEntries)
          ..where((row) => row.key.equals('selectedGameId')))
        .watchSingleOrNull()
        .map((row) => row?.value);
  }

  Future<void> selectGame(String? gameId) async {
    await database
        .into(database.appSettingEntries)
        .insertOnConflictUpdate(
          AppSettingEntriesCompanion.insert(
            key: 'selectedGameId',
            value: Value(gameId),
          ),
        );
  }

  Future<Game?> getActiveGame() async {
    final record =
        await (database.select(database.gameEntries)
              ..where((row) => row.status.equals(GameStatus.inProgress.name))
              ..limit(1))
            .getSingleOrNull();
    return record == null ? null : gameFromRecord(record);
  }

  Future<String> saveDraft(GameDraftRequest request, {String? id}) async {
    _validateLimits(
      request.softCapMinutes,
      request.totalCapMinutes,
      request.maxPoints,
    );
    final eventBundle = await events.getEventBundle(request.eventId);
    if (eventBundle.event.archived) throw StateError('已归档活动不能新建比赛');
    final normalizedOpponent = request.opponentName.trim();
    final gameId = id ?? newId();
    final existing = id == null
        ? null
        : await (database.select(
            database.gameEntries,
          )..where((row) => row.id.equals(gameId))).getSingleOrNull();
    if (existing != null && existing.status != GameStatus.draft.name) {
      throw StateError('已开始的比赛不能修改这些设置');
    }
    await database
        .into(database.gameEntries)
        .insertOnConflictUpdate(
          GameEntriesCompanion.insert(
            id: gameId,
            eventId: request.eventId,
            teamId: eventBundle.team.id,
            teamName: eventBundle.team.name,
            teamType: eventBundle.team.type.name,
            opponentName: normalizedOpponent.isEmpty
                ? '未命名对手'
                : normalizedOpponent,
            openingMode: request.openingMode.name,
            softCapMinutes: Value(request.softCapMinutes),
            totalCapMinutes: Value(request.totalCapMinutes),
            maxPoints: Value(request.maxPoints),
            firstRatio: Value(request.firstRatio?.name),
            status: GameStatus.draft.name,
            createdAt: existing?.createdAt ?? DateTime.now(),
          ),
        );
    return gameId;
  }

  Future<void> startGame(String gameId) async {
    await database.transaction(() async {
      final gameRecord = await _gameRecord(gameId);
      if (gameRecord.status != GameStatus.draft.name) {
        throw StateError('只能开始尚未开赛的比赛');
      }
      final active =
          await (database.select(database.gameEntries)
                ..where((row) => row.status.equals(GameStatus.inProgress.name))
                ..limit(1))
              .getSingleOrNull();
      if (active != null) {
        throw StateError(
          '已有一场比赛正在记录：${active.teamName} vs ${active.opponentName}',
        );
      }
      final eventBundle = await events.getEventBundle(gameRecord.eventId);
      if (eventBundle.roster.isEmpty) throw StateError('活动阵容为空，无法开始比赛');
      for (final player in eventBundle.roster) {
        await database
            .into(database.gameRosterEntries)
            .insert(
              GameRosterEntriesCompanion.insert(
                id: newId(),
                gameId: gameId,
                playerId: player.id,
                name: player.name,
                gender: player.gender.name,
                number: Value(player.number),
                position: player.position.name,
                archivedAtStart: player.archived,
              ),
            );
      }
      await (database.update(
        database.gameEntries,
      )..where((row) => row.id.equals(gameId))).write(
        GameEntriesCompanion(
          status: Value(GameStatus.inProgress.name),
          startedAt: Value(DateTime.now()),
        ),
      );
      await selectGame(gameId);
    });
  }

  Future<void> updateMutableGame({
    required String gameId,
    required String opponentName,
    int? softCapMinutes,
    int? totalCapMinutes,
    int? maxPoints,
  }) async {
    _validateLimits(softCapMinutes, totalCapMinutes, maxPoints);
    final normalized = opponentName.trim();
    await (database.update(
      database.gameEntries,
    )..where((row) => row.id.equals(gameId))).write(
      GameEntriesCompanion(
        opponentName: Value(normalized.isEmpty ? '未命名对手' : normalized),
        softCapMinutes: Value(softCapMinutes),
        totalCapMinutes: Value(totalCapMinutes),
        maxPoints: Value(maxPoints),
      ),
    );
  }

  Future<void> updateFirstRatio(String gameId, GenderRatio ratio) async {
    await (database.update(database.gameEntries)
          ..where((row) => row.id.equals(gameId)))
        .write(GameEntriesCompanion(firstRatio: Value(ratio.name)));
  }

  Future<void> acknowledgeCap(
    String gameId, {
    bool soft = false,
    bool total = false,
  }) async {
    await (database.update(
      database.gameEntries,
    )..where((row) => row.id.equals(gameId))).write(
      GameEntriesCompanion(
        softCapAcknowledged: soft ? const Value(true) : const Value.absent(),
        totalCapAcknowledged: total ? const Value(true) : const Value.absent(),
      ),
    );
  }

  Future<void> startPoint(String gameId, List<String> rosterIds) async {
    await database.transaction(() async {
      final bundle = await getGameBundle(gameId);
      _requireInProgress(bundle.game);
      if (bundle.state.stage != RecordingStage.betweenPoints) {
        throw StateError('当前不能开始新的一分');
      }
      final selected =
          bundle.roster
              .where((player) => rosterIds.contains(player.id))
              .toList()
            ..sort(_compareSnapshots);
      final pointId = newId();
      await database
          .into(database.pointEntries)
          .insert(
            PointEntriesCompanion.insert(
              id: pointId,
              gameId: gameId,
              pointNumber: bundle.state.nextPointNumber,
              createdAt: DateTime.now(),
            ),
          );
      var order = 0;
      for (final player in selected) {
        await database
            .into(database.pointParticipantEntries)
            .insert(
              PointParticipantEntriesCompanion.insert(
                id: newId(),
                pointId: pointId,
                gameRosterId: Value(player.id),
                displayOrder: order++,
              ),
            );
      }
      await database
          .into(database.pointParticipantEntries)
          .insert(
            PointParticipantEntriesCompanion.insert(
              id: newId(),
              pointId: pointId,
              displayOrder: order,
              unknown: const Value(true),
            ),
          );
      await _insertAction(
        gameId: gameId,
        pointId: pointId,
        kind: RecordedActionKind.startPoint,
      );
    });
  }

  Future<void> startHalftime(String gameId) async {
    final bundle = await getGameBundle(gameId);
    _requireInProgress(bundle.game);
    if (bundle.state.stage != RecordingStage.betweenPoints ||
        bundle.state.halftimeTaken) {
      throw StateError('当前不能进入中场');
    }
    await _insertAction(gameId: gameId, kind: RecordedActionKind.startHalftime);
  }

  Future<void> endHalftime(String gameId) async {
    final bundle = await getGameBundle(gameId);
    if (bundle.state.stage != RecordingStage.halftime) {
      throw StateError('当前不在中场');
    }
    await _insertAction(gameId: gameId, kind: RecordedActionKind.endHalftime);
  }

  Future<void> recordPickup(String gameId, String participantId) {
    return _recordPointAction(
      gameId,
      RecordedActionKind.pickup,
      actorId: participantId,
      allowedStages: {RecordingStage.awaitingPickup},
    );
  }

  Future<void> recordPass(String gameId, String receiverId) async {
    final bundle = await getGameBundle(gameId);
    await _recordPointAction(
      gameId,
      RecordedActionKind.completedPass,
      actorId: bundle.state.holderParticipantId,
      targetId: receiverId,
      allowedStages: {RecordingStage.offense},
      bundle: bundle,
    );
  }

  Future<void> recordReceiverDrop(String gameId, String receiverId) async {
    final bundle = await getGameBundle(gameId);
    await _recordPointAction(
      gameId,
      RecordedActionKind.receiverDrop,
      actorId: bundle.state.holderParticipantId,
      targetId: receiverId,
      allowedStages: {RecordingStage.offense},
      bundle: bundle,
    );
  }

  Future<void> recordPasserTurnover(String gameId) async {
    final bundle = await getGameBundle(gameId);
    await _recordPointAction(
      gameId,
      RecordedActionKind.passerTurnover,
      actorId: bundle.state.holderParticipantId,
      allowedStages: {RecordingStage.offense},
      bundle: bundle,
    );
  }

  Future<void> recordGoalCatch(String gameId, String receiverId) async {
    final bundle = await getGameBundle(gameId);
    await _recordPointAction(
      gameId,
      RecordedActionKind.goalCatch,
      actorId: bundle.state.holderParticipantId,
      targetId: receiverId,
      allowedStages: {RecordingStage.offense},
      bundle: bundle,
      checkTarget: true,
    );
  }

  Future<void> confirmHolderGoal(String gameId) async {
    final bundle = await getGameBundle(gameId);
    if (!bundle.state.canConfirmGoal) throw StateError('当前持盘不是一次可确认的接盘');
    await _recordPointAction(
      gameId,
      RecordedActionKind.confirmGoal,
      actorId: bundle.state.holderParticipantId,
      relatedActionId: bundle.state.lastCatchActionId,
      allowedStages: {RecordingStage.offense},
      bundle: bundle,
      checkTarget: true,
    );
  }

  Future<void> recordDefensiveBlock(String gameId, String participantId) {
    return _recordPointAction(
      gameId,
      RecordedActionKind.defensiveBlock,
      actorId: participantId,
      allowedStages: {RecordingStage.defense},
    );
  }

  Future<void> recordOpponentThrowaway(String gameId) {
    return _recordPointAction(
      gameId,
      RecordedActionKind.opponentThrowaway,
      allowedStages: {RecordingStage.defense},
    );
  }

  Future<void> recordOpponentGoal(String gameId) {
    return _recordPointAction(
      gameId,
      RecordedActionKind.opponentGoal,
      allowedStages: {RecordingStage.defense},
      checkTarget: true,
    );
  }

  Future<void> undoLast(String gameId) async {
    final game = gameFromRecord(await _gameRecord(gameId));
    _requireInProgress(game);
    final last =
        await (database.select(database.recordedActionEntries)
              ..where(
                (row) => row.gameId.equals(gameId) & row.voidedAt.isNull(),
              )
              ..orderBy([(row) => OrderingTerm.desc(row.sequence)])
              ..limit(1))
            .getSingleOrNull();
    if (last == null) return;
    await (database.update(database.recordedActionEntries)
          ..where((row) => row.id.equals(last.id)))
        .write(RecordedActionEntriesCompanion(voidedAt: Value(DateTime.now())));
  }

  Future<void> completeGame(String gameId) async {
    await database.transaction(() async {
      final bundle = await getGameBundle(gameId);
      if (bundle.game.status == GameStatus.completed) return;
      _requireInProgress(bundle.game);
      if (bundle.state.pointInProgress) {
        await _insertAction(
          gameId: gameId,
          pointId: bundle.state.currentPointId,
          kind: RecordedActionKind.abandonPoint,
        );
      }
      await _writeStatus(gameId, GameStatus.completed);
    });
  }

  Future<void> reopenGame(String gameId) async {
    await database.transaction(() async {
      final active = await getActiveGame();
      if (active != null && active.id != gameId) throw StateError('已有一场比赛正在记录');
      final game = gameFromRecord(await _gameRecord(gameId));
      if (game.status != GameStatus.completed) throw StateError('只能重新打开已结束比赛');
      final bundle = await getGameBundle(gameId);
      final target = game.maxPoints;
      if (target != null &&
          (bundle.state.ourScore >= target ||
              bundle.state.opponentScore >= target)) {
        throw StateError('继续比赛前，目标分必须高于当前比分');
      }
      final last =
          await (database.select(database.recordedActionEntries)
                ..where(
                  (row) => row.gameId.equals(gameId) & row.voidedAt.isNull(),
                )
                ..orderBy([(row) => OrderingTerm.desc(row.sequence)])
                ..limit(1))
              .getSingleOrNull();
      if (last?.kind == RecordedActionKind.abandonPoint.name) {
        await (database.update(
          database.recordedActionEntries,
        )..where((row) => row.id.equals(last!.id))).write(
          RecordedActionEntriesCompanion(voidedAt: Value(DateTime.now())),
        );
      }
      await _writeStatus(gameId, GameStatus.inProgress);
      await selectGame(gameId);
    });
  }

  Future<void> deleteGame(String gameId) async {
    await (database.delete(
      database.gameEntries,
    )..where((row) => row.id.equals(gameId))).go();
    final selected = await (database.select(
      database.appSettingEntries,
    )..where((row) => row.key.equals('selectedGameId'))).getSingleOrNull();
    if (selected?.value == gameId) await selectGame(null);
  }

  Future<GameBundle> getGameBundle(String gameId) async {
    final game = gameFromRecord(await _gameRecord(gameId));
    final rosterRecords = await (database.select(
      database.gameRosterEntries,
    )..where((row) => row.gameId.equals(gameId))).get();
    final roster = rosterRecords.map(_snapshotFromRecord).toList()
      ..sort(_compareSnapshots);
    final pointRecords =
        await (database.select(database.pointEntries)
              ..where((row) => row.gameId.equals(gameId))
              ..orderBy([(row) => OrderingTerm.asc(row.createdAt)]))
            .get();
    final pointIds = pointRecords.map((point) => point.id).toList();
    final participantRecords = pointIds.isEmpty
        ? <PointParticipantRecord>[]
        : await (database.select(
            database.pointParticipantEntries,
          )..where((row) => row.pointId.isIn(pointIds))).get();
    final actionRecords =
        await (database.select(database.recordedActionEntries)
              ..where((row) => row.gameId.equals(gameId))
              ..orderBy([(row) => OrderingTerm.asc(row.sequence)]))
            .get();
    final points = pointRecords.map(_pointFromRecord).toList();
    final participants = participantRecords
        .map(_participantFromRecord)
        .toList();
    final actions = actionRecords.map(_actionFromRecord).toList();
    final lines = await events.getLines(game.eventId);
    return GameBundle(
      game: game,
      roster: roster,
      points: points,
      participants: participants,
      actions: actions,
      lines: lines,
      state: RecordingReducer.replay(
        game: game,
        participants: participants,
        roster: roster,
        actions: actions,
      ),
    );
  }

  Future<Map<String, PlayerStats>> getTeamStats(String teamId) async {
    final records =
        await (database.select(database.gameEntries)..where(
              (row) =>
                  row.teamId.equals(teamId) &
                  row.status.equals(GameStatus.completed.name),
            ))
            .get();
    final totals = <String, PlayerStats>{};
    for (final record in records) {
      final bundle = await getGameBundle(record.id);
      for (final entry in bundle.state.stats.entries) {
        totals[entry.key] = (totals[entry.key] ?? const PlayerStats()).merge(
          entry.value,
        );
      }
    }
    return totals;
  }

  Future<void> _recordPointAction(
    String gameId,
    RecordedActionKind kind, {
    String? actorId,
    String? targetId,
    String? relatedActionId,
    required Set<RecordingStage> allowedStages,
    GameBundle? bundle,
    bool checkTarget = false,
  }) async {
    await database.transaction(() async {
      final current = bundle ?? await getGameBundle(gameId);
      _requireInProgress(current.game);
      if (!allowedStages.contains(current.state.stage)) {
        throw StateError('当前比赛状态不能记录此操作');
      }
      final pointId = current.state.currentPointId;
      if (pointId == null) throw StateError('当前没有正在进行的分');
      final participantIds = current
          .participantsForPoint(pointId)
          .map((participant) => participant.id)
          .toSet();
      if (actorId != null && !participantIds.contains(actorId)) {
        throw StateError('操作球员不在当前分阵容中');
      }
      if (targetId != null && !participantIds.contains(targetId)) {
        throw StateError('目标球员不在当前分阵容中');
      }
      if (actorId != null && actorId == targetId) {
        throw StateError('传盘人与接盘人不能相同');
      }
      await _insertAction(
        gameId: gameId,
        pointId: pointId,
        kind: kind,
        actorId: actorId,
        targetId: targetId,
        relatedActionId: relatedActionId,
      );
      if (checkTarget) await _completeAtTarget(gameId);
    });
  }

  Future<void> _completeAtTarget(String gameId) async {
    final bundle = await getGameBundle(gameId);
    final target = bundle.game.maxPoints;
    if (target != null &&
        (bundle.state.ourScore >= target ||
            bundle.state.opponentScore >= target)) {
      await _writeStatus(gameId, GameStatus.completed);
    }
  }

  Future<void> _insertAction({
    required String gameId,
    required RecordedActionKind kind,
    String? pointId,
    String? actorId,
    String? targetId,
    String? relatedActionId,
  }) async {
    final last =
        await (database.select(database.recordedActionEntries)
              ..where((row) => row.gameId.equals(gameId))
              ..orderBy([(row) => OrderingTerm.desc(row.sequence)])
              ..limit(1))
            .getSingleOrNull();
    await database
        .into(database.recordedActionEntries)
        .insert(
          RecordedActionEntriesCompanion.insert(
            id: newId(),
            gameId: gameId,
            pointId: Value(pointId),
            sequence: (last?.sequence ?? 0) + 1,
            kind: kind.name,
            actorParticipantId: Value(actorId),
            targetParticipantId: Value(targetId),
            relatedActionId: Value(relatedActionId),
            createdAt: DateTime.now(),
          ),
        );
  }

  Future<void> _writeStatus(String gameId, GameStatus status) async {
    await (database.update(
      database.gameEntries,
    )..where((row) => row.id.equals(gameId))).write(
      GameEntriesCompanion(
        status: Value(status.name),
        completedAt: Value(
          status == GameStatus.completed ? DateTime.now() : null,
        ),
      ),
    );
  }

  Future<GameRecord> _gameRecord(String id) async {
    final record = await (database.select(
      database.gameEntries,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (record == null) throw StateError('比赛不存在');
    return record;
  }

  static void _requireInProgress(Game game) {
    if (game.status != GameStatus.inProgress) throw StateError('比赛不在记录状态');
  }

  static void _validateLimits(int? soft, int? total, int? maxPoints) {
    if (soft != null && soft <= 0 || total != null && total <= 0) {
      throw ArgumentError('封顶时间必须是正整数');
    }
    if (soft != null && total != null && soft > total) {
      throw ArgumentError('软封顶时间不能晚于总封顶时间');
    }
    if (maxPoints != null && maxPoints <= 0) {
      throw ArgumentError('目标分必须是正整数');
    }
  }

  static int _compareSnapshots(GamePlayerSnapshot a, GamePlayerSnapshot b) {
    return compareJerseyAndName(
      numberA: a.number,
      nameA: a.name,
      numberB: b.number,
      nameB: b.name,
    );
  }

  static Game gameFromRecord(GameRecord record) => Game(
    id: record.id,
    eventId: record.eventId,
    teamId: record.teamId,
    teamName: record.teamName,
    teamType: enumByName(TeamType.values, record.teamType),
    opponentName: record.opponentName,
    openingMode: enumByName(PossessionMode.values, record.openingMode),
    softCapMinutes: record.softCapMinutes,
    totalCapMinutes: record.totalCapMinutes,
    maxPoints: record.maxPoints,
    firstRatio: record.firstRatio == null
        ? null
        : enumByName(GenderRatio.values, record.firstRatio!),
    status: enumByName(GameStatus.values, record.status),
    createdAt: record.createdAt,
    startedAt: record.startedAt,
    completedAt: record.completedAt,
    softCapAcknowledged: record.softCapAcknowledged,
    totalCapAcknowledged: record.totalCapAcknowledged,
  );

  static GamePlayerSnapshot _snapshotFromRecord(GameRosterRecord record) =>
      GamePlayerSnapshot(
        id: record.id,
        gameId: record.gameId,
        playerId: record.playerId,
        name: record.name,
        gender: enumByName(PlayerGender.values, record.gender),
        number: record.number,
        position: enumByName(PlayerPosition.values, record.position),
        archivedAtStart: record.archivedAtStart,
      );

  static PointRecord _pointFromRecord(PointRecordRow record) => PointRecord(
    id: record.id,
    gameId: record.gameId,
    number: record.pointNumber,
    createdAt: record.createdAt,
  );

  static PointParticipant _participantFromRecord(
    PointParticipantRecord record,
  ) => PointParticipant(
    id: record.id,
    pointId: record.pointId,
    gameRosterId: record.gameRosterId,
    displayOrder: record.displayOrder,
    unknown: record.unknown,
  );

  static RecordedAction _actionFromRecord(RecordedActionRecord record) =>
      RecordedAction(
        id: record.id,
        gameId: record.gameId,
        pointId: record.pointId,
        sequence: record.sequence,
        kind: enumByName(RecordedActionKind.values, record.kind),
        actorParticipantId: record.actorParticipantId,
        targetParticipantId: record.targetParticipantId,
        relatedActionId: record.relatedActionId,
        createdAt: record.createdAt,
        voidedAt: record.voidedAt,
      );
}
