import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DataClassName('TeamRecord')
class TeamEntries extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get teamType => text()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PlayerRecord')
class PlayerEntries extends Table {
  TextColumn get id => text()();
  TextColumn get teamId =>
      text().references(TeamEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get gender => text()();
  TextColumn get number => text().nullable()();
  TextColumn get position => text()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CompetitionEventRecord')
class CompetitionEventEntries extends Table {
  TextColumn get id => text()();
  TextColumn get teamId =>
      text().references(TeamEntries, #id, onDelete: KeyAction.restrict)();
  TextColumn get name => text()();
  DateTimeColumn get startDate => dateTime().nullable()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get archived => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('EventRosterRecord')
class EventRosterEntries extends Table {
  TextColumn get eventId => text().references(
    CompetitionEventEntries,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get playerId =>
      text().references(PlayerEntries, #id, onDelete: KeyAction.restrict)();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {eventId, playerId};
}

@DataClassName('LinePresetRecord')
class LinePresetEntries extends Table {
  TextColumn get id => text()();
  TextColumn get eventId => text().references(
    CompetitionEventEntries,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('LinePresetMemberRecord')
class LinePresetMemberEntries extends Table {
  TextColumn get lineId =>
      text().references(LinePresetEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get playerId =>
      text().references(PlayerEntries, #id, onDelete: KeyAction.restrict)();

  @override
  Set<Column<Object>> get primaryKey => {lineId, playerId};
}

@DataClassName('GameRecord')
class GameEntries extends Table {
  TextColumn get id => text()();
  TextColumn get eventId => text().references(
    CompetitionEventEntries,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get teamId =>
      text().references(TeamEntries, #id, onDelete: KeyAction.restrict)();
  TextColumn get teamName => text()();
  TextColumn get teamType => text()();
  TextColumn get opponentName => text()();
  TextColumn get openingMode => text()();
  IntColumn get softCapMinutes => integer().nullable()();
  IntColumn get totalCapMinutes => integer().nullable()();
  IntColumn get maxPoints => integer().nullable()();
  TextColumn get firstRatio => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get startedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  BoolColumn get softCapAcknowledged =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get totalCapAcknowledged =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('GameRosterRecord')
class GameRosterEntries extends Table {
  TextColumn get id => text()();
  TextColumn get gameId =>
      text().references(GameEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get playerId => text()();
  TextColumn get name => text()();
  TextColumn get gender => text()();
  TextColumn get number => text().nullable()();
  TextColumn get position => text()();
  BoolColumn get archivedAtStart => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {gameId, playerId},
  ];
}

@DataClassName('PointRecordRow')
class PointEntries extends Table {
  TextColumn get id => text()();
  TextColumn get gameId =>
      text().references(GameEntries, #id, onDelete: KeyAction.cascade)();
  IntColumn get pointNumber => integer()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('PointParticipantRecord')
class PointParticipantEntries extends Table {
  TextColumn get id => text()();
  TextColumn get pointId =>
      text().references(PointEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get gameRosterId => text().nullable().references(
    GameRosterEntries,
    #id,
    onDelete: KeyAction.restrict,
  )();
  IntColumn get displayOrder => integer()();
  BoolColumn get unknown => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('RecordedActionRecord')
class RecordedActionEntries extends Table {
  TextColumn get id => text()();
  TextColumn get gameId =>
      text().references(GameEntries, #id, onDelete: KeyAction.cascade)();
  TextColumn get pointId => text().nullable().references(
    PointEntries,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get sequence => integer()();
  TextColumn get kind => text()();
  @ReferenceName('actorActions')
  TextColumn get actorParticipantId => text().nullable().references(
    PointParticipantEntries,
    #id,
    onDelete: KeyAction.restrict,
  )();
  @ReferenceName('targetActions')
  TextColumn get targetParticipantId => text().nullable().references(
    PointParticipantEntries,
    #id,
    onDelete: KeyAction.restrict,
  )();
  TextColumn get relatedActionId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get voidedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {gameId, sequence},
  ];
}

@DataClassName('AppSettingRecord')
class AppSettingEntries extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    TeamEntries,
    PlayerEntries,
    CompetitionEventEntries,
    EventRosterEntries,
    LinePresetEntries,
    LinePresetMemberEntries,
    GameEntries,
    GameRosterEntries,
    PointEntries,
    PointParticipantEntries,
    RecordedActionEntries,
    AppSettingEntries,
  ],
)
final class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? implementation])
    : super(implementation ?? driftDatabase(name: 'ultimate_box_score'));

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) => migrator.createAll(),
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        for (final table in const [
          'game_action_entries',
          'recorded_action_entries',
          'point_participant_entries',
          'point_entries',
          'game_roster_entries',
          'game_entries',
          'line_preset_member_entries',
          'line_preset_entries',
          'event_roster_entries',
          'competition_event_entries',
          'player_entries',
          'team_entries',
          'app_setting_entries',
        ]) {
          await customStatement('DROP TABLE IF EXISTS $table');
        }
        await migrator.createAll();
      }
    },
    beforeOpen: (_) => customStatement('PRAGMA foreign_keys = ON'),
  );
}
