import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultimate_box_score/data/database.dart';
import 'package:ultimate_box_score/data/export_service.dart';
import 'package:ultimate_box_score/data/repository.dart';
import 'package:ultimate_box_score/domain/models.dart';

void main() {
  late AppDatabase database;
  late TeamRepository teams;
  late EventRepository events;
  late GameRepository games;
  late ExportService exports;

  setUp(() {
    database = AppDatabase(NativeDatabase.memory());
    teams = TeamRepository(database);
    events = EventRepository(database, teams);
    games = GameRepository(database, events);
    exports = ExportService(database, games);
  });

  tearDown(() => database.close());

  test(
    'game export contains raw relational events and derived stats',
    () async {
      final teamId = await teams.saveTeam(name: '本队', type: TeamType.single);
      final passerId = await teams.savePlayer(
        teamId: teamId,
        name: '传盘手',
        gender: PlayerGender.male,
        position: PlayerPosition.handler,
      );
      final receiverId = await teams.savePlayer(
        teamId: teamId,
        name: '接盘手',
        gender: PlayerGender.male,
        position: PlayerPosition.cutter,
      );
      final eventId = await events.saveEvent(
        EventSaveRequest(teamId: teamId, name: '测试活动'),
      );
      final gameId = await games.saveDraft(
        GameDraftRequest(
          eventId: eventId,
          opponentName: '对手',
          openingMode: PossessionMode.offense,
        ),
      );
      await games.startGame(gameId);
      var bundle = await games.getGameBundle(gameId);
      final passerRoster = bundle.roster.singleWhere(
        (player) => player.playerId == passerId,
      );
      final receiverRoster = bundle.roster.singleWhere(
        (player) => player.playerId == receiverId,
      );
      await games.startPoint(gameId, [passerRoster.id, receiverRoster.id]);
      bundle = await games.getGameBundle(gameId);
      final pointId = bundle.state.currentPointId!;
      final pointParticipants = bundle.participantsForPoint(pointId);
      final passer = pointParticipants.singleWhere(
        (item) => item.gameRosterId == passerRoster.id,
      );
      final receiver = pointParticipants.singleWhere(
        (item) => item.gameRosterId == receiverRoster.id,
      );
      await games.recordPickup(gameId, passer.id);
      await games.recordGoalCatch(gameId, receiver.id);

      final artifact = await exports.build(ExportScope.game(gameId));
      final archive = ZipDecoder().decodeBytes(artifact.bytes, verify: true);
      final names = archive.files.map((file) => file.name).toSet();
      expect(
        names,
        containsAll([
          'manifest.json',
          'data.json',
          'actions.csv',
          'point_participants.csv',
          'game_player_stats.csv',
        ]),
      );

      final data = jsonDecode(
        utf8.decode(archive.findFile('data.json')!.readBytes()!),
      ) as Map<String, dynamic>;
      final actions = (data['actions'] as List<dynamic>)
          .cast<Map<String, dynamic>>();
      final goal = actions.singleWhere(
        (action) => action['kind'] == RecordedActionKind.goalCatch.name,
      );
      expect(goal['actorParticipantId'], passer.id);
      expect(goal['targetParticipantId'], receiver.id);
      expect(data['pointParticipants'], isNotEmpty);
      expect(data['gamePlayerStats'], isNotEmpty);
    },
  );
}
