// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TeamEntriesTable extends TeamEntries
    with TableInfo<$TeamEntriesTable, TeamRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeamEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamTypeMeta = const VerificationMeta(
    'teamType',
  );
  @override
  late final GeneratedColumn<String> teamType = GeneratedColumn<String>(
    'team_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    teamType,
    archived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'team_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TeamRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('team_type')) {
      context.handle(
        _teamTypeMeta,
        teamType.isAcceptableOrUnknown(data['team_type']!, _teamTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_teamTypeMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TeamRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TeamRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      teamType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_type'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TeamEntriesTable createAlias(String alias) {
    return $TeamEntriesTable(attachedDatabase, alias);
  }
}

class TeamRecord extends DataClass implements Insertable<TeamRecord> {
  final String id;
  final String name;
  final String teamType;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TeamRecord({
    required this.id,
    required this.name,
    required this.teamType,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['team_type'] = Variable<String>(teamType);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TeamEntriesCompanion toCompanion(bool nullToAbsent) {
    return TeamEntriesCompanion(
      id: Value(id),
      name: Value(name),
      teamType: Value(teamType),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TeamRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TeamRecord(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      teamType: serializer.fromJson<String>(json['teamType']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'teamType': serializer.toJson<String>(teamType),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TeamRecord copyWith({
    String? id,
    String? name,
    String? teamType,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TeamRecord(
    id: id ?? this.id,
    name: name ?? this.name,
    teamType: teamType ?? this.teamType,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TeamRecord copyWithCompanion(TeamEntriesCompanion data) {
    return TeamRecord(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      teamType: data.teamType.present ? data.teamType.value : this.teamType,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TeamRecord(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('teamType: $teamType, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, teamType, archived, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TeamRecord &&
          other.id == this.id &&
          other.name == this.name &&
          other.teamType == this.teamType &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeamEntriesCompanion extends UpdateCompanion<TeamRecord> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> teamType;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TeamEntriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.teamType = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeamEntriesCompanion.insert({
    required String id,
    required String name,
    required String teamType,
    this.archived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       teamType = Value(teamType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TeamRecord> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? teamType,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (teamType != null) 'team_type': teamType,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeamEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? teamType,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TeamEntriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      teamType: teamType ?? this.teamType,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (teamType.present) {
      map['team_type'] = Variable<String>(teamType.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeamEntriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('teamType: $teamType, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayerEntriesTable extends PlayerEntries
    with TableInfo<$PlayerEntriesTable, PlayerRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES team_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    name,
    gender,
    number,
    position,
    archived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PlayerEntriesTable createAlias(String alias) {
    return $PlayerEntriesTable(attachedDatabase, alias);
  }
}

class PlayerRecord extends DataClass implements Insertable<PlayerRecord> {
  final String id;
  final String teamId;
  final String name;
  final String gender;
  final String? number;
  final String position;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PlayerRecord({
    required this.id,
    required this.teamId,
    required this.name,
    required this.gender,
    this.number,
    required this.position,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['name'] = Variable<String>(name);
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    map['position'] = Variable<String>(position);
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PlayerEntriesCompanion toCompanion(bool nullToAbsent) {
    return PlayerEntriesCompanion(
      id: Value(id),
      teamId: Value(teamId),
      name: Value(name),
      gender: Value(gender),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      position: Value(position),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PlayerRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerRecord(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<String>(json['gender']),
      number: serializer.fromJson<String?>(json['number']),
      position: serializer.fromJson<String>(json['position']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<String>(gender),
      'number': serializer.toJson<String?>(number),
      'position': serializer.toJson<String>(position),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PlayerRecord copyWith({
    String? id,
    String? teamId,
    String? name,
    String? gender,
    Value<String?> number = const Value.absent(),
    String? position,
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PlayerRecord(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    number: number.present ? number.value : this.number,
    position: position ?? this.position,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PlayerRecord copyWithCompanion(PlayerEntriesCompanion data) {
    return PlayerRecord(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      number: data.number.present ? data.number.value : this.number,
      position: data.position.present ? data.position.value : this.position,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerRecord(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('position: $position, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    name,
    gender,
    number,
    position,
    archived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerRecord &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.number == this.number &&
          other.position == this.position &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PlayerEntriesCompanion extends UpdateCompanion<PlayerRecord> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> name;
  final Value<String> gender;
  final Value<String?> number;
  final Value<String> position;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const PlayerEntriesCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.number = const Value.absent(),
    this.position = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayerEntriesCompanion.insert({
    required String id,
    required String teamId,
    required String name,
    required String gender,
    this.number = const Value.absent(),
    required String position,
    this.archived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teamId = Value(teamId),
       name = Value(name),
       gender = Value(gender),
       position = Value(position),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PlayerRecord> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? name,
    Expression<String>? gender,
    Expression<String>? number,
    Expression<String>? position,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (number != null) 'number': number,
      if (position != null) 'position': position,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayerEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? teamId,
    Value<String>? name,
    Value<String>? gender,
    Value<String?>? number,
    Value<String>? position,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return PlayerEntriesCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      number: number ?? this.number,
      position: position ?? this.position,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerEntriesCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('position: $position, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompetitionEventEntriesTable extends CompetitionEventEntries
    with TableInfo<$CompetitionEventEntriesTable, CompetitionEventRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompetitionEventEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES team_entries (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    teamId,
    name,
    startDate,
    endDate,
    location,
    notes,
    archived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'competition_event_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompetitionEventRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompetitionEventRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompetitionEventRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CompetitionEventEntriesTable createAlias(String alias) {
    return $CompetitionEventEntriesTable(attachedDatabase, alias);
  }
}

class CompetitionEventRecord extends DataClass
    implements Insertable<CompetitionEventRecord> {
  final String id;
  final String teamId;
  final String name;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? location;
  final String? notes;
  final bool archived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CompetitionEventRecord({
    required this.id,
    required this.teamId,
    required this.name,
    this.startDate,
    this.endDate,
    this.location,
    this.notes,
    required this.archived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['team_id'] = Variable<String>(teamId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CompetitionEventEntriesCompanion toCompanion(bool nullToAbsent) {
    return CompetitionEventEntriesCompanion(
      id: Value(id),
      teamId: Value(teamId),
      name: Value(name),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      archived: Value(archived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CompetitionEventRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompetitionEventRecord(
      id: serializer.fromJson<String>(json['id']),
      teamId: serializer.fromJson<String>(json['teamId']),
      name: serializer.fromJson<String>(json['name']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      location: serializer.fromJson<String?>(json['location']),
      notes: serializer.fromJson<String?>(json['notes']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'teamId': serializer.toJson<String>(teamId),
      'name': serializer.toJson<String>(name),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'location': serializer.toJson<String?>(location),
      'notes': serializer.toJson<String?>(notes),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CompetitionEventRecord copyWith({
    String? id,
    String? teamId,
    String? name,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    Value<String?> location = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? archived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CompetitionEventRecord(
    id: id ?? this.id,
    teamId: teamId ?? this.teamId,
    name: name ?? this.name,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    location: location.present ? location.value : this.location,
    notes: notes.present ? notes.value : this.notes,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CompetitionEventRecord copyWithCompanion(
    CompetitionEventEntriesCompanion data,
  ) {
    return CompetitionEventRecord(
      id: data.id.present ? data.id.value : this.id,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      name: data.name.present ? data.name.value : this.name,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      location: data.location.present ? data.location.value : this.location,
      notes: data.notes.present ? data.notes.value : this.notes,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompetitionEventRecord(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    teamId,
    name,
    startDate,
    endDate,
    location,
    notes,
    archived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompetitionEventRecord &&
          other.id == this.id &&
          other.teamId == this.teamId &&
          other.name == this.name &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.location == this.location &&
          other.notes == this.notes &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CompetitionEventEntriesCompanion
    extends UpdateCompanion<CompetitionEventRecord> {
  final Value<String> id;
  final Value<String> teamId;
  final Value<String> name;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> location;
  final Value<String?> notes;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CompetitionEventEntriesCompanion({
    this.id = const Value.absent(),
    this.teamId = const Value.absent(),
    this.name = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompetitionEventEntriesCompanion.insert({
    required String id,
    required String teamId,
    required String name,
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.location = const Value.absent(),
    this.notes = const Value.absent(),
    this.archived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       teamId = Value(teamId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CompetitionEventRecord> custom({
    Expression<String>? id,
    Expression<String>? teamId,
    Expression<String>? name,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? location,
    Expression<String>? notes,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (teamId != null) 'team_id': teamId,
      if (name != null) 'name': name,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (location != null) 'location': location,
      if (notes != null) 'notes': notes,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompetitionEventEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? teamId,
    Value<String>? name,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<String?>? location,
    Value<String?>? notes,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CompetitionEventEntriesCompanion(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompetitionEventEntriesCompanion(')
          ..write('id: $id, ')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('location: $location, ')
          ..write('notes: $notes, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventRosterEntriesTable extends EventRosterEntries
    with TableInfo<$EventRosterEntriesTable, EventRosterRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventRosterEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES competition_event_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_entries (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [eventId, playerId, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_roster_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventRosterRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {eventId, playerId};
  @override
  EventRosterRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventRosterRecord(
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $EventRosterEntriesTable createAlias(String alias) {
    return $EventRosterEntriesTable(attachedDatabase, alias);
  }
}

class EventRosterRecord extends DataClass
    implements Insertable<EventRosterRecord> {
  final String eventId;
  final String playerId;
  final DateTime addedAt;
  const EventRosterRecord({
    required this.eventId,
    required this.playerId,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['event_id'] = Variable<String>(eventId);
    map['player_id'] = Variable<String>(playerId);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  EventRosterEntriesCompanion toCompanion(bool nullToAbsent) {
    return EventRosterEntriesCompanion(
      eventId: Value(eventId),
      playerId: Value(playerId),
      addedAt: Value(addedAt),
    );
  }

  factory EventRosterRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventRosterRecord(
      eventId: serializer.fromJson<String>(json['eventId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'eventId': serializer.toJson<String>(eventId),
      'playerId': serializer.toJson<String>(playerId),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  EventRosterRecord copyWith({
    String? eventId,
    String? playerId,
    DateTime? addedAt,
  }) => EventRosterRecord(
    eventId: eventId ?? this.eventId,
    playerId: playerId ?? this.playerId,
    addedAt: addedAt ?? this.addedAt,
  );
  EventRosterRecord copyWithCompanion(EventRosterEntriesCompanion data) {
    return EventRosterRecord(
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventRosterRecord(')
          ..write('eventId: $eventId, ')
          ..write('playerId: $playerId, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(eventId, playerId, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRosterRecord &&
          other.eventId == this.eventId &&
          other.playerId == this.playerId &&
          other.addedAt == this.addedAt);
}

class EventRosterEntriesCompanion extends UpdateCompanion<EventRosterRecord> {
  final Value<String> eventId;
  final Value<String> playerId;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const EventRosterEntriesCompanion({
    this.eventId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventRosterEntriesCompanion.insert({
    required String eventId,
    required String playerId,
    required DateTime addedAt,
    this.rowid = const Value.absent(),
  }) : eventId = Value(eventId),
       playerId = Value(playerId),
       addedAt = Value(addedAt);
  static Insertable<EventRosterRecord> custom({
    Expression<String>? eventId,
    Expression<String>? playerId,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (eventId != null) 'event_id': eventId,
      if (playerId != null) 'player_id': playerId,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventRosterEntriesCompanion copyWith({
    Value<String>? eventId,
    Value<String>? playerId,
    Value<DateTime>? addedAt,
    Value<int>? rowid,
  }) {
    return EventRosterEntriesCompanion(
      eventId: eventId ?? this.eventId,
      playerId: playerId ?? this.playerId,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventRosterEntriesCompanion(')
          ..write('eventId: $eventId, ')
          ..write('playerId: $playerId, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LinePresetEntriesTable extends LinePresetEntries
    with TableInfo<$LinePresetEntriesTable, LinePresetRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LinePresetEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES competition_event_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    name,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'line_preset_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LinePresetRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LinePresetRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LinePresetRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LinePresetEntriesTable createAlias(String alias) {
    return $LinePresetEntriesTable(attachedDatabase, alias);
  }
}

class LinePresetRecord extends DataClass
    implements Insertable<LinePresetRecord> {
  final String id;
  final String eventId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LinePresetRecord({
    required this.id,
    required this.eventId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LinePresetEntriesCompanion toCompanion(bool nullToAbsent) {
    return LinePresetEntriesCompanion(
      id: Value(id),
      eventId: Value(eventId),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LinePresetRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LinePresetRecord(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LinePresetRecord copyWith({
    String? id,
    String? eventId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LinePresetRecord(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LinePresetRecord copyWithCompanion(LinePresetEntriesCompanion data) {
    return LinePresetRecord(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LinePresetRecord(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventId, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LinePresetRecord &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LinePresetEntriesCompanion extends UpdateCompanion<LinePresetRecord> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LinePresetEntriesCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LinePresetEntriesCompanion.insert({
    required String id,
    required String eventId,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LinePresetRecord> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LinePresetEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LinePresetEntriesCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LinePresetEntriesCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LinePresetMemberEntriesTable extends LinePresetMemberEntries
    with TableInfo<$LinePresetMemberEntriesTable, LinePresetMemberRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LinePresetMemberEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _lineIdMeta = const VerificationMeta('lineId');
  @override
  late final GeneratedColumn<String> lineId = GeneratedColumn<String>(
    'line_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES line_preset_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES player_entries (id) ON DELETE RESTRICT',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [lineId, playerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'line_preset_member_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<LinePresetMemberRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('line_id')) {
      context.handle(
        _lineIdMeta,
        lineId.isAcceptableOrUnknown(data['line_id']!, _lineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lineIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {lineId, playerId};
  @override
  LinePresetMemberRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LinePresetMemberRecord(
      lineId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}line_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
    );
  }

  @override
  $LinePresetMemberEntriesTable createAlias(String alias) {
    return $LinePresetMemberEntriesTable(attachedDatabase, alias);
  }
}

class LinePresetMemberRecord extends DataClass
    implements Insertable<LinePresetMemberRecord> {
  final String lineId;
  final String playerId;
  const LinePresetMemberRecord({required this.lineId, required this.playerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['line_id'] = Variable<String>(lineId);
    map['player_id'] = Variable<String>(playerId);
    return map;
  }

  LinePresetMemberEntriesCompanion toCompanion(bool nullToAbsent) {
    return LinePresetMemberEntriesCompanion(
      lineId: Value(lineId),
      playerId: Value(playerId),
    );
  }

  factory LinePresetMemberRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LinePresetMemberRecord(
      lineId: serializer.fromJson<String>(json['lineId']),
      playerId: serializer.fromJson<String>(json['playerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'lineId': serializer.toJson<String>(lineId),
      'playerId': serializer.toJson<String>(playerId),
    };
  }

  LinePresetMemberRecord copyWith({String? lineId, String? playerId}) =>
      LinePresetMemberRecord(
        lineId: lineId ?? this.lineId,
        playerId: playerId ?? this.playerId,
      );
  LinePresetMemberRecord copyWithCompanion(
    LinePresetMemberEntriesCompanion data,
  ) {
    return LinePresetMemberRecord(
      lineId: data.lineId.present ? data.lineId.value : this.lineId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LinePresetMemberRecord(')
          ..write('lineId: $lineId, ')
          ..write('playerId: $playerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(lineId, playerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LinePresetMemberRecord &&
          other.lineId == this.lineId &&
          other.playerId == this.playerId);
}

class LinePresetMemberEntriesCompanion
    extends UpdateCompanion<LinePresetMemberRecord> {
  final Value<String> lineId;
  final Value<String> playerId;
  final Value<int> rowid;
  const LinePresetMemberEntriesCompanion({
    this.lineId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LinePresetMemberEntriesCompanion.insert({
    required String lineId,
    required String playerId,
    this.rowid = const Value.absent(),
  }) : lineId = Value(lineId),
       playerId = Value(playerId);
  static Insertable<LinePresetMemberRecord> custom({
    Expression<String>? lineId,
    Expression<String>? playerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (lineId != null) 'line_id': lineId,
      if (playerId != null) 'player_id': playerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LinePresetMemberEntriesCompanion copyWith({
    Value<String>? lineId,
    Value<String>? playerId,
    Value<int>? rowid,
  }) {
    return LinePresetMemberEntriesCompanion(
      lineId: lineId ?? this.lineId,
      playerId: playerId ?? this.playerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (lineId.present) {
      map['line_id'] = Variable<String>(lineId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LinePresetMemberEntriesCompanion(')
          ..write('lineId: $lineId, ')
          ..write('playerId: $playerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GameEntriesTable extends GameEntries
    with TableInfo<$GameEntriesTable, GameRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES competition_event_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES team_entries (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _teamNameMeta = const VerificationMeta(
    'teamName',
  );
  @override
  late final GeneratedColumn<String> teamName = GeneratedColumn<String>(
    'team_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamTypeMeta = const VerificationMeta(
    'teamType',
  );
  @override
  late final GeneratedColumn<String> teamType = GeneratedColumn<String>(
    'team_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _opponentNameMeta = const VerificationMeta(
    'opponentName',
  );
  @override
  late final GeneratedColumn<String> opponentName = GeneratedColumn<String>(
    'opponent_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingModeMeta = const VerificationMeta(
    'openingMode',
  );
  @override
  late final GeneratedColumn<String> openingMode = GeneratedColumn<String>(
    'opening_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _softCapMinutesMeta = const VerificationMeta(
    'softCapMinutes',
  );
  @override
  late final GeneratedColumn<int> softCapMinutes = GeneratedColumn<int>(
    'soft_cap_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalCapMinutesMeta = const VerificationMeta(
    'totalCapMinutes',
  );
  @override
  late final GeneratedColumn<int> totalCapMinutes = GeneratedColumn<int>(
    'total_cap_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxPointsMeta = const VerificationMeta(
    'maxPoints',
  );
  @override
  late final GeneratedColumn<int> maxPoints = GeneratedColumn<int>(
    'max_points',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstRatioMeta = const VerificationMeta(
    'firstRatio',
  );
  @override
  late final GeneratedColumn<String> firstRatio = GeneratedColumn<String>(
    'first_ratio',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _softCapAcknowledgedMeta =
      const VerificationMeta('softCapAcknowledged');
  @override
  late final GeneratedColumn<bool> softCapAcknowledged = GeneratedColumn<bool>(
    'soft_cap_acknowledged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("soft_cap_acknowledged" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _totalCapAcknowledgedMeta =
      const VerificationMeta('totalCapAcknowledged');
  @override
  late final GeneratedColumn<bool> totalCapAcknowledged = GeneratedColumn<bool>(
    'total_cap_acknowledged',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("total_cap_acknowledged" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    teamId,
    teamName,
    teamType,
    opponentName,
    openingMode,
    softCapMinutes,
    totalCapMinutes,
    maxPoints,
    firstRatio,
    status,
    createdAt,
    startedAt,
    completedAt,
    softCapAcknowledged,
    totalCapAcknowledged,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('team_name')) {
      context.handle(
        _teamNameMeta,
        teamName.isAcceptableOrUnknown(data['team_name']!, _teamNameMeta),
      );
    } else if (isInserting) {
      context.missing(_teamNameMeta);
    }
    if (data.containsKey('team_type')) {
      context.handle(
        _teamTypeMeta,
        teamType.isAcceptableOrUnknown(data['team_type']!, _teamTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_teamTypeMeta);
    }
    if (data.containsKey('opponent_name')) {
      context.handle(
        _opponentNameMeta,
        opponentName.isAcceptableOrUnknown(
          data['opponent_name']!,
          _opponentNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_opponentNameMeta);
    }
    if (data.containsKey('opening_mode')) {
      context.handle(
        _openingModeMeta,
        openingMode.isAcceptableOrUnknown(
          data['opening_mode']!,
          _openingModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_openingModeMeta);
    }
    if (data.containsKey('soft_cap_minutes')) {
      context.handle(
        _softCapMinutesMeta,
        softCapMinutes.isAcceptableOrUnknown(
          data['soft_cap_minutes']!,
          _softCapMinutesMeta,
        ),
      );
    }
    if (data.containsKey('total_cap_minutes')) {
      context.handle(
        _totalCapMinutesMeta,
        totalCapMinutes.isAcceptableOrUnknown(
          data['total_cap_minutes']!,
          _totalCapMinutesMeta,
        ),
      );
    }
    if (data.containsKey('max_points')) {
      context.handle(
        _maxPointsMeta,
        maxPoints.isAcceptableOrUnknown(data['max_points']!, _maxPointsMeta),
      );
    }
    if (data.containsKey('first_ratio')) {
      context.handle(
        _firstRatioMeta,
        firstRatio.isAcceptableOrUnknown(data['first_ratio']!, _firstRatioMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('soft_cap_acknowledged')) {
      context.handle(
        _softCapAcknowledgedMeta,
        softCapAcknowledged.isAcceptableOrUnknown(
          data['soft_cap_acknowledged']!,
          _softCapAcknowledgedMeta,
        ),
      );
    }
    if (data.containsKey('total_cap_acknowledged')) {
      context.handle(
        _totalCapAcknowledgedMeta,
        totalCapAcknowledged.isAcceptableOrUnknown(
          data['total_cap_acknowledged']!,
          _totalCapAcknowledgedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GameRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      teamName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_name'],
      )!,
      teamType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_type'],
      )!,
      opponentName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opponent_name'],
      )!,
      openingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}opening_mode'],
      )!,
      softCapMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}soft_cap_minutes'],
      ),
      totalCapMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_cap_minutes'],
      ),
      maxPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_points'],
      ),
      firstRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_ratio'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      softCapAcknowledged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}soft_cap_acknowledged'],
      )!,
      totalCapAcknowledged: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}total_cap_acknowledged'],
      )!,
    );
  }

  @override
  $GameEntriesTable createAlias(String alias) {
    return $GameEntriesTable(attachedDatabase, alias);
  }
}

class GameRecord extends DataClass implements Insertable<GameRecord> {
  final String id;
  final String eventId;
  final String teamId;
  final String teamName;
  final String teamType;
  final String opponentName;
  final String openingMode;
  final int? softCapMinutes;
  final int? totalCapMinutes;
  final int? maxPoints;
  final String? firstRatio;
  final String status;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final bool softCapAcknowledged;
  final bool totalCapAcknowledged;
  const GameRecord({
    required this.id,
    required this.eventId,
    required this.teamId,
    required this.teamName,
    required this.teamType,
    required this.opponentName,
    required this.openingMode,
    this.softCapMinutes,
    this.totalCapMinutes,
    this.maxPoints,
    this.firstRatio,
    required this.status,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    required this.softCapAcknowledged,
    required this.totalCapAcknowledged,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['team_id'] = Variable<String>(teamId);
    map['team_name'] = Variable<String>(teamName);
    map['team_type'] = Variable<String>(teamType);
    map['opponent_name'] = Variable<String>(opponentName);
    map['opening_mode'] = Variable<String>(openingMode);
    if (!nullToAbsent || softCapMinutes != null) {
      map['soft_cap_minutes'] = Variable<int>(softCapMinutes);
    }
    if (!nullToAbsent || totalCapMinutes != null) {
      map['total_cap_minutes'] = Variable<int>(totalCapMinutes);
    }
    if (!nullToAbsent || maxPoints != null) {
      map['max_points'] = Variable<int>(maxPoints);
    }
    if (!nullToAbsent || firstRatio != null) {
      map['first_ratio'] = Variable<String>(firstRatio);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['soft_cap_acknowledged'] = Variable<bool>(softCapAcknowledged);
    map['total_cap_acknowledged'] = Variable<bool>(totalCapAcknowledged);
    return map;
  }

  GameEntriesCompanion toCompanion(bool nullToAbsent) {
    return GameEntriesCompanion(
      id: Value(id),
      eventId: Value(eventId),
      teamId: Value(teamId),
      teamName: Value(teamName),
      teamType: Value(teamType),
      opponentName: Value(opponentName),
      openingMode: Value(openingMode),
      softCapMinutes: softCapMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(softCapMinutes),
      totalCapMinutes: totalCapMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCapMinutes),
      maxPoints: maxPoints == null && nullToAbsent
          ? const Value.absent()
          : Value(maxPoints),
      firstRatio: firstRatio == null && nullToAbsent
          ? const Value.absent()
          : Value(firstRatio),
      status: Value(status),
      createdAt: Value(createdAt),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      softCapAcknowledged: Value(softCapAcknowledged),
      totalCapAcknowledged: Value(totalCapAcknowledged),
    );
  }

  factory GameRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameRecord(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      teamId: serializer.fromJson<String>(json['teamId']),
      teamName: serializer.fromJson<String>(json['teamName']),
      teamType: serializer.fromJson<String>(json['teamType']),
      opponentName: serializer.fromJson<String>(json['opponentName']),
      openingMode: serializer.fromJson<String>(json['openingMode']),
      softCapMinutes: serializer.fromJson<int?>(json['softCapMinutes']),
      totalCapMinutes: serializer.fromJson<int?>(json['totalCapMinutes']),
      maxPoints: serializer.fromJson<int?>(json['maxPoints']),
      firstRatio: serializer.fromJson<String?>(json['firstRatio']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      softCapAcknowledged: serializer.fromJson<bool>(
        json['softCapAcknowledged'],
      ),
      totalCapAcknowledged: serializer.fromJson<bool>(
        json['totalCapAcknowledged'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'teamId': serializer.toJson<String>(teamId),
      'teamName': serializer.toJson<String>(teamName),
      'teamType': serializer.toJson<String>(teamType),
      'opponentName': serializer.toJson<String>(opponentName),
      'openingMode': serializer.toJson<String>(openingMode),
      'softCapMinutes': serializer.toJson<int?>(softCapMinutes),
      'totalCapMinutes': serializer.toJson<int?>(totalCapMinutes),
      'maxPoints': serializer.toJson<int?>(maxPoints),
      'firstRatio': serializer.toJson<String?>(firstRatio),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'softCapAcknowledged': serializer.toJson<bool>(softCapAcknowledged),
      'totalCapAcknowledged': serializer.toJson<bool>(totalCapAcknowledged),
    };
  }

  GameRecord copyWith({
    String? id,
    String? eventId,
    String? teamId,
    String? teamName,
    String? teamType,
    String? opponentName,
    String? openingMode,
    Value<int?> softCapMinutes = const Value.absent(),
    Value<int?> totalCapMinutes = const Value.absent(),
    Value<int?> maxPoints = const Value.absent(),
    Value<String?> firstRatio = const Value.absent(),
    String? status,
    DateTime? createdAt,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    bool? softCapAcknowledged,
    bool? totalCapAcknowledged,
  }) => GameRecord(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    teamId: teamId ?? this.teamId,
    teamName: teamName ?? this.teamName,
    teamType: teamType ?? this.teamType,
    opponentName: opponentName ?? this.opponentName,
    openingMode: openingMode ?? this.openingMode,
    softCapMinutes: softCapMinutes.present
        ? softCapMinutes.value
        : this.softCapMinutes,
    totalCapMinutes: totalCapMinutes.present
        ? totalCapMinutes.value
        : this.totalCapMinutes,
    maxPoints: maxPoints.present ? maxPoints.value : this.maxPoints,
    firstRatio: firstRatio.present ? firstRatio.value : this.firstRatio,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    softCapAcknowledged: softCapAcknowledged ?? this.softCapAcknowledged,
    totalCapAcknowledged: totalCapAcknowledged ?? this.totalCapAcknowledged,
  );
  GameRecord copyWithCompanion(GameEntriesCompanion data) {
    return GameRecord(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      teamName: data.teamName.present ? data.teamName.value : this.teamName,
      teamType: data.teamType.present ? data.teamType.value : this.teamType,
      opponentName: data.opponentName.present
          ? data.opponentName.value
          : this.opponentName,
      openingMode: data.openingMode.present
          ? data.openingMode.value
          : this.openingMode,
      softCapMinutes: data.softCapMinutes.present
          ? data.softCapMinutes.value
          : this.softCapMinutes,
      totalCapMinutes: data.totalCapMinutes.present
          ? data.totalCapMinutes.value
          : this.totalCapMinutes,
      maxPoints: data.maxPoints.present ? data.maxPoints.value : this.maxPoints,
      firstRatio: data.firstRatio.present
          ? data.firstRatio.value
          : this.firstRatio,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      softCapAcknowledged: data.softCapAcknowledged.present
          ? data.softCapAcknowledged.value
          : this.softCapAcknowledged,
      totalCapAcknowledged: data.totalCapAcknowledged.present
          ? data.totalCapAcknowledged.value
          : this.totalCapAcknowledged,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameRecord(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('teamId: $teamId, ')
          ..write('teamName: $teamName, ')
          ..write('teamType: $teamType, ')
          ..write('opponentName: $opponentName, ')
          ..write('openingMode: $openingMode, ')
          ..write('softCapMinutes: $softCapMinutes, ')
          ..write('totalCapMinutes: $totalCapMinutes, ')
          ..write('maxPoints: $maxPoints, ')
          ..write('firstRatio: $firstRatio, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('softCapAcknowledged: $softCapAcknowledged, ')
          ..write('totalCapAcknowledged: $totalCapAcknowledged')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    teamId,
    teamName,
    teamType,
    opponentName,
    openingMode,
    softCapMinutes,
    totalCapMinutes,
    maxPoints,
    firstRatio,
    status,
    createdAt,
    startedAt,
    completedAt,
    softCapAcknowledged,
    totalCapAcknowledged,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameRecord &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.teamId == this.teamId &&
          other.teamName == this.teamName &&
          other.teamType == this.teamType &&
          other.opponentName == this.opponentName &&
          other.openingMode == this.openingMode &&
          other.softCapMinutes == this.softCapMinutes &&
          other.totalCapMinutes == this.totalCapMinutes &&
          other.maxPoints == this.maxPoints &&
          other.firstRatio == this.firstRatio &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.softCapAcknowledged == this.softCapAcknowledged &&
          other.totalCapAcknowledged == this.totalCapAcknowledged);
}

class GameEntriesCompanion extends UpdateCompanion<GameRecord> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> teamId;
  final Value<String> teamName;
  final Value<String> teamType;
  final Value<String> opponentName;
  final Value<String> openingMode;
  final Value<int?> softCapMinutes;
  final Value<int?> totalCapMinutes;
  final Value<int?> maxPoints;
  final Value<String?> firstRatio;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<bool> softCapAcknowledged;
  final Value<bool> totalCapAcknowledged;
  final Value<int> rowid;
  const GameEntriesCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.teamName = const Value.absent(),
    this.teamType = const Value.absent(),
    this.opponentName = const Value.absent(),
    this.openingMode = const Value.absent(),
    this.softCapMinutes = const Value.absent(),
    this.totalCapMinutes = const Value.absent(),
    this.maxPoints = const Value.absent(),
    this.firstRatio = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.softCapAcknowledged = const Value.absent(),
    this.totalCapAcknowledged = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameEntriesCompanion.insert({
    required String id,
    required String eventId,
    required String teamId,
    required String teamName,
    required String teamType,
    required String opponentName,
    required String openingMode,
    this.softCapMinutes = const Value.absent(),
    this.totalCapMinutes = const Value.absent(),
    this.maxPoints = const Value.absent(),
    this.firstRatio = const Value.absent(),
    required String status,
    required DateTime createdAt,
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.softCapAcknowledged = const Value.absent(),
    this.totalCapAcknowledged = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       teamId = Value(teamId),
       teamName = Value(teamName),
       teamType = Value(teamType),
       opponentName = Value(opponentName),
       openingMode = Value(openingMode),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<GameRecord> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? teamId,
    Expression<String>? teamName,
    Expression<String>? teamType,
    Expression<String>? opponentName,
    Expression<String>? openingMode,
    Expression<int>? softCapMinutes,
    Expression<int>? totalCapMinutes,
    Expression<int>? maxPoints,
    Expression<String>? firstRatio,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<bool>? softCapAcknowledged,
    Expression<bool>? totalCapAcknowledged,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (teamId != null) 'team_id': teamId,
      if (teamName != null) 'team_name': teamName,
      if (teamType != null) 'team_type': teamType,
      if (opponentName != null) 'opponent_name': opponentName,
      if (openingMode != null) 'opening_mode': openingMode,
      if (softCapMinutes != null) 'soft_cap_minutes': softCapMinutes,
      if (totalCapMinutes != null) 'total_cap_minutes': totalCapMinutes,
      if (maxPoints != null) 'max_points': maxPoints,
      if (firstRatio != null) 'first_ratio': firstRatio,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (softCapAcknowledged != null)
        'soft_cap_acknowledged': softCapAcknowledged,
      if (totalCapAcknowledged != null)
        'total_cap_acknowledged': totalCapAcknowledged,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<String>? teamId,
    Value<String>? teamName,
    Value<String>? teamType,
    Value<String>? opponentName,
    Value<String>? openingMode,
    Value<int?>? softCapMinutes,
    Value<int?>? totalCapMinutes,
    Value<int?>? maxPoints,
    Value<String?>? firstRatio,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<bool>? softCapAcknowledged,
    Value<bool>? totalCapAcknowledged,
    Value<int>? rowid,
  }) {
    return GameEntriesCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      teamId: teamId ?? this.teamId,
      teamName: teamName ?? this.teamName,
      teamType: teamType ?? this.teamType,
      opponentName: opponentName ?? this.opponentName,
      openingMode: openingMode ?? this.openingMode,
      softCapMinutes: softCapMinutes ?? this.softCapMinutes,
      totalCapMinutes: totalCapMinutes ?? this.totalCapMinutes,
      maxPoints: maxPoints ?? this.maxPoints,
      firstRatio: firstRatio ?? this.firstRatio,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      softCapAcknowledged: softCapAcknowledged ?? this.softCapAcknowledged,
      totalCapAcknowledged: totalCapAcknowledged ?? this.totalCapAcknowledged,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (teamName.present) {
      map['team_name'] = Variable<String>(teamName.value);
    }
    if (teamType.present) {
      map['team_type'] = Variable<String>(teamType.value);
    }
    if (opponentName.present) {
      map['opponent_name'] = Variable<String>(opponentName.value);
    }
    if (openingMode.present) {
      map['opening_mode'] = Variable<String>(openingMode.value);
    }
    if (softCapMinutes.present) {
      map['soft_cap_minutes'] = Variable<int>(softCapMinutes.value);
    }
    if (totalCapMinutes.present) {
      map['total_cap_minutes'] = Variable<int>(totalCapMinutes.value);
    }
    if (maxPoints.present) {
      map['max_points'] = Variable<int>(maxPoints.value);
    }
    if (firstRatio.present) {
      map['first_ratio'] = Variable<String>(firstRatio.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (softCapAcknowledged.present) {
      map['soft_cap_acknowledged'] = Variable<bool>(softCapAcknowledged.value);
    }
    if (totalCapAcknowledged.present) {
      map['total_cap_acknowledged'] = Variable<bool>(
        totalCapAcknowledged.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameEntriesCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('teamId: $teamId, ')
          ..write('teamName: $teamName, ')
          ..write('teamType: $teamType, ')
          ..write('opponentName: $opponentName, ')
          ..write('openingMode: $openingMode, ')
          ..write('softCapMinutes: $softCapMinutes, ')
          ..write('totalCapMinutes: $totalCapMinutes, ')
          ..write('maxPoints: $maxPoints, ')
          ..write('firstRatio: $firstRatio, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('softCapAcknowledged: $softCapAcknowledged, ')
          ..write('totalCapAcknowledged: $totalCapAcknowledged, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GameRosterEntriesTable extends GameRosterEntries
    with TableInfo<$GameRosterEntriesTable, GameRosterRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GameRosterEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _archivedAtStartMeta = const VerificationMeta(
    'archivedAtStart',
  );
  @override
  late final GeneratedColumn<bool> archivedAtStart = GeneratedColumn<bool>(
    'archived_at_start',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived_at_start" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gameId,
    playerId,
    name,
    gender,
    number,
    position,
    archivedAtStart,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'game_roster_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<GameRosterRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('archived_at_start')) {
      context.handle(
        _archivedAtStartMeta,
        archivedAtStart.isAcceptableOrUnknown(
          data['archived_at_start']!,
          _archivedAtStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_archivedAtStartMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {gameId, playerId},
  ];
  @override
  GameRosterRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GameRosterRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      archivedAtStart: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived_at_start'],
      )!,
    );
  }

  @override
  $GameRosterEntriesTable createAlias(String alias) {
    return $GameRosterEntriesTable(attachedDatabase, alias);
  }
}

class GameRosterRecord extends DataClass
    implements Insertable<GameRosterRecord> {
  final String id;
  final String gameId;
  final String playerId;
  final String name;
  final String gender;
  final String? number;
  final String position;
  final bool archivedAtStart;
  const GameRosterRecord({
    required this.id,
    required this.gameId,
    required this.playerId,
    required this.name,
    required this.gender,
    this.number,
    required this.position,
    required this.archivedAtStart,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game_id'] = Variable<String>(gameId);
    map['player_id'] = Variable<String>(playerId);
    map['name'] = Variable<String>(name);
    map['gender'] = Variable<String>(gender);
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    map['position'] = Variable<String>(position);
    map['archived_at_start'] = Variable<bool>(archivedAtStart);
    return map;
  }

  GameRosterEntriesCompanion toCompanion(bool nullToAbsent) {
    return GameRosterEntriesCompanion(
      id: Value(id),
      gameId: Value(gameId),
      playerId: Value(playerId),
      name: Value(name),
      gender: Value(gender),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      position: Value(position),
      archivedAtStart: Value(archivedAtStart),
    );
  }

  factory GameRosterRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GameRosterRecord(
      id: serializer.fromJson<String>(json['id']),
      gameId: serializer.fromJson<String>(json['gameId']),
      playerId: serializer.fromJson<String>(json['playerId']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<String>(json['gender']),
      number: serializer.fromJson<String?>(json['number']),
      position: serializer.fromJson<String>(json['position']),
      archivedAtStart: serializer.fromJson<bool>(json['archivedAtStart']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gameId': serializer.toJson<String>(gameId),
      'playerId': serializer.toJson<String>(playerId),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<String>(gender),
      'number': serializer.toJson<String?>(number),
      'position': serializer.toJson<String>(position),
      'archivedAtStart': serializer.toJson<bool>(archivedAtStart),
    };
  }

  GameRosterRecord copyWith({
    String? id,
    String? gameId,
    String? playerId,
    String? name,
    String? gender,
    Value<String?> number = const Value.absent(),
    String? position,
    bool? archivedAtStart,
  }) => GameRosterRecord(
    id: id ?? this.id,
    gameId: gameId ?? this.gameId,
    playerId: playerId ?? this.playerId,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    number: number.present ? number.value : this.number,
    position: position ?? this.position,
    archivedAtStart: archivedAtStart ?? this.archivedAtStart,
  );
  GameRosterRecord copyWithCompanion(GameRosterEntriesCompanion data) {
    return GameRosterRecord(
      id: data.id.present ? data.id.value : this.id,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      number: data.number.present ? data.number.value : this.number,
      position: data.position.present ? data.position.value : this.position,
      archivedAtStart: data.archivedAtStart.present
          ? data.archivedAtStart.value
          : this.archivedAtStart,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GameRosterRecord(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('playerId: $playerId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('position: $position, ')
          ..write('archivedAtStart: $archivedAtStart')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gameId,
    playerId,
    name,
    gender,
    number,
    position,
    archivedAtStart,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GameRosterRecord &&
          other.id == this.id &&
          other.gameId == this.gameId &&
          other.playerId == this.playerId &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.number == this.number &&
          other.position == this.position &&
          other.archivedAtStart == this.archivedAtStart);
}

class GameRosterEntriesCompanion extends UpdateCompanion<GameRosterRecord> {
  final Value<String> id;
  final Value<String> gameId;
  final Value<String> playerId;
  final Value<String> name;
  final Value<String> gender;
  final Value<String?> number;
  final Value<String> position;
  final Value<bool> archivedAtStart;
  final Value<int> rowid;
  const GameRosterEntriesCompanion({
    this.id = const Value.absent(),
    this.gameId = const Value.absent(),
    this.playerId = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.number = const Value.absent(),
    this.position = const Value.absent(),
    this.archivedAtStart = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GameRosterEntriesCompanion.insert({
    required String id,
    required String gameId,
    required String playerId,
    required String name,
    required String gender,
    this.number = const Value.absent(),
    required String position,
    required bool archivedAtStart,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gameId = Value(gameId),
       playerId = Value(playerId),
       name = Value(name),
       gender = Value(gender),
       position = Value(position),
       archivedAtStart = Value(archivedAtStart);
  static Insertable<GameRosterRecord> custom({
    Expression<String>? id,
    Expression<String>? gameId,
    Expression<String>? playerId,
    Expression<String>? name,
    Expression<String>? gender,
    Expression<String>? number,
    Expression<String>? position,
    Expression<bool>? archivedAtStart,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameId != null) 'game_id': gameId,
      if (playerId != null) 'player_id': playerId,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (number != null) 'number': number,
      if (position != null) 'position': position,
      if (archivedAtStart != null) 'archived_at_start': archivedAtStart,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GameRosterEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? gameId,
    Value<String>? playerId,
    Value<String>? name,
    Value<String>? gender,
    Value<String?>? number,
    Value<String>? position,
    Value<bool>? archivedAtStart,
    Value<int>? rowid,
  }) {
    return GameRosterEntriesCompanion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      playerId: playerId ?? this.playerId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      number: number ?? this.number,
      position: position ?? this.position,
      archivedAtStart: archivedAtStart ?? this.archivedAtStart,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (archivedAtStart.present) {
      map['archived_at_start'] = Variable<bool>(archivedAtStart.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GameRosterEntriesCompanion(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('playerId: $playerId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('number: $number, ')
          ..write('position: $position, ')
          ..write('archivedAtStart: $archivedAtStart, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PointEntriesTable extends PointEntries
    with TableInfo<$PointEntriesTable, PointRecordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PointEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pointNumberMeta = const VerificationMeta(
    'pointNumber',
  );
  @override
  late final GeneratedColumn<int> pointNumber = GeneratedColumn<int>(
    'point_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, gameId, pointNumber, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'point_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PointRecordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('point_number')) {
      context.handle(
        _pointNumberMeta,
        pointNumber.isAcceptableOrUnknown(
          data['point_number']!,
          _pointNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pointNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PointRecordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PointRecordRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      pointNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}point_number'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PointEntriesTable createAlias(String alias) {
    return $PointEntriesTable(attachedDatabase, alias);
  }
}

class PointRecordRow extends DataClass implements Insertable<PointRecordRow> {
  final String id;
  final String gameId;
  final int pointNumber;
  final DateTime createdAt;
  const PointRecordRow({
    required this.id,
    required this.gameId,
    required this.pointNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game_id'] = Variable<String>(gameId);
    map['point_number'] = Variable<int>(pointNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PointEntriesCompanion toCompanion(bool nullToAbsent) {
    return PointEntriesCompanion(
      id: Value(id),
      gameId: Value(gameId),
      pointNumber: Value(pointNumber),
      createdAt: Value(createdAt),
    );
  }

  factory PointRecordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PointRecordRow(
      id: serializer.fromJson<String>(json['id']),
      gameId: serializer.fromJson<String>(json['gameId']),
      pointNumber: serializer.fromJson<int>(json['pointNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gameId': serializer.toJson<String>(gameId),
      'pointNumber': serializer.toJson<int>(pointNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PointRecordRow copyWith({
    String? id,
    String? gameId,
    int? pointNumber,
    DateTime? createdAt,
  }) => PointRecordRow(
    id: id ?? this.id,
    gameId: gameId ?? this.gameId,
    pointNumber: pointNumber ?? this.pointNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  PointRecordRow copyWithCompanion(PointEntriesCompanion data) {
    return PointRecordRow(
      id: data.id.present ? data.id.value : this.id,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      pointNumber: data.pointNumber.present
          ? data.pointNumber.value
          : this.pointNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PointRecordRow(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('pointNumber: $pointNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gameId, pointNumber, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PointRecordRow &&
          other.id == this.id &&
          other.gameId == this.gameId &&
          other.pointNumber == this.pointNumber &&
          other.createdAt == this.createdAt);
}

class PointEntriesCompanion extends UpdateCompanion<PointRecordRow> {
  final Value<String> id;
  final Value<String> gameId;
  final Value<int> pointNumber;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PointEntriesCompanion({
    this.id = const Value.absent(),
    this.gameId = const Value.absent(),
    this.pointNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PointEntriesCompanion.insert({
    required String id,
    required String gameId,
    required int pointNumber,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gameId = Value(gameId),
       pointNumber = Value(pointNumber),
       createdAt = Value(createdAt);
  static Insertable<PointRecordRow> custom({
    Expression<String>? id,
    Expression<String>? gameId,
    Expression<int>? pointNumber,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameId != null) 'game_id': gameId,
      if (pointNumber != null) 'point_number': pointNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PointEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? gameId,
    Value<int>? pointNumber,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PointEntriesCompanion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      pointNumber: pointNumber ?? this.pointNumber,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (pointNumber.present) {
      map['point_number'] = Variable<int>(pointNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PointEntriesCompanion(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('pointNumber: $pointNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PointParticipantEntriesTable extends PointParticipantEntries
    with TableInfo<$PointParticipantEntriesTable, PointParticipantRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PointParticipantEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pointIdMeta = const VerificationMeta(
    'pointId',
  );
  @override
  late final GeneratedColumn<String> pointId = GeneratedColumn<String>(
    'point_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES point_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _gameRosterIdMeta = const VerificationMeta(
    'gameRosterId',
  );
  @override
  late final GeneratedColumn<String> gameRosterId = GeneratedColumn<String>(
    'game_roster_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_roster_entries (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unknownMeta = const VerificationMeta(
    'unknown',
  );
  @override
  late final GeneratedColumn<bool> unknown = GeneratedColumn<bool>(
    'unknown',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("unknown" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pointId,
    gameRosterId,
    displayOrder,
    unknown,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'point_participant_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<PointParticipantRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('point_id')) {
      context.handle(
        _pointIdMeta,
        pointId.isAcceptableOrUnknown(data['point_id']!, _pointIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pointIdMeta);
    }
    if (data.containsKey('game_roster_id')) {
      context.handle(
        _gameRosterIdMeta,
        gameRosterId.isAcceptableOrUnknown(
          data['game_roster_id']!,
          _gameRosterIdMeta,
        ),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayOrderMeta);
    }
    if (data.containsKey('unknown')) {
      context.handle(
        _unknownMeta,
        unknown.isAcceptableOrUnknown(data['unknown']!, _unknownMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PointParticipantRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PointParticipantRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}point_id'],
      )!,
      gameRosterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_roster_id'],
      ),
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      unknown: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}unknown'],
      )!,
    );
  }

  @override
  $PointParticipantEntriesTable createAlias(String alias) {
    return $PointParticipantEntriesTable(attachedDatabase, alias);
  }
}

class PointParticipantRecord extends DataClass
    implements Insertable<PointParticipantRecord> {
  final String id;
  final String pointId;
  final String? gameRosterId;
  final int displayOrder;
  final bool unknown;
  const PointParticipantRecord({
    required this.id,
    required this.pointId,
    this.gameRosterId,
    required this.displayOrder,
    required this.unknown,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['point_id'] = Variable<String>(pointId);
    if (!nullToAbsent || gameRosterId != null) {
      map['game_roster_id'] = Variable<String>(gameRosterId);
    }
    map['display_order'] = Variable<int>(displayOrder);
    map['unknown'] = Variable<bool>(unknown);
    return map;
  }

  PointParticipantEntriesCompanion toCompanion(bool nullToAbsent) {
    return PointParticipantEntriesCompanion(
      id: Value(id),
      pointId: Value(pointId),
      gameRosterId: gameRosterId == null && nullToAbsent
          ? const Value.absent()
          : Value(gameRosterId),
      displayOrder: Value(displayOrder),
      unknown: Value(unknown),
    );
  }

  factory PointParticipantRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PointParticipantRecord(
      id: serializer.fromJson<String>(json['id']),
      pointId: serializer.fromJson<String>(json['pointId']),
      gameRosterId: serializer.fromJson<String?>(json['gameRosterId']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      unknown: serializer.fromJson<bool>(json['unknown']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pointId': serializer.toJson<String>(pointId),
      'gameRosterId': serializer.toJson<String?>(gameRosterId),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'unknown': serializer.toJson<bool>(unknown),
    };
  }

  PointParticipantRecord copyWith({
    String? id,
    String? pointId,
    Value<String?> gameRosterId = const Value.absent(),
    int? displayOrder,
    bool? unknown,
  }) => PointParticipantRecord(
    id: id ?? this.id,
    pointId: pointId ?? this.pointId,
    gameRosterId: gameRosterId.present ? gameRosterId.value : this.gameRosterId,
    displayOrder: displayOrder ?? this.displayOrder,
    unknown: unknown ?? this.unknown,
  );
  PointParticipantRecord copyWithCompanion(
    PointParticipantEntriesCompanion data,
  ) {
    return PointParticipantRecord(
      id: data.id.present ? data.id.value : this.id,
      pointId: data.pointId.present ? data.pointId.value : this.pointId,
      gameRosterId: data.gameRosterId.present
          ? data.gameRosterId.value
          : this.gameRosterId,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      unknown: data.unknown.present ? data.unknown.value : this.unknown,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PointParticipantRecord(')
          ..write('id: $id, ')
          ..write('pointId: $pointId, ')
          ..write('gameRosterId: $gameRosterId, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('unknown: $unknown')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pointId, gameRosterId, displayOrder, unknown);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PointParticipantRecord &&
          other.id == this.id &&
          other.pointId == this.pointId &&
          other.gameRosterId == this.gameRosterId &&
          other.displayOrder == this.displayOrder &&
          other.unknown == this.unknown);
}

class PointParticipantEntriesCompanion
    extends UpdateCompanion<PointParticipantRecord> {
  final Value<String> id;
  final Value<String> pointId;
  final Value<String?> gameRosterId;
  final Value<int> displayOrder;
  final Value<bool> unknown;
  final Value<int> rowid;
  const PointParticipantEntriesCompanion({
    this.id = const Value.absent(),
    this.pointId = const Value.absent(),
    this.gameRosterId = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.unknown = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PointParticipantEntriesCompanion.insert({
    required String id,
    required String pointId,
    this.gameRosterId = const Value.absent(),
    required int displayOrder,
    this.unknown = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pointId = Value(pointId),
       displayOrder = Value(displayOrder);
  static Insertable<PointParticipantRecord> custom({
    Expression<String>? id,
    Expression<String>? pointId,
    Expression<String>? gameRosterId,
    Expression<int>? displayOrder,
    Expression<bool>? unknown,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pointId != null) 'point_id': pointId,
      if (gameRosterId != null) 'game_roster_id': gameRosterId,
      if (displayOrder != null) 'display_order': displayOrder,
      if (unknown != null) 'unknown': unknown,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PointParticipantEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? pointId,
    Value<String?>? gameRosterId,
    Value<int>? displayOrder,
    Value<bool>? unknown,
    Value<int>? rowid,
  }) {
    return PointParticipantEntriesCompanion(
      id: id ?? this.id,
      pointId: pointId ?? this.pointId,
      gameRosterId: gameRosterId ?? this.gameRosterId,
      displayOrder: displayOrder ?? this.displayOrder,
      unknown: unknown ?? this.unknown,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pointId.present) {
      map['point_id'] = Variable<String>(pointId.value);
    }
    if (gameRosterId.present) {
      map['game_roster_id'] = Variable<String>(gameRosterId.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (unknown.present) {
      map['unknown'] = Variable<bool>(unknown.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PointParticipantEntriesCompanion(')
          ..write('id: $id, ')
          ..write('pointId: $pointId, ')
          ..write('gameRosterId: $gameRosterId, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('unknown: $unknown, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecordedActionEntriesTable extends RecordedActionEntries
    with TableInfo<$RecordedActionEntriesTable, RecordedActionRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordedActionEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES game_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pointIdMeta = const VerificationMeta(
    'pointId',
  );
  @override
  late final GeneratedColumn<String> pointId = GeneratedColumn<String>(
    'point_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES point_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sequenceMeta = const VerificationMeta(
    'sequence',
  );
  @override
  late final GeneratedColumn<int> sequence = GeneratedColumn<int>(
    'sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorParticipantIdMeta =
      const VerificationMeta('actorParticipantId');
  @override
  late final GeneratedColumn<String> actorParticipantId =
      GeneratedColumn<String>(
        'actor_participant_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES point_participant_entries (id) ON DELETE RESTRICT',
        ),
      );
  static const VerificationMeta _targetParticipantIdMeta =
      const VerificationMeta('targetParticipantId');
  @override
  late final GeneratedColumn<String> targetParticipantId =
      GeneratedColumn<String>(
        'target_participant_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES point_participant_entries (id) ON DELETE RESTRICT',
        ),
      );
  static const VerificationMeta _relatedActionIdMeta = const VerificationMeta(
    'relatedActionId',
  );
  @override
  late final GeneratedColumn<String> relatedActionId = GeneratedColumn<String>(
    'related_action_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gameId,
    pointId,
    sequence,
    kind,
    actorParticipantId,
    targetParticipantId,
    relatedActionId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recorded_action_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordedActionRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('point_id')) {
      context.handle(
        _pointIdMeta,
        pointId.isAcceptableOrUnknown(data['point_id']!, _pointIdMeta),
      );
    }
    if (data.containsKey('sequence')) {
      context.handle(
        _sequenceMeta,
        sequence.isAcceptableOrUnknown(data['sequence']!, _sequenceMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenceMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('actor_participant_id')) {
      context.handle(
        _actorParticipantIdMeta,
        actorParticipantId.isAcceptableOrUnknown(
          data['actor_participant_id']!,
          _actorParticipantIdMeta,
        ),
      );
    }
    if (data.containsKey('target_participant_id')) {
      context.handle(
        _targetParticipantIdMeta,
        targetParticipantId.isAcceptableOrUnknown(
          data['target_participant_id']!,
          _targetParticipantIdMeta,
        ),
      );
    }
    if (data.containsKey('related_action_id')) {
      context.handle(
        _relatedActionIdMeta,
        relatedActionId.isAcceptableOrUnknown(
          data['related_action_id']!,
          _relatedActionIdMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {gameId, sequence},
  ];
  @override
  RecordedActionRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordedActionRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      pointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}point_id'],
      ),
      sequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequence'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      actorParticipantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_participant_id'],
      ),
      targetParticipantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_participant_id'],
      ),
      relatedActionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}related_action_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RecordedActionEntriesTable createAlias(String alias) {
    return $RecordedActionEntriesTable(attachedDatabase, alias);
  }
}

class RecordedActionRecord extends DataClass
    implements Insertable<RecordedActionRecord> {
  final String id;
  final String gameId;
  final String? pointId;
  final int sequence;
  final String kind;
  final String? actorParticipantId;
  final String? targetParticipantId;
  final String? relatedActionId;
  final DateTime createdAt;
  const RecordedActionRecord({
    required this.id,
    required this.gameId,
    this.pointId,
    required this.sequence,
    required this.kind,
    this.actorParticipantId,
    this.targetParticipantId,
    this.relatedActionId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['game_id'] = Variable<String>(gameId);
    if (!nullToAbsent || pointId != null) {
      map['point_id'] = Variable<String>(pointId);
    }
    map['sequence'] = Variable<int>(sequence);
    map['kind'] = Variable<String>(kind);
    if (!nullToAbsent || actorParticipantId != null) {
      map['actor_participant_id'] = Variable<String>(actorParticipantId);
    }
    if (!nullToAbsent || targetParticipantId != null) {
      map['target_participant_id'] = Variable<String>(targetParticipantId);
    }
    if (!nullToAbsent || relatedActionId != null) {
      map['related_action_id'] = Variable<String>(relatedActionId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RecordedActionEntriesCompanion toCompanion(bool nullToAbsent) {
    return RecordedActionEntriesCompanion(
      id: Value(id),
      gameId: Value(gameId),
      pointId: pointId == null && nullToAbsent
          ? const Value.absent()
          : Value(pointId),
      sequence: Value(sequence),
      kind: Value(kind),
      actorParticipantId: actorParticipantId == null && nullToAbsent
          ? const Value.absent()
          : Value(actorParticipantId),
      targetParticipantId: targetParticipantId == null && nullToAbsent
          ? const Value.absent()
          : Value(targetParticipantId),
      relatedActionId: relatedActionId == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedActionId),
      createdAt: Value(createdAt),
    );
  }

  factory RecordedActionRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordedActionRecord(
      id: serializer.fromJson<String>(json['id']),
      gameId: serializer.fromJson<String>(json['gameId']),
      pointId: serializer.fromJson<String?>(json['pointId']),
      sequence: serializer.fromJson<int>(json['sequence']),
      kind: serializer.fromJson<String>(json['kind']),
      actorParticipantId: serializer.fromJson<String?>(
        json['actorParticipantId'],
      ),
      targetParticipantId: serializer.fromJson<String?>(
        json['targetParticipantId'],
      ),
      relatedActionId: serializer.fromJson<String?>(json['relatedActionId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gameId': serializer.toJson<String>(gameId),
      'pointId': serializer.toJson<String?>(pointId),
      'sequence': serializer.toJson<int>(sequence),
      'kind': serializer.toJson<String>(kind),
      'actorParticipantId': serializer.toJson<String?>(actorParticipantId),
      'targetParticipantId': serializer.toJson<String?>(targetParticipantId),
      'relatedActionId': serializer.toJson<String?>(relatedActionId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RecordedActionRecord copyWith({
    String? id,
    String? gameId,
    Value<String?> pointId = const Value.absent(),
    int? sequence,
    String? kind,
    Value<String?> actorParticipantId = const Value.absent(),
    Value<String?> targetParticipantId = const Value.absent(),
    Value<String?> relatedActionId = const Value.absent(),
    DateTime? createdAt,
  }) => RecordedActionRecord(
    id: id ?? this.id,
    gameId: gameId ?? this.gameId,
    pointId: pointId.present ? pointId.value : this.pointId,
    sequence: sequence ?? this.sequence,
    kind: kind ?? this.kind,
    actorParticipantId: actorParticipantId.present
        ? actorParticipantId.value
        : this.actorParticipantId,
    targetParticipantId: targetParticipantId.present
        ? targetParticipantId.value
        : this.targetParticipantId,
    relatedActionId: relatedActionId.present
        ? relatedActionId.value
        : this.relatedActionId,
    createdAt: createdAt ?? this.createdAt,
  );
  RecordedActionRecord copyWithCompanion(RecordedActionEntriesCompanion data) {
    return RecordedActionRecord(
      id: data.id.present ? data.id.value : this.id,
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      pointId: data.pointId.present ? data.pointId.value : this.pointId,
      sequence: data.sequence.present ? data.sequence.value : this.sequence,
      kind: data.kind.present ? data.kind.value : this.kind,
      actorParticipantId: data.actorParticipantId.present
          ? data.actorParticipantId.value
          : this.actorParticipantId,
      targetParticipantId: data.targetParticipantId.present
          ? data.targetParticipantId.value
          : this.targetParticipantId,
      relatedActionId: data.relatedActionId.present
          ? data.relatedActionId.value
          : this.relatedActionId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordedActionRecord(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('pointId: $pointId, ')
          ..write('sequence: $sequence, ')
          ..write('kind: $kind, ')
          ..write('actorParticipantId: $actorParticipantId, ')
          ..write('targetParticipantId: $targetParticipantId, ')
          ..write('relatedActionId: $relatedActionId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gameId,
    pointId,
    sequence,
    kind,
    actorParticipantId,
    targetParticipantId,
    relatedActionId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordedActionRecord &&
          other.id == this.id &&
          other.gameId == this.gameId &&
          other.pointId == this.pointId &&
          other.sequence == this.sequence &&
          other.kind == this.kind &&
          other.actorParticipantId == this.actorParticipantId &&
          other.targetParticipantId == this.targetParticipantId &&
          other.relatedActionId == this.relatedActionId &&
          other.createdAt == this.createdAt);
}

class RecordedActionEntriesCompanion
    extends UpdateCompanion<RecordedActionRecord> {
  final Value<String> id;
  final Value<String> gameId;
  final Value<String?> pointId;
  final Value<int> sequence;
  final Value<String> kind;
  final Value<String?> actorParticipantId;
  final Value<String?> targetParticipantId;
  final Value<String?> relatedActionId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RecordedActionEntriesCompanion({
    this.id = const Value.absent(),
    this.gameId = const Value.absent(),
    this.pointId = const Value.absent(),
    this.sequence = const Value.absent(),
    this.kind = const Value.absent(),
    this.actorParticipantId = const Value.absent(),
    this.targetParticipantId = const Value.absent(),
    this.relatedActionId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecordedActionEntriesCompanion.insert({
    required String id,
    required String gameId,
    this.pointId = const Value.absent(),
    required int sequence,
    required String kind,
    this.actorParticipantId = const Value.absent(),
    this.targetParticipantId = const Value.absent(),
    this.relatedActionId = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       gameId = Value(gameId),
       sequence = Value(sequence),
       kind = Value(kind),
       createdAt = Value(createdAt);
  static Insertable<RecordedActionRecord> custom({
    Expression<String>? id,
    Expression<String>? gameId,
    Expression<String>? pointId,
    Expression<int>? sequence,
    Expression<String>? kind,
    Expression<String>? actorParticipantId,
    Expression<String>? targetParticipantId,
    Expression<String>? relatedActionId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gameId != null) 'game_id': gameId,
      if (pointId != null) 'point_id': pointId,
      if (sequence != null) 'sequence': sequence,
      if (kind != null) 'kind': kind,
      if (actorParticipantId != null)
        'actor_participant_id': actorParticipantId,
      if (targetParticipantId != null)
        'target_participant_id': targetParticipantId,
      if (relatedActionId != null) 'related_action_id': relatedActionId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecordedActionEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? gameId,
    Value<String?>? pointId,
    Value<int>? sequence,
    Value<String>? kind,
    Value<String?>? actorParticipantId,
    Value<String?>? targetParticipantId,
    Value<String?>? relatedActionId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RecordedActionEntriesCompanion(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      pointId: pointId ?? this.pointId,
      sequence: sequence ?? this.sequence,
      kind: kind ?? this.kind,
      actorParticipantId: actorParticipantId ?? this.actorParticipantId,
      targetParticipantId: targetParticipantId ?? this.targetParticipantId,
      relatedActionId: relatedActionId ?? this.relatedActionId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (pointId.present) {
      map['point_id'] = Variable<String>(pointId.value);
    }
    if (sequence.present) {
      map['sequence'] = Variable<int>(sequence.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (actorParticipantId.present) {
      map['actor_participant_id'] = Variable<String>(actorParticipantId.value);
    }
    if (targetParticipantId.present) {
      map['target_participant_id'] = Variable<String>(
        targetParticipantId.value,
      );
    }
    if (relatedActionId.present) {
      map['related_action_id'] = Variable<String>(relatedActionId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordedActionEntriesCompanion(')
          ..write('id: $id, ')
          ..write('gameId: $gameId, ')
          ..write('pointId: $pointId, ')
          ..write('sequence: $sequence, ')
          ..write('kind: $kind, ')
          ..write('actorParticipantId: $actorParticipantId, ')
          ..write('targetParticipantId: $targetParticipantId, ')
          ..write('relatedActionId: $relatedActionId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingEntriesTable extends AppSettingEntries
    with TableInfo<$AppSettingEntriesTable, AppSettingRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_setting_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingRecord(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      ),
    );
  }

  @override
  $AppSettingEntriesTable createAlias(String alias) {
    return $AppSettingEntriesTable(attachedDatabase, alias);
  }
}

class AppSettingRecord extends DataClass
    implements Insertable<AppSettingRecord> {
  final String key;
  final String? value;
  const AppSettingRecord({required this.key, this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<String>(value);
    }
    return map;
  }

  AppSettingEntriesCompanion toCompanion(bool nullToAbsent) {
    return AppSettingEntriesCompanion(
      key: Value(key),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
    );
  }

  factory AppSettingRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingRecord(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String?>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String?>(value),
    };
  }

  AppSettingRecord copyWith({
    String? key,
    Value<String?> value = const Value.absent(),
  }) => AppSettingRecord(
    key: key ?? this.key,
    value: value.present ? value.value : this.value,
  );
  AppSettingRecord copyWithCompanion(AppSettingEntriesCompanion data) {
    return AppSettingRecord(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingRecord(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingRecord &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingEntriesCompanion extends UpdateCompanion<AppSettingRecord> {
  final Value<String> key;
  final Value<String?> value;
  final Value<int> rowid;
  const AppSettingEntriesCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingEntriesCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<AppSettingRecord> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingEntriesCompanion copyWith({
    Value<String>? key,
    Value<String?>? value,
    Value<int>? rowid,
  }) {
    return AppSettingEntriesCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingEntriesCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeamEntriesTable teamEntries = $TeamEntriesTable(this);
  late final $PlayerEntriesTable playerEntries = $PlayerEntriesTable(this);
  late final $CompetitionEventEntriesTable competitionEventEntries =
      $CompetitionEventEntriesTable(this);
  late final $EventRosterEntriesTable eventRosterEntries =
      $EventRosterEntriesTable(this);
  late final $LinePresetEntriesTable linePresetEntries =
      $LinePresetEntriesTable(this);
  late final $LinePresetMemberEntriesTable linePresetMemberEntries =
      $LinePresetMemberEntriesTable(this);
  late final $GameEntriesTable gameEntries = $GameEntriesTable(this);
  late final $GameRosterEntriesTable gameRosterEntries =
      $GameRosterEntriesTable(this);
  late final $PointEntriesTable pointEntries = $PointEntriesTable(this);
  late final $PointParticipantEntriesTable pointParticipantEntries =
      $PointParticipantEntriesTable(this);
  late final $RecordedActionEntriesTable recordedActionEntries =
      $RecordedActionEntriesTable(this);
  late final $AppSettingEntriesTable appSettingEntries =
      $AppSettingEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    teamEntries,
    playerEntries,
    competitionEventEntries,
    eventRosterEntries,
    linePresetEntries,
    linePresetMemberEntries,
    gameEntries,
    gameRosterEntries,
    pointEntries,
    pointParticipantEntries,
    recordedActionEntries,
    appSettingEntries,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'team_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('player_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'competition_event_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('event_roster_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'competition_event_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('line_preset_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'line_preset_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('line_preset_member_entries', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'competition_event_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('game_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('game_roster_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('point_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'point_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate('point_participant_entries', kind: UpdateKind.delete),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'game_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recorded_action_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'point_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recorded_action_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TeamEntriesTableCreateCompanionBuilder =
    TeamEntriesCompanion Function({
      required String id,
      required String name,
      required String teamType,
      Value<bool> archived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TeamEntriesTableUpdateCompanionBuilder =
    TeamEntriesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> teamType,
      Value<bool> archived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TeamEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $TeamEntriesTable, TeamRecord> {
  $$TeamEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlayerEntriesTable, List<PlayerRecord>>
  _playerEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerEntries,
    aliasName: 'team_entries__id__player_entries__team_id',
  );

  $$PlayerEntriesTableProcessedTableManager get playerEntriesRefs {
    final manager = $$PlayerEntriesTableTableManager(
      $_db,
      $_db.playerEntries,
    ).filter((f) => f.teamId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_playerEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CompetitionEventEntriesTable,
    List<CompetitionEventRecord>
  >
  _competitionEventEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.competitionEventEntries,
        aliasName: 'team_entries__id__competition_event_entries__team_id',
      );

  $$CompetitionEventEntriesTableProcessedTableManager
  get competitionEventEntriesRefs {
    final manager = $$CompetitionEventEntriesTableTableManager(
      $_db,
      $_db.competitionEventEntries,
    ).filter((f) => f.teamId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _competitionEventEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GameEntriesTable, List<GameRecord>>
  _gameEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gameEntries,
    aliasName: 'team_entries__id__game_entries__team_id',
  );

  $$GameEntriesTableProcessedTableManager get gameEntriesRefs {
    final manager = $$GameEntriesTableTableManager(
      $_db,
      $_db.gameEntries,
    ).filter((f) => f.teamId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gameEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TeamEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TeamEntriesTable> {
  $$TeamEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamType => $composableBuilder(
    column: $table.teamType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> playerEntriesRefs(
    Expression<bool> Function($$PlayerEntriesTableFilterComposer f) f,
  ) {
    final $$PlayerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> competitionEventEntriesRefs(
    Expression<bool> Function($$CompetitionEventEntriesTableFilterComposer f) f,
  ) {
    final $$CompetitionEventEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.teamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableFilterComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> gameEntriesRefs(
    Expression<bool> Function($$GameEntriesTableFilterComposer f) f,
  ) {
    final $$GameEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TeamEntriesTable> {
  $$TeamEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamType => $composableBuilder(
    column: $table.teamType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TeamEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeamEntriesTable> {
  $$TeamEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get teamType =>
      $composableBuilder(column: $table.teamType, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> playerEntriesRefs<T extends Object>(
    Expression<T> Function($$PlayerEntriesTableAnnotationComposer a) f,
  ) {
    final $$PlayerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> competitionEventEntriesRefs<T extends Object>(
    Expression<T> Function($$CompetitionEventEntriesTableAnnotationComposer a)
    f,
  ) {
    final $$CompetitionEventEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.teamId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> gameEntriesRefs<T extends Object>(
    Expression<T> Function($$GameEntriesTableAnnotationComposer a) f,
  ) {
    final $$GameEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TeamEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TeamEntriesTable,
          TeamRecord,
          $$TeamEntriesTableFilterComposer,
          $$TeamEntriesTableOrderingComposer,
          $$TeamEntriesTableAnnotationComposer,
          $$TeamEntriesTableCreateCompanionBuilder,
          $$TeamEntriesTableUpdateCompanionBuilder,
          (TeamRecord, $$TeamEntriesTableReferences),
          TeamRecord,
          PrefetchHooks Function({
            bool playerEntriesRefs,
            bool competitionEventEntriesRefs,
            bool gameEntriesRefs,
          })
        > {
  $$TeamEntriesTableTableManager(_$AppDatabase db, $TeamEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeamEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeamEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeamEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> teamType = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TeamEntriesCompanion(
                id: id,
                name: name,
                teamType: teamType,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String teamType,
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TeamEntriesCompanion.insert(
                id: id,
                name: name,
                teamType: teamType,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TeamEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                playerEntriesRefs = false,
                competitionEventEntriesRefs = false,
                gameEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playerEntriesRefs) db.playerEntries,
                    if (competitionEventEntriesRefs) db.competitionEventEntries,
                    if (gameEntriesRefs) db.gameEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (playerEntriesRefs)
                        await $_getPrefetchedData<
                          TeamRecord,
                          $TeamEntriesTable,
                          PlayerRecord
                        >(
                          currentTable: table,
                          referencedTable: $$TeamEntriesTableReferences
                              ._playerEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).playerEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (competitionEventEntriesRefs)
                        await $_getPrefetchedData<
                          TeamRecord,
                          $TeamEntriesTable,
                          CompetitionEventRecord
                        >(
                          currentTable: table,
                          referencedTable: $$TeamEntriesTableReferences
                              ._competitionEventEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).competitionEventEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gameEntriesRefs)
                        await $_getPrefetchedData<
                          TeamRecord,
                          $TeamEntriesTable,
                          GameRecord
                        >(
                          currentTable: table,
                          referencedTable: $$TeamEntriesTableReferences
                              ._gameEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TeamEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).gameEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TeamEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TeamEntriesTable,
      TeamRecord,
      $$TeamEntriesTableFilterComposer,
      $$TeamEntriesTableOrderingComposer,
      $$TeamEntriesTableAnnotationComposer,
      $$TeamEntriesTableCreateCompanionBuilder,
      $$TeamEntriesTableUpdateCompanionBuilder,
      (TeamRecord, $$TeamEntriesTableReferences),
      TeamRecord,
      PrefetchHooks Function({
        bool playerEntriesRefs,
        bool competitionEventEntriesRefs,
        bool gameEntriesRefs,
      })
    >;
typedef $$PlayerEntriesTableCreateCompanionBuilder =
    PlayerEntriesCompanion Function({
      required String id,
      required String teamId,
      required String name,
      required String gender,
      Value<String?> number,
      required String position,
      Value<bool> archived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$PlayerEntriesTableUpdateCompanionBuilder =
    PlayerEntriesCompanion Function({
      Value<String> id,
      Value<String> teamId,
      Value<String> name,
      Value<String> gender,
      Value<String?> number,
      Value<String> position,
      Value<bool> archived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$PlayerEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $PlayerEntriesTable, PlayerRecord> {
  $$PlayerEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TeamEntriesTable _teamIdTable(_$AppDatabase db) =>
      db.teamEntries.createAlias('player_entries__team_id__team_entries__id');

  $$TeamEntriesTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<String>('team_id')!;

    final manager = $$TeamEntriesTableTableManager(
      $_db,
      $_db.teamEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventRosterEntriesTable, List<EventRosterRecord>>
  _eventRosterEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventRosterEntries,
        aliasName: 'player_entries__id__event_roster_entries__player_id',
      );

  $$EventRosterEntriesTableProcessedTableManager get eventRosterEntriesRefs {
    final manager = $$EventRosterEntriesTableTableManager(
      $_db,
      $_db.eventRosterEntries,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventRosterEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LinePresetMemberEntriesTable,
    List<LinePresetMemberRecord>
  >
  _linePresetMemberEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.linePresetMemberEntries,
        aliasName: 'player_entries__id__line_preset_member_entries__player_id',
      );

  $$LinePresetMemberEntriesTableProcessedTableManager
  get linePresetMemberEntriesRefs {
    final manager = $$LinePresetMemberEntriesTableTableManager(
      $_db,
      $_db.linePresetMemberEntries,
    ).filter((f) => f.playerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _linePresetMemberEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayerEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerEntriesTable> {
  $$PlayerEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TeamEntriesTableFilterComposer get teamId {
    final $$TeamEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableFilterComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventRosterEntriesRefs(
    Expression<bool> Function($$EventRosterEntriesTableFilterComposer f) f,
  ) {
    final $$EventRosterEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRosterEntries,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRosterEntriesTableFilterComposer(
            $db: $db,
            $table: $db.eventRosterEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> linePresetMemberEntriesRefs(
    Expression<bool> Function($$LinePresetMemberEntriesTableFilterComposer f) f,
  ) {
    final $$LinePresetMemberEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.linePresetMemberEntries,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LinePresetMemberEntriesTableFilterComposer(
                $db: $db,
                $table: $db.linePresetMemberEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PlayerEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerEntriesTable> {
  $$PlayerEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TeamEntriesTableOrderingComposer get teamId {
    final $$TeamEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerEntriesTable> {
  $$PlayerEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TeamEntriesTableAnnotationComposer get teamId {
    final $$TeamEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventRosterEntriesRefs<T extends Object>(
    Expression<T> Function($$EventRosterEntriesTableAnnotationComposer a) f,
  ) {
    final $$EventRosterEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventRosterEntries,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventRosterEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.eventRosterEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> linePresetMemberEntriesRefs<T extends Object>(
    Expression<T> Function($$LinePresetMemberEntriesTableAnnotationComposer a)
    f,
  ) {
    final $$LinePresetMemberEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.linePresetMemberEntries,
          getReferencedColumn: (t) => t.playerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LinePresetMemberEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.linePresetMemberEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PlayerEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerEntriesTable,
          PlayerRecord,
          $$PlayerEntriesTableFilterComposer,
          $$PlayerEntriesTableOrderingComposer,
          $$PlayerEntriesTableAnnotationComposer,
          $$PlayerEntriesTableCreateCompanionBuilder,
          $$PlayerEntriesTableUpdateCompanionBuilder,
          (PlayerRecord, $$PlayerEntriesTableReferences),
          PlayerRecord,
          PrefetchHooks Function({
            bool teamId,
            bool eventRosterEntriesRefs,
            bool linePresetMemberEntriesRefs,
          })
        > {
  $$PlayerEntriesTableTableManager(_$AppDatabase db, $PlayerEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayerEntriesCompanion(
                id: id,
                teamId: teamId,
                name: name,
                gender: gender,
                number: number,
                position: position,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teamId,
                required String name,
                required String gender,
                Value<String?> number = const Value.absent(),
                required String position,
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => PlayerEntriesCompanion.insert(
                id: id,
                teamId: teamId,
                name: name,
                gender: gender,
                number: number,
                position: position,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayerEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                teamId = false,
                eventRosterEntriesRefs = false,
                linePresetMemberEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventRosterEntriesRefs) db.eventRosterEntries,
                    if (linePresetMemberEntriesRefs) db.linePresetMemberEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (teamId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.teamId,
                            referencedTable: $$PlayerEntriesTableReferences
                                ._teamIdTable(db),
                            referencedColumn: $$PlayerEntriesTableReferences
                                ._teamIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventRosterEntriesRefs)
                        await $_getPrefetchedData<
                          PlayerRecord,
                          $PlayerEntriesTable,
                          EventRosterRecord
                        >(
                          currentTable: table,
                          referencedTable: $$PlayerEntriesTableReferences
                              ._eventRosterEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayerEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).eventRosterEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (linePresetMemberEntriesRefs)
                        await $_getPrefetchedData<
                          PlayerRecord,
                          $PlayerEntriesTable,
                          LinePresetMemberRecord
                        >(
                          currentTable: table,
                          referencedTable: $$PlayerEntriesTableReferences
                              ._linePresetMemberEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PlayerEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).linePresetMemberEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.playerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PlayerEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerEntriesTable,
      PlayerRecord,
      $$PlayerEntriesTableFilterComposer,
      $$PlayerEntriesTableOrderingComposer,
      $$PlayerEntriesTableAnnotationComposer,
      $$PlayerEntriesTableCreateCompanionBuilder,
      $$PlayerEntriesTableUpdateCompanionBuilder,
      (PlayerRecord, $$PlayerEntriesTableReferences),
      PlayerRecord,
      PrefetchHooks Function({
        bool teamId,
        bool eventRosterEntriesRefs,
        bool linePresetMemberEntriesRefs,
      })
    >;
typedef $$CompetitionEventEntriesTableCreateCompanionBuilder =
    CompetitionEventEntriesCompanion Function({
      required String id,
      required String teamId,
      required String name,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<String?> location,
      Value<String?> notes,
      Value<bool> archived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CompetitionEventEntriesTableUpdateCompanionBuilder =
    CompetitionEventEntriesCompanion Function({
      Value<String> id,
      Value<String> teamId,
      Value<String> name,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<String?> location,
      Value<String?> notes,
      Value<bool> archived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CompetitionEventEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CompetitionEventEntriesTable,
          CompetitionEventRecord
        > {
  $$CompetitionEventEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TeamEntriesTable _teamIdTable(_$AppDatabase db) => db.teamEntries
      .createAlias('competition_event_entries__team_id__team_entries__id');

  $$TeamEntriesTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<String>('team_id')!;

    final manager = $$TeamEntriesTableTableManager(
      $_db,
      $_db.teamEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EventRosterEntriesTable, List<EventRosterRecord>>
  _eventRosterEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.eventRosterEntries,
        aliasName:
            'competition_event_entries__id__event_roster_entries__event_id',
      );

  $$EventRosterEntriesTableProcessedTableManager get eventRosterEntriesRefs {
    final manager = $$EventRosterEntriesTableTableManager(
      $_db,
      $_db.eventRosterEntries,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _eventRosterEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LinePresetEntriesTable, List<LinePresetRecord>>
  _linePresetEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.linePresetEntries,
        aliasName:
            'competition_event_entries__id__line_preset_entries__event_id',
      );

  $$LinePresetEntriesTableProcessedTableManager get linePresetEntriesRefs {
    final manager = $$LinePresetEntriesTableTableManager(
      $_db,
      $_db.linePresetEntries,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _linePresetEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GameEntriesTable, List<GameRecord>>
  _gameEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.gameEntries,
    aliasName: 'competition_event_entries__id__game_entries__event_id',
  );

  $$GameEntriesTableProcessedTableManager get gameEntriesRefs {
    final manager = $$GameEntriesTableTableManager(
      $_db,
      $_db.gameEntries,
    ).filter((f) => f.eventId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gameEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompetitionEventEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CompetitionEventEntriesTable> {
  $$CompetitionEventEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TeamEntriesTableFilterComposer get teamId {
    final $$TeamEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableFilterComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> eventRosterEntriesRefs(
    Expression<bool> Function($$EventRosterEntriesTableFilterComposer f) f,
  ) {
    final $$EventRosterEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.eventRosterEntries,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EventRosterEntriesTableFilterComposer(
            $db: $db,
            $table: $db.eventRosterEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> linePresetEntriesRefs(
    Expression<bool> Function($$LinePresetEntriesTableFilterComposer f) f,
  ) {
    final $$LinePresetEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.linePresetEntries,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LinePresetEntriesTableFilterComposer(
            $db: $db,
            $table: $db.linePresetEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gameEntriesRefs(
    Expression<bool> Function($$GameEntriesTableFilterComposer f) f,
  ) {
    final $$GameEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompetitionEventEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompetitionEventEntriesTable> {
  $$CompetitionEventEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TeamEntriesTableOrderingComposer get teamId {
    final $$TeamEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CompetitionEventEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompetitionEventEntriesTable> {
  $$CompetitionEventEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TeamEntriesTableAnnotationComposer get teamId {
    final $$TeamEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> eventRosterEntriesRefs<T extends Object>(
    Expression<T> Function($$EventRosterEntriesTableAnnotationComposer a) f,
  ) {
    final $$EventRosterEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.eventRosterEntries,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EventRosterEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.eventRosterEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> linePresetEntriesRefs<T extends Object>(
    Expression<T> Function($$LinePresetEntriesTableAnnotationComposer a) f,
  ) {
    final $$LinePresetEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.linePresetEntries,
          getReferencedColumn: (t) => t.eventId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LinePresetEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.linePresetEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> gameEntriesRefs<T extends Object>(
    Expression<T> Function($$GameEntriesTableAnnotationComposer a) f,
  ) {
    final $$GameEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.eventId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompetitionEventEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompetitionEventEntriesTable,
          CompetitionEventRecord,
          $$CompetitionEventEntriesTableFilterComposer,
          $$CompetitionEventEntriesTableOrderingComposer,
          $$CompetitionEventEntriesTableAnnotationComposer,
          $$CompetitionEventEntriesTableCreateCompanionBuilder,
          $$CompetitionEventEntriesTableUpdateCompanionBuilder,
          (CompetitionEventRecord, $$CompetitionEventEntriesTableReferences),
          CompetitionEventRecord,
          PrefetchHooks Function({
            bool teamId,
            bool eventRosterEntriesRefs,
            bool linePresetEntriesRefs,
            bool gameEntriesRefs,
          })
        > {
  $$CompetitionEventEntriesTableTableManager(
    _$AppDatabase db,
    $CompetitionEventEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompetitionEventEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CompetitionEventEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CompetitionEventEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompetitionEventEntriesCompanion(
                id: id,
                teamId: teamId,
                name: name,
                startDate: startDate,
                endDate: endDate,
                location: location,
                notes: notes,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String teamId,
                required String name,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CompetitionEventEntriesCompanion.insert(
                id: id,
                teamId: teamId,
                name: name,
                startDate: startDate,
                endDate: endDate,
                location: location,
                notes: notes,
                archived: archived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompetitionEventEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                teamId = false,
                eventRosterEntriesRefs = false,
                linePresetEntriesRefs = false,
                gameEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (eventRosterEntriesRefs) db.eventRosterEntries,
                    if (linePresetEntriesRefs) db.linePresetEntries,
                    if (gameEntriesRefs) db.gameEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (teamId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.teamId,
                            referencedTable:
                                $$CompetitionEventEntriesTableReferences
                                    ._teamIdTable(db),
                            referencedColumn:
                                $$CompetitionEventEntriesTableReferences
                                    ._teamIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (eventRosterEntriesRefs)
                        await $_getPrefetchedData<
                          CompetitionEventRecord,
                          $CompetitionEventEntriesTable,
                          EventRosterRecord
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CompetitionEventEntriesTableReferences
                                  ._eventRosterEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompetitionEventEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).eventRosterEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (linePresetEntriesRefs)
                        await $_getPrefetchedData<
                          CompetitionEventRecord,
                          $CompetitionEventEntriesTable,
                          LinePresetRecord
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CompetitionEventEntriesTableReferences
                                  ._linePresetEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompetitionEventEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).linePresetEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (gameEntriesRefs)
                        await $_getPrefetchedData<
                          CompetitionEventRecord,
                          $CompetitionEventEntriesTable,
                          GameRecord
                        >(
                          currentTable: table,
                          referencedTable:
                              $$CompetitionEventEntriesTableReferences
                                  ._gameEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CompetitionEventEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).gameEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.eventId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CompetitionEventEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompetitionEventEntriesTable,
      CompetitionEventRecord,
      $$CompetitionEventEntriesTableFilterComposer,
      $$CompetitionEventEntriesTableOrderingComposer,
      $$CompetitionEventEntriesTableAnnotationComposer,
      $$CompetitionEventEntriesTableCreateCompanionBuilder,
      $$CompetitionEventEntriesTableUpdateCompanionBuilder,
      (CompetitionEventRecord, $$CompetitionEventEntriesTableReferences),
      CompetitionEventRecord,
      PrefetchHooks Function({
        bool teamId,
        bool eventRosterEntriesRefs,
        bool linePresetEntriesRefs,
        bool gameEntriesRefs,
      })
    >;
typedef $$EventRosterEntriesTableCreateCompanionBuilder =
    EventRosterEntriesCompanion Function({
      required String eventId,
      required String playerId,
      required DateTime addedAt,
      Value<int> rowid,
    });
typedef $$EventRosterEntriesTableUpdateCompanionBuilder =
    EventRosterEntriesCompanion Function({
      Value<String> eventId,
      Value<String> playerId,
      Value<DateTime> addedAt,
      Value<int> rowid,
    });

final class $$EventRosterEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EventRosterEntriesTable,
          EventRosterRecord
        > {
  $$EventRosterEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CompetitionEventEntriesTable _eventIdTable(_$AppDatabase db) =>
      db.competitionEventEntries.createAlias(
        'event_roster_entries__event_id__competition_event_entries__id',
      );

  $$CompetitionEventEntriesTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$CompetitionEventEntriesTableTableManager(
      $_db,
      $_db.competitionEventEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayerEntriesTable _playerIdTable(_$AppDatabase db) => db
      .playerEntries
      .createAlias('event_roster_entries__player_id__player_entries__id');

  $$PlayerEntriesTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager = $$PlayerEntriesTableTableManager(
      $_db,
      $_db.playerEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EventRosterEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EventRosterEntriesTable> {
  $$EventRosterEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CompetitionEventEntriesTableFilterComposer get eventId {
    final $$CompetitionEventEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableFilterComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PlayerEntriesTableFilterComposer get playerId {
    final $$PlayerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRosterEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EventRosterEntriesTable> {
  $$EventRosterEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompetitionEventEntriesTableOrderingComposer get eventId {
    final $$CompetitionEventEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PlayerEntriesTableOrderingComposer get playerId {
    final $$PlayerEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRosterEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventRosterEntriesTable> {
  $$EventRosterEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);

  $$CompetitionEventEntriesTableAnnotationComposer get eventId {
    final $$CompetitionEventEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PlayerEntriesTableAnnotationComposer get playerId {
    final $$PlayerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EventRosterEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventRosterEntriesTable,
          EventRosterRecord,
          $$EventRosterEntriesTableFilterComposer,
          $$EventRosterEntriesTableOrderingComposer,
          $$EventRosterEntriesTableAnnotationComposer,
          $$EventRosterEntriesTableCreateCompanionBuilder,
          $$EventRosterEntriesTableUpdateCompanionBuilder,
          (EventRosterRecord, $$EventRosterEntriesTableReferences),
          EventRosterRecord,
          PrefetchHooks Function({bool eventId, bool playerId})
        > {
  $$EventRosterEntriesTableTableManager(
    _$AppDatabase db,
    $EventRosterEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventRosterEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventRosterEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventRosterEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> eventId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventRosterEntriesCompanion(
                eventId: eventId,
                playerId: playerId,
                addedAt: addedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String eventId,
                required String playerId,
                required DateTime addedAt,
                Value<int> rowid = const Value.absent(),
              }) => EventRosterEntriesCompanion.insert(
                eventId: eventId,
                playerId: playerId,
                addedAt: addedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EventRosterEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({eventId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (eventId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.eventId,
                        referencedTable: $$EventRosterEntriesTableReferences
                            ._eventIdTable(db),
                        referencedColumn: $$EventRosterEntriesTableReferences
                            ._eventIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (playerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.playerId,
                        referencedTable: $$EventRosterEntriesTableReferences
                            ._playerIdTable(db),
                        referencedColumn: $$EventRosterEntriesTableReferences
                            ._playerIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$EventRosterEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventRosterEntriesTable,
      EventRosterRecord,
      $$EventRosterEntriesTableFilterComposer,
      $$EventRosterEntriesTableOrderingComposer,
      $$EventRosterEntriesTableAnnotationComposer,
      $$EventRosterEntriesTableCreateCompanionBuilder,
      $$EventRosterEntriesTableUpdateCompanionBuilder,
      (EventRosterRecord, $$EventRosterEntriesTableReferences),
      EventRosterRecord,
      PrefetchHooks Function({bool eventId, bool playerId})
    >;
typedef $$LinePresetEntriesTableCreateCompanionBuilder =
    LinePresetEntriesCompanion Function({
      required String id,
      required String eventId,
      required String name,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$LinePresetEntriesTableUpdateCompanionBuilder =
    LinePresetEntriesCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$LinePresetEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LinePresetEntriesTable,
          LinePresetRecord
        > {
  $$LinePresetEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CompetitionEventEntriesTable _eventIdTable(_$AppDatabase db) =>
      db.competitionEventEntries.createAlias(
        'line_preset_entries__event_id__competition_event_entries__id',
      );

  $$CompetitionEventEntriesTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$CompetitionEventEntriesTableTableManager(
      $_db,
      $_db.competitionEventEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LinePresetMemberEntriesTable,
    List<LinePresetMemberRecord>
  >
  _linePresetMemberEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.linePresetMemberEntries,
        aliasName:
            'line_preset_entries__id__line_preset_member_entries__line_id',
      );

  $$LinePresetMemberEntriesTableProcessedTableManager
  get linePresetMemberEntriesRefs {
    final manager = $$LinePresetMemberEntriesTableTableManager(
      $_db,
      $_db.linePresetMemberEntries,
    ).filter((f) => f.lineId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _linePresetMemberEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LinePresetEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LinePresetEntriesTable> {
  $$LinePresetEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CompetitionEventEntriesTableFilterComposer get eventId {
    final $$CompetitionEventEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableFilterComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> linePresetMemberEntriesRefs(
    Expression<bool> Function($$LinePresetMemberEntriesTableFilterComposer f) f,
  ) {
    final $$LinePresetMemberEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.linePresetMemberEntries,
          getReferencedColumn: (t) => t.lineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LinePresetMemberEntriesTableFilterComposer(
                $db: $db,
                $table: $db.linePresetMemberEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LinePresetEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LinePresetEntriesTable> {
  $$LinePresetEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompetitionEventEntriesTableOrderingComposer get eventId {
    final $$CompetitionEventEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LinePresetEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LinePresetEntriesTable> {
  $$LinePresetEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CompetitionEventEntriesTableAnnotationComposer get eventId {
    final $$CompetitionEventEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> linePresetMemberEntriesRefs<T extends Object>(
    Expression<T> Function($$LinePresetMemberEntriesTableAnnotationComposer a)
    f,
  ) {
    final $$LinePresetMemberEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.linePresetMemberEntries,
          getReferencedColumn: (t) => t.lineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LinePresetMemberEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.linePresetMemberEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LinePresetEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LinePresetEntriesTable,
          LinePresetRecord,
          $$LinePresetEntriesTableFilterComposer,
          $$LinePresetEntriesTableOrderingComposer,
          $$LinePresetEntriesTableAnnotationComposer,
          $$LinePresetEntriesTableCreateCompanionBuilder,
          $$LinePresetEntriesTableUpdateCompanionBuilder,
          (LinePresetRecord, $$LinePresetEntriesTableReferences),
          LinePresetRecord,
          PrefetchHooks Function({
            bool eventId,
            bool linePresetMemberEntriesRefs,
          })
        > {
  $$LinePresetEntriesTableTableManager(
    _$AppDatabase db,
    $LinePresetEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LinePresetEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LinePresetEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LinePresetEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LinePresetEntriesCompanion(
                id: id,
                eventId: eventId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required String name,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LinePresetEntriesCompanion.insert(
                id: id,
                eventId: eventId,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LinePresetEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({eventId = false, linePresetMemberEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (linePresetMemberEntriesRefs) db.linePresetMemberEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (eventId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.eventId,
                            referencedTable: $$LinePresetEntriesTableReferences
                                ._eventIdTable(db),
                            referencedColumn: $$LinePresetEntriesTableReferences
                                ._eventIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (linePresetMemberEntriesRefs)
                        await $_getPrefetchedData<
                          LinePresetRecord,
                          $LinePresetEntriesTable,
                          LinePresetMemberRecord
                        >(
                          currentTable: table,
                          referencedTable: $$LinePresetEntriesTableReferences
                              ._linePresetMemberEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LinePresetEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).linePresetMemberEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lineId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LinePresetEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LinePresetEntriesTable,
      LinePresetRecord,
      $$LinePresetEntriesTableFilterComposer,
      $$LinePresetEntriesTableOrderingComposer,
      $$LinePresetEntriesTableAnnotationComposer,
      $$LinePresetEntriesTableCreateCompanionBuilder,
      $$LinePresetEntriesTableUpdateCompanionBuilder,
      (LinePresetRecord, $$LinePresetEntriesTableReferences),
      LinePresetRecord,
      PrefetchHooks Function({bool eventId, bool linePresetMemberEntriesRefs})
    >;
typedef $$LinePresetMemberEntriesTableCreateCompanionBuilder =
    LinePresetMemberEntriesCompanion Function({
      required String lineId,
      required String playerId,
      Value<int> rowid,
    });
typedef $$LinePresetMemberEntriesTableUpdateCompanionBuilder =
    LinePresetMemberEntriesCompanion Function({
      Value<String> lineId,
      Value<String> playerId,
      Value<int> rowid,
    });

final class $$LinePresetMemberEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LinePresetMemberEntriesTable,
          LinePresetMemberRecord
        > {
  $$LinePresetMemberEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LinePresetEntriesTable _lineIdTable(_$AppDatabase db) =>
      db.linePresetEntries.createAlias(
        'line_preset_member_entries__line_id__line_preset_entries__id',
      );

  $$LinePresetEntriesTableProcessedTableManager get lineId {
    final $_column = $_itemColumn<String>('line_id')!;

    final manager = $$LinePresetEntriesTableTableManager(
      $_db,
      $_db.linePresetEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PlayerEntriesTable _playerIdTable(_$AppDatabase db) => db
      .playerEntries
      .createAlias('line_preset_member_entries__player_id__player_entries__id');

  $$PlayerEntriesTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager = $$PlayerEntriesTableTableManager(
      $_db,
      $_db.playerEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LinePresetMemberEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $LinePresetMemberEntriesTable> {
  $$LinePresetMemberEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$LinePresetEntriesTableFilterComposer get lineId {
    final $$LinePresetEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lineId,
      referencedTable: $db.linePresetEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LinePresetEntriesTableFilterComposer(
            $db: $db,
            $table: $db.linePresetEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerEntriesTableFilterComposer get playerId {
    final $$PlayerEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableFilterComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LinePresetMemberEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LinePresetMemberEntriesTable> {
  $$LinePresetMemberEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$LinePresetEntriesTableOrderingComposer get lineId {
    final $$LinePresetEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lineId,
      referencedTable: $db.linePresetEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LinePresetEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.linePresetEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PlayerEntriesTableOrderingComposer get playerId {
    final $$PlayerEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LinePresetMemberEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LinePresetMemberEntriesTable> {
  $$LinePresetMemberEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$LinePresetEntriesTableAnnotationComposer get lineId {
    final $$LinePresetEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.lineId,
          referencedTable: $db.linePresetEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LinePresetEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.linePresetEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PlayerEntriesTableAnnotationComposer get playerId {
    final $$PlayerEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.playerEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LinePresetMemberEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LinePresetMemberEntriesTable,
          LinePresetMemberRecord,
          $$LinePresetMemberEntriesTableFilterComposer,
          $$LinePresetMemberEntriesTableOrderingComposer,
          $$LinePresetMemberEntriesTableAnnotationComposer,
          $$LinePresetMemberEntriesTableCreateCompanionBuilder,
          $$LinePresetMemberEntriesTableUpdateCompanionBuilder,
          (LinePresetMemberRecord, $$LinePresetMemberEntriesTableReferences),
          LinePresetMemberRecord,
          PrefetchHooks Function({bool lineId, bool playerId})
        > {
  $$LinePresetMemberEntriesTableTableManager(
    _$AppDatabase db,
    $LinePresetMemberEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LinePresetMemberEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LinePresetMemberEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LinePresetMemberEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> lineId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LinePresetMemberEntriesCompanion(
                lineId: lineId,
                playerId: playerId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String lineId,
                required String playerId,
                Value<int> rowid = const Value.absent(),
              }) => LinePresetMemberEntriesCompanion.insert(
                lineId: lineId,
                playerId: playerId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LinePresetMemberEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lineId = false, playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.lineId,
                        referencedTable:
                            $$LinePresetMemberEntriesTableReferences
                                ._lineIdTable(db),
                        referencedColumn:
                            $$LinePresetMemberEntriesTableReferences
                                ._lineIdTable(db)
                                .id,
                      ) as T;
                    }
                    if (playerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.playerId,
                        referencedTable:
                            $$LinePresetMemberEntriesTableReferences
                                ._playerIdTable(db),
                        referencedColumn:
                            $$LinePresetMemberEntriesTableReferences
                                ._playerIdTable(db)
                                .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LinePresetMemberEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LinePresetMemberEntriesTable,
      LinePresetMemberRecord,
      $$LinePresetMemberEntriesTableFilterComposer,
      $$LinePresetMemberEntriesTableOrderingComposer,
      $$LinePresetMemberEntriesTableAnnotationComposer,
      $$LinePresetMemberEntriesTableCreateCompanionBuilder,
      $$LinePresetMemberEntriesTableUpdateCompanionBuilder,
      (LinePresetMemberRecord, $$LinePresetMemberEntriesTableReferences),
      LinePresetMemberRecord,
      PrefetchHooks Function({bool lineId, bool playerId})
    >;
typedef $$GameEntriesTableCreateCompanionBuilder =
    GameEntriesCompanion Function({
      required String id,
      required String eventId,
      required String teamId,
      required String teamName,
      required String teamType,
      required String opponentName,
      required String openingMode,
      Value<int?> softCapMinutes,
      Value<int?> totalCapMinutes,
      Value<int?> maxPoints,
      Value<String?> firstRatio,
      required String status,
      required DateTime createdAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<bool> softCapAcknowledged,
      Value<bool> totalCapAcknowledged,
      Value<int> rowid,
    });
typedef $$GameEntriesTableUpdateCompanionBuilder =
    GameEntriesCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<String> teamId,
      Value<String> teamName,
      Value<String> teamType,
      Value<String> opponentName,
      Value<String> openingMode,
      Value<int?> softCapMinutes,
      Value<int?> totalCapMinutes,
      Value<int?> maxPoints,
      Value<String?> firstRatio,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<bool> softCapAcknowledged,
      Value<bool> totalCapAcknowledged,
      Value<int> rowid,
    });

final class $$GameEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $GameEntriesTable, GameRecord> {
  $$GameEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CompetitionEventEntriesTable _eventIdTable(_$AppDatabase db) => db
      .competitionEventEntries
      .createAlias('game_entries__event_id__competition_event_entries__id');

  $$CompetitionEventEntriesTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<String>('event_id')!;

    final manager = $$CompetitionEventEntriesTableTableManager(
      $_db,
      $_db.competitionEventEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TeamEntriesTable _teamIdTable(_$AppDatabase db) =>
      db.teamEntries.createAlias('game_entries__team_id__team_entries__id');

  $$TeamEntriesTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<String>('team_id')!;

    final manager = $$TeamEntriesTableTableManager(
      $_db,
      $_db.teamEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$GameRosterEntriesTable, List<GameRosterRecord>>
  _gameRosterEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.gameRosterEntries,
        aliasName: 'game_entries__id__game_roster_entries__game_id',
      );

  $$GameRosterEntriesTableProcessedTableManager get gameRosterEntriesRefs {
    final manager = $$GameRosterEntriesTableTableManager(
      $_db,
      $_db.gameRosterEntries,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _gameRosterEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PointEntriesTable, List<PointRecordRow>>
  _pointEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pointEntries,
    aliasName: 'game_entries__id__point_entries__game_id',
  );

  $$PointEntriesTableProcessedTableManager get pointEntriesRefs {
    final manager = $$PointEntriesTableTableManager(
      $_db,
      $_db.pointEntries,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pointEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecordedActionEntriesTable,
    List<RecordedActionRecord>
  >
  _recordedActionEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recordedActionEntries,
        aliasName: 'game_entries__id__recorded_action_entries__game_id',
      );

  $$RecordedActionEntriesTableProcessedTableManager
  get recordedActionEntriesRefs {
    final manager = $$RecordedActionEntriesTableTableManager(
      $_db,
      $_db.recordedActionEntries,
    ).filter((f) => f.gameId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recordedActionEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GameEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $GameEntriesTable> {
  $$GameEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamType => $composableBuilder(
    column: $table.teamType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get opponentName => $composableBuilder(
    column: $table.opponentName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get openingMode => $composableBuilder(
    column: $table.openingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get softCapMinutes => $composableBuilder(
    column: $table.softCapMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalCapMinutes => $composableBuilder(
    column: $table.totalCapMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxPoints => $composableBuilder(
    column: $table.maxPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstRatio => $composableBuilder(
    column: $table.firstRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get softCapAcknowledged => $composableBuilder(
    column: $table.softCapAcknowledged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get totalCapAcknowledged => $composableBuilder(
    column: $table.totalCapAcknowledged,
    builder: (column) => ColumnFilters(column),
  );

  $$CompetitionEventEntriesTableFilterComposer get eventId {
    final $$CompetitionEventEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableFilterComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TeamEntriesTableFilterComposer get teamId {
    final $$TeamEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableFilterComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> gameRosterEntriesRefs(
    Expression<bool> Function($$GameRosterEntriesTableFilterComposer f) f,
  ) {
    final $$GameRosterEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gameRosterEntries,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameRosterEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gameRosterEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pointEntriesRefs(
    Expression<bool> Function($$PointEntriesTableFilterComposer f) f,
  ) {
    final $$PointEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableFilterComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> recordedActionEntriesRefs(
    Expression<bool> Function($$RecordedActionEntriesTableFilterComposer f) f,
  ) {
    final $$RecordedActionEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.gameId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableFilterComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GameEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GameEntriesTable> {
  $$GameEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamName => $composableBuilder(
    column: $table.teamName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamType => $composableBuilder(
    column: $table.teamType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get opponentName => $composableBuilder(
    column: $table.opponentName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get openingMode => $composableBuilder(
    column: $table.openingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get softCapMinutes => $composableBuilder(
    column: $table.softCapMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalCapMinutes => $composableBuilder(
    column: $table.totalCapMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxPoints => $composableBuilder(
    column: $table.maxPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstRatio => $composableBuilder(
    column: $table.firstRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get softCapAcknowledged => $composableBuilder(
    column: $table.softCapAcknowledged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get totalCapAcknowledged => $composableBuilder(
    column: $table.totalCapAcknowledged,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompetitionEventEntriesTableOrderingComposer get eventId {
    final $$CompetitionEventEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TeamEntriesTableOrderingComposer get teamId {
    final $$TeamEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GameEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameEntriesTable> {
  $$GameEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get teamName =>
      $composableBuilder(column: $table.teamName, builder: (column) => column);

  GeneratedColumn<String> get teamType =>
      $composableBuilder(column: $table.teamType, builder: (column) => column);

  GeneratedColumn<String> get opponentName => $composableBuilder(
    column: $table.opponentName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get openingMode => $composableBuilder(
    column: $table.openingMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get softCapMinutes => $composableBuilder(
    column: $table.softCapMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalCapMinutes => $composableBuilder(
    column: $table.totalCapMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxPoints =>
      $composableBuilder(column: $table.maxPoints, builder: (column) => column);

  GeneratedColumn<String> get firstRatio => $composableBuilder(
    column: $table.firstRatio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get softCapAcknowledged => $composableBuilder(
    column: $table.softCapAcknowledged,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get totalCapAcknowledged => $composableBuilder(
    column: $table.totalCapAcknowledged,
    builder: (column) => column,
  );

  $$CompetitionEventEntriesTableAnnotationComposer get eventId {
    final $$CompetitionEventEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.eventId,
          referencedTable: $db.competitionEventEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CompetitionEventEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.competitionEventEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TeamEntriesTableAnnotationComposer get teamId {
    final $$TeamEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.teamEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TeamEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.teamEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> gameRosterEntriesRefs<T extends Object>(
    Expression<T> Function($$GameRosterEntriesTableAnnotationComposer a) f,
  ) {
    final $$GameRosterEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.gameRosterEntries,
          getReferencedColumn: (t) => t.gameId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GameRosterEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.gameRosterEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> pointEntriesRefs<T extends Object>(
    Expression<T> Function($$PointEntriesTableAnnotationComposer a) f,
  ) {
    final $$PointEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.gameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> recordedActionEntriesRefs<T extends Object>(
    Expression<T> Function($$RecordedActionEntriesTableAnnotationComposer a) f,
  ) {
    final $$RecordedActionEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.gameId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GameEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameEntriesTable,
          GameRecord,
          $$GameEntriesTableFilterComposer,
          $$GameEntriesTableOrderingComposer,
          $$GameEntriesTableAnnotationComposer,
          $$GameEntriesTableCreateCompanionBuilder,
          $$GameEntriesTableUpdateCompanionBuilder,
          (GameRecord, $$GameEntriesTableReferences),
          GameRecord,
          PrefetchHooks Function({
            bool eventId,
            bool teamId,
            bool gameRosterEntriesRefs,
            bool pointEntriesRefs,
            bool recordedActionEntriesRefs,
          })
        > {
  $$GameEntriesTableTableManager(_$AppDatabase db, $GameEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> teamName = const Value.absent(),
                Value<String> teamType = const Value.absent(),
                Value<String> opponentName = const Value.absent(),
                Value<String> openingMode = const Value.absent(),
                Value<int?> softCapMinutes = const Value.absent(),
                Value<int?> totalCapMinutes = const Value.absent(),
                Value<int?> maxPoints = const Value.absent(),
                Value<String?> firstRatio = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> softCapAcknowledged = const Value.absent(),
                Value<bool> totalCapAcknowledged = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameEntriesCompanion(
                id: id,
                eventId: eventId,
                teamId: teamId,
                teamName: teamName,
                teamType: teamType,
                opponentName: opponentName,
                openingMode: openingMode,
                softCapMinutes: softCapMinutes,
                totalCapMinutes: totalCapMinutes,
                maxPoints: maxPoints,
                firstRatio: firstRatio,
                status: status,
                createdAt: createdAt,
                startedAt: startedAt,
                completedAt: completedAt,
                softCapAcknowledged: softCapAcknowledged,
                totalCapAcknowledged: totalCapAcknowledged,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required String teamId,
                required String teamName,
                required String teamType,
                required String opponentName,
                required String openingMode,
                Value<int?> softCapMinutes = const Value.absent(),
                Value<int?> totalCapMinutes = const Value.absent(),
                Value<int?> maxPoints = const Value.absent(),
                Value<String?> firstRatio = const Value.absent(),
                required String status,
                required DateTime createdAt,
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<bool> softCapAcknowledged = const Value.absent(),
                Value<bool> totalCapAcknowledged = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameEntriesCompanion.insert(
                id: id,
                eventId: eventId,
                teamId: teamId,
                teamName: teamName,
                teamType: teamType,
                opponentName: opponentName,
                openingMode: openingMode,
                softCapMinutes: softCapMinutes,
                totalCapMinutes: totalCapMinutes,
                maxPoints: maxPoints,
                firstRatio: firstRatio,
                status: status,
                createdAt: createdAt,
                startedAt: startedAt,
                completedAt: completedAt,
                softCapAcknowledged: softCapAcknowledged,
                totalCapAcknowledged: totalCapAcknowledged,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GameEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                eventId = false,
                teamId = false,
                gameRosterEntriesRefs = false,
                pointEntriesRefs = false,
                recordedActionEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (gameRosterEntriesRefs) db.gameRosterEntries,
                    if (pointEntriesRefs) db.pointEntries,
                    if (recordedActionEntriesRefs) db.recordedActionEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (eventId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.eventId,
                            referencedTable: $$GameEntriesTableReferences
                                ._eventIdTable(db),
                            referencedColumn: $$GameEntriesTableReferences
                                ._eventIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (teamId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.teamId,
                            referencedTable: $$GameEntriesTableReferences
                                ._teamIdTable(db),
                            referencedColumn: $$GameEntriesTableReferences
                                ._teamIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (gameRosterEntriesRefs)
                        await $_getPrefetchedData<
                          GameRecord,
                          $GameEntriesTable,
                          GameRosterRecord
                        >(
                          currentTable: table,
                          referencedTable: $$GameEntriesTableReferences
                              ._gameRosterEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).gameRosterEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (pointEntriesRefs)
                        await $_getPrefetchedData<
                          GameRecord,
                          $GameEntriesTable,
                          PointRecordRow
                        >(
                          currentTable: table,
                          referencedTable: $$GameEntriesTableReferences
                              ._pointEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).pointEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recordedActionEntriesRefs)
                        await $_getPrefetchedData<
                          GameRecord,
                          $GameEntriesTable,
                          RecordedActionRecord
                        >(
                          currentTable: table,
                          referencedTable: $$GameEntriesTableReferences
                              ._recordedActionEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).recordedActionEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GameEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameEntriesTable,
      GameRecord,
      $$GameEntriesTableFilterComposer,
      $$GameEntriesTableOrderingComposer,
      $$GameEntriesTableAnnotationComposer,
      $$GameEntriesTableCreateCompanionBuilder,
      $$GameEntriesTableUpdateCompanionBuilder,
      (GameRecord, $$GameEntriesTableReferences),
      GameRecord,
      PrefetchHooks Function({
        bool eventId,
        bool teamId,
        bool gameRosterEntriesRefs,
        bool pointEntriesRefs,
        bool recordedActionEntriesRefs,
      })
    >;
typedef $$GameRosterEntriesTableCreateCompanionBuilder =
    GameRosterEntriesCompanion Function({
      required String id,
      required String gameId,
      required String playerId,
      required String name,
      required String gender,
      Value<String?> number,
      required String position,
      required bool archivedAtStart,
      Value<int> rowid,
    });
typedef $$GameRosterEntriesTableUpdateCompanionBuilder =
    GameRosterEntriesCompanion Function({
      Value<String> id,
      Value<String> gameId,
      Value<String> playerId,
      Value<String> name,
      Value<String> gender,
      Value<String?> number,
      Value<String> position,
      Value<bool> archivedAtStart,
      Value<int> rowid,
    });

final class $$GameRosterEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GameRosterEntriesTable,
          GameRosterRecord
        > {
  $$GameRosterEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GameEntriesTable _gameIdTable(_$AppDatabase db) => db.gameEntries
      .createAlias('game_roster_entries__game_id__game_entries__id');

  $$GameEntriesTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager = $$GameEntriesTableTableManager(
      $_db,
      $_db.gameEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PointParticipantEntriesTable,
    List<PointParticipantRecord>
  >
  _pointParticipantEntriesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pointParticipantEntries,
    aliasName:
        'game_roster_entries__id__point_participant_entries__game_roster_id',
  );

  $$PointParticipantEntriesTableProcessedTableManager
  get pointParticipantEntriesRefs {
    final manager = $$PointParticipantEntriesTableTableManager(
      $_db,
      $_db.pointParticipantEntries,
    ).filter((f) => f.gameRosterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pointParticipantEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GameRosterEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $GameRosterEntriesTable> {
  $$GameRosterEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archivedAtStart => $composableBuilder(
    column: $table.archivedAtStart,
    builder: (column) => ColumnFilters(column),
  );

  $$GameEntriesTableFilterComposer get gameId {
    final $$GameEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pointParticipantEntriesRefs(
    Expression<bool> Function($$PointParticipantEntriesTableFilterComposer f) f,
  ) {
    final $$PointParticipantEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.gameRosterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableFilterComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GameRosterEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GameRosterEntriesTable> {
  $$GameRosterEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archivedAtStart => $composableBuilder(
    column: $table.archivedAtStart,
    builder: (column) => ColumnOrderings(column),
  );

  $$GameEntriesTableOrderingComposer get gameId {
    final $$GameEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GameRosterEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GameRosterEntriesTable> {
  $$GameRosterEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<bool> get archivedAtStart => $composableBuilder(
    column: $table.archivedAtStart,
    builder: (column) => column,
  );

  $$GameEntriesTableAnnotationComposer get gameId {
    final $$GameEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pointParticipantEntriesRefs<T extends Object>(
    Expression<T> Function($$PointParticipantEntriesTableAnnotationComposer a)
    f,
  ) {
    final $$PointParticipantEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.gameRosterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GameRosterEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GameRosterEntriesTable,
          GameRosterRecord,
          $$GameRosterEntriesTableFilterComposer,
          $$GameRosterEntriesTableOrderingComposer,
          $$GameRosterEntriesTableAnnotationComposer,
          $$GameRosterEntriesTableCreateCompanionBuilder,
          $$GameRosterEntriesTableUpdateCompanionBuilder,
          (GameRosterRecord, $$GameRosterEntriesTableReferences),
          GameRosterRecord,
          PrefetchHooks Function({
            bool gameId,
            bool pointParticipantEntriesRefs,
          })
        > {
  $$GameRosterEntriesTableTableManager(
    _$AppDatabase db,
    $GameRosterEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GameRosterEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GameRosterEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GameRosterEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<bool> archivedAtStart = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GameRosterEntriesCompanion(
                id: id,
                gameId: gameId,
                playerId: playerId,
                name: name,
                gender: gender,
                number: number,
                position: position,
                archivedAtStart: archivedAtStart,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gameId,
                required String playerId,
                required String name,
                required String gender,
                Value<String?> number = const Value.absent(),
                required String position,
                required bool archivedAtStart,
                Value<int> rowid = const Value.absent(),
              }) => GameRosterEntriesCompanion.insert(
                id: id,
                gameId: gameId,
                playerId: playerId,
                name: name,
                gender: gender,
                number: number,
                position: position,
                archivedAtStart: archivedAtStart,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GameRosterEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({gameId = false, pointParticipantEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pointParticipantEntriesRefs) db.pointParticipantEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (gameId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameId,
                            referencedTable: $$GameRosterEntriesTableReferences
                                ._gameIdTable(db),
                            referencedColumn: $$GameRosterEntriesTableReferences
                                ._gameIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pointParticipantEntriesRefs)
                        await $_getPrefetchedData<
                          GameRosterRecord,
                          $GameRosterEntriesTable,
                          PointParticipantRecord
                        >(
                          currentTable: table,
                          referencedTable: $$GameRosterEntriesTableReferences
                              ._pointParticipantEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GameRosterEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).pointParticipantEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.gameRosterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$GameRosterEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GameRosterEntriesTable,
      GameRosterRecord,
      $$GameRosterEntriesTableFilterComposer,
      $$GameRosterEntriesTableOrderingComposer,
      $$GameRosterEntriesTableAnnotationComposer,
      $$GameRosterEntriesTableCreateCompanionBuilder,
      $$GameRosterEntriesTableUpdateCompanionBuilder,
      (GameRosterRecord, $$GameRosterEntriesTableReferences),
      GameRosterRecord,
      PrefetchHooks Function({bool gameId, bool pointParticipantEntriesRefs})
    >;
typedef $$PointEntriesTableCreateCompanionBuilder =
    PointEntriesCompanion Function({
      required String id,
      required String gameId,
      required int pointNumber,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$PointEntriesTableUpdateCompanionBuilder =
    PointEntriesCompanion Function({
      Value<String> id,
      Value<String> gameId,
      Value<int> pointNumber,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PointEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $PointEntriesTable, PointRecordRow> {
  $$PointEntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GameEntriesTable _gameIdTable(_$AppDatabase db) =>
      db.gameEntries.createAlias('point_entries__game_id__game_entries__id');

  $$GameEntriesTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager = $$GameEntriesTableTableManager(
      $_db,
      $_db.gameEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $PointParticipantEntriesTable,
    List<PointParticipantRecord>
  >
  _pointParticipantEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pointParticipantEntries,
        aliasName: 'point_entries__id__point_participant_entries__point_id',
      );

  $$PointParticipantEntriesTableProcessedTableManager
  get pointParticipantEntriesRefs {
    final manager = $$PointParticipantEntriesTableTableManager(
      $_db,
      $_db.pointParticipantEntries,
    ).filter((f) => f.pointId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pointParticipantEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecordedActionEntriesTable,
    List<RecordedActionRecord>
  >
  _recordedActionEntriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recordedActionEntries,
        aliasName: 'point_entries__id__recorded_action_entries__point_id',
      );

  $$RecordedActionEntriesTableProcessedTableManager
  get recordedActionEntriesRefs {
    final manager = $$RecordedActionEntriesTableTableManager(
      $_db,
      $_db.recordedActionEntries,
    ).filter((f) => f.pointId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recordedActionEntriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PointEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PointEntriesTable> {
  $$PointEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pointNumber => $composableBuilder(
    column: $table.pointNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GameEntriesTableFilterComposer get gameId {
    final $$GameEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pointParticipantEntriesRefs(
    Expression<bool> Function($$PointParticipantEntriesTableFilterComposer f) f,
  ) {
    final $$PointParticipantEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.pointId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableFilterComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> recordedActionEntriesRefs(
    Expression<bool> Function($$RecordedActionEntriesTableFilterComposer f) f,
  ) {
    final $$RecordedActionEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.pointId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableFilterComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PointEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PointEntriesTable> {
  $$PointEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pointNumber => $composableBuilder(
    column: $table.pointNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GameEntriesTableOrderingComposer get gameId {
    final $$GameEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PointEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PointEntriesTable> {
  $$PointEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get pointNumber => $composableBuilder(
    column: $table.pointNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GameEntriesTableAnnotationComposer get gameId {
    final $$GameEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pointParticipantEntriesRefs<T extends Object>(
    Expression<T> Function($$PointParticipantEntriesTableAnnotationComposer a)
    f,
  ) {
    final $$PointParticipantEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.pointId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> recordedActionEntriesRefs<T extends Object>(
    Expression<T> Function($$RecordedActionEntriesTableAnnotationComposer a) f,
  ) {
    final $$RecordedActionEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.pointId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PointEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PointEntriesTable,
          PointRecordRow,
          $$PointEntriesTableFilterComposer,
          $$PointEntriesTableOrderingComposer,
          $$PointEntriesTableAnnotationComposer,
          $$PointEntriesTableCreateCompanionBuilder,
          $$PointEntriesTableUpdateCompanionBuilder,
          (PointRecordRow, $$PointEntriesTableReferences),
          PointRecordRow,
          PrefetchHooks Function({
            bool gameId,
            bool pointParticipantEntriesRefs,
            bool recordedActionEntriesRefs,
          })
        > {
  $$PointEntriesTableTableManager(_$AppDatabase db, $PointEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PointEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PointEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PointEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<int> pointNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PointEntriesCompanion(
                id: id,
                gameId: gameId,
                pointNumber: pointNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gameId,
                required int pointNumber,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PointEntriesCompanion.insert(
                id: id,
                gameId: gameId,
                pointNumber: pointNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PointEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gameId = false,
                pointParticipantEntriesRefs = false,
                recordedActionEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pointParticipantEntriesRefs) db.pointParticipantEntries,
                    if (recordedActionEntriesRefs) db.recordedActionEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (gameId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameId,
                            referencedTable: $$PointEntriesTableReferences
                                ._gameIdTable(db),
                            referencedColumn: $$PointEntriesTableReferences
                                ._gameIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pointParticipantEntriesRefs)
                        await $_getPrefetchedData<
                          PointRecordRow,
                          $PointEntriesTable,
                          PointParticipantRecord
                        >(
                          currentTable: table,
                          referencedTable: $$PointEntriesTableReferences
                              ._pointParticipantEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PointEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).pointParticipantEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pointId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (recordedActionEntriesRefs)
                        await $_getPrefetchedData<
                          PointRecordRow,
                          $PointEntriesTable,
                          RecordedActionRecord
                        >(
                          currentTable: table,
                          referencedTable: $$PointEntriesTableReferences
                              ._recordedActionEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PointEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).recordedActionEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pointId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PointEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PointEntriesTable,
      PointRecordRow,
      $$PointEntriesTableFilterComposer,
      $$PointEntriesTableOrderingComposer,
      $$PointEntriesTableAnnotationComposer,
      $$PointEntriesTableCreateCompanionBuilder,
      $$PointEntriesTableUpdateCompanionBuilder,
      (PointRecordRow, $$PointEntriesTableReferences),
      PointRecordRow,
      PrefetchHooks Function({
        bool gameId,
        bool pointParticipantEntriesRefs,
        bool recordedActionEntriesRefs,
      })
    >;
typedef $$PointParticipantEntriesTableCreateCompanionBuilder =
    PointParticipantEntriesCompanion Function({
      required String id,
      required String pointId,
      Value<String?> gameRosterId,
      required int displayOrder,
      Value<bool> unknown,
      Value<int> rowid,
    });
typedef $$PointParticipantEntriesTableUpdateCompanionBuilder =
    PointParticipantEntriesCompanion Function({
      Value<String> id,
      Value<String> pointId,
      Value<String?> gameRosterId,
      Value<int> displayOrder,
      Value<bool> unknown,
      Value<int> rowid,
    });

final class $$PointParticipantEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PointParticipantEntriesTable,
          PointParticipantRecord
        > {
  $$PointParticipantEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PointEntriesTable _pointIdTable(_$AppDatabase db) => db.pointEntries
      .createAlias('point_participant_entries__point_id__point_entries__id');

  $$PointEntriesTableProcessedTableManager get pointId {
    final $_column = $_itemColumn<String>('point_id')!;

    final manager = $$PointEntriesTableTableManager(
      $_db,
      $_db.pointEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pointIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GameRosterEntriesTable _gameRosterIdTable(_$AppDatabase db) =>
      db.gameRosterEntries.createAlias(
        'point_participant_entries__game_roster_id__game_roster_entries__id',
      );

  $$GameRosterEntriesTableProcessedTableManager? get gameRosterId {
    final $_column = $_itemColumn<String>('game_roster_id');
    if ($_column == null) return null;
    final manager = $$GameRosterEntriesTableTableManager(
      $_db,
      $_db.gameRosterEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameRosterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $RecordedActionEntriesTable,
    List<RecordedActionRecord>
  >
  _actorActionsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recordedActionEntries,
    aliasName: 'point_participant_entries__id__recorded_action_entries__actor_participant_id',
  );

  $$RecordedActionEntriesTableProcessedTableManager get actorActions {
    final manager =
        $$RecordedActionEntriesTableTableManager(
          $_db,
          $_db.recordedActionEntries,
        ).filter(
          (f) => f.actorParticipantId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_actorActionsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RecordedActionEntriesTable,
    List<RecordedActionRecord>
  >
  _targetActionsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.recordedActionEntries,
    aliasName: 'point_participant_entries__id__recorded_action_entries__target_participant_id',
  );

  $$RecordedActionEntriesTableProcessedTableManager get targetActions {
    final manager =
        $$RecordedActionEntriesTableTableManager(
          $_db,
          $_db.recordedActionEntries,
        ).filter(
          (f) =>
              f.targetParticipantId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_targetActionsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PointParticipantEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PointParticipantEntriesTable> {
  $$PointParticipantEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get unknown => $composableBuilder(
    column: $table.unknown,
    builder: (column) => ColumnFilters(column),
  );

  $$PointEntriesTableFilterComposer get pointId {
    final $$PointEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableFilterComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameRosterEntriesTableFilterComposer get gameRosterId {
    final $$GameRosterEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameRosterId,
      referencedTable: $db.gameRosterEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameRosterEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gameRosterEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> actorActions(
    Expression<bool> Function($$RecordedActionEntriesTableFilterComposer f) f,
  ) {
    final $$RecordedActionEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.actorParticipantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableFilterComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> targetActions(
    Expression<bool> Function($$RecordedActionEntriesTableFilterComposer f) f,
  ) {
    final $$RecordedActionEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.targetParticipantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableFilterComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PointParticipantEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PointParticipantEntriesTable> {
  $$PointParticipantEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get unknown => $composableBuilder(
    column: $table.unknown,
    builder: (column) => ColumnOrderings(column),
  );

  $$PointEntriesTableOrderingComposer get pointId {
    final $$PointEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameRosterEntriesTableOrderingComposer get gameRosterId {
    final $$GameRosterEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameRosterId,
      referencedTable: $db.gameRosterEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameRosterEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.gameRosterEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PointParticipantEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PointParticipantEntriesTable> {
  $$PointParticipantEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get unknown =>
      $composableBuilder(column: $table.unknown, builder: (column) => column);

  $$PointEntriesTableAnnotationComposer get pointId {
    final $$PointEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GameRosterEntriesTableAnnotationComposer get gameRosterId {
    final $$GameRosterEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.gameRosterId,
          referencedTable: $db.gameRosterEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GameRosterEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.gameRosterEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> actorActions<T extends Object>(
    Expression<T> Function($$RecordedActionEntriesTableAnnotationComposer a) f,
  ) {
    final $$RecordedActionEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.actorParticipantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> targetActions<T extends Object>(
    Expression<T> Function($$RecordedActionEntriesTableAnnotationComposer a) f,
  ) {
    final $$RecordedActionEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recordedActionEntries,
          getReferencedColumn: (t) => t.targetParticipantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecordedActionEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.recordedActionEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PointParticipantEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PointParticipantEntriesTable,
          PointParticipantRecord,
          $$PointParticipantEntriesTableFilterComposer,
          $$PointParticipantEntriesTableOrderingComposer,
          $$PointParticipantEntriesTableAnnotationComposer,
          $$PointParticipantEntriesTableCreateCompanionBuilder,
          $$PointParticipantEntriesTableUpdateCompanionBuilder,
          (PointParticipantRecord, $$PointParticipantEntriesTableReferences),
          PointParticipantRecord,
          PrefetchHooks Function({
            bool pointId,
            bool gameRosterId,
            bool actorActions,
            bool targetActions,
          })
        > {
  $$PointParticipantEntriesTableTableManager(
    _$AppDatabase db,
    $PointParticipantEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PointParticipantEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PointParticipantEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PointParticipantEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pointId = const Value.absent(),
                Value<String?> gameRosterId = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<bool> unknown = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PointParticipantEntriesCompanion(
                id: id,
                pointId: pointId,
                gameRosterId: gameRosterId,
                displayOrder: displayOrder,
                unknown: unknown,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pointId,
                Value<String?> gameRosterId = const Value.absent(),
                required int displayOrder,
                Value<bool> unknown = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PointParticipantEntriesCompanion.insert(
                id: id,
                pointId: pointId,
                gameRosterId: gameRosterId,
                displayOrder: displayOrder,
                unknown: unknown,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PointParticipantEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pointId = false,
                gameRosterId = false,
                actorActions = false,
                targetActions = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (actorActions) db.recordedActionEntries,
                    if (targetActions) db.recordedActionEntries,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (pointId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.pointId,
                            referencedTable:
                                $$PointParticipantEntriesTableReferences
                                    ._pointIdTable(db),
                            referencedColumn:
                                $$PointParticipantEntriesTableReferences
                                    ._pointIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (gameRosterId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameRosterId,
                            referencedTable:
                                $$PointParticipantEntriesTableReferences
                                    ._gameRosterIdTable(db),
                            referencedColumn:
                                $$PointParticipantEntriesTableReferences
                                    ._gameRosterIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (actorActions)
                        await $_getPrefetchedData<
                          PointParticipantRecord,
                          $PointParticipantEntriesTable,
                          RecordedActionRecord
                        >(
                          currentTable: table,
                          referencedTable:
                              $$PointParticipantEntriesTableReferences
                                  ._actorActionsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PointParticipantEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).actorActions,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.actorParticipantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (targetActions)
                        await $_getPrefetchedData<
                          PointParticipantRecord,
                          $PointParticipantEntriesTable,
                          RecordedActionRecord
                        >(
                          currentTable: table,
                          referencedTable:
                              $$PointParticipantEntriesTableReferences
                                  ._targetActionsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PointParticipantEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).targetActions,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.targetParticipantId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PointParticipantEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PointParticipantEntriesTable,
      PointParticipantRecord,
      $$PointParticipantEntriesTableFilterComposer,
      $$PointParticipantEntriesTableOrderingComposer,
      $$PointParticipantEntriesTableAnnotationComposer,
      $$PointParticipantEntriesTableCreateCompanionBuilder,
      $$PointParticipantEntriesTableUpdateCompanionBuilder,
      (PointParticipantRecord, $$PointParticipantEntriesTableReferences),
      PointParticipantRecord,
      PrefetchHooks Function({
        bool pointId,
        bool gameRosterId,
        bool actorActions,
        bool targetActions,
      })
    >;
typedef $$RecordedActionEntriesTableCreateCompanionBuilder =
    RecordedActionEntriesCompanion Function({
      required String id,
      required String gameId,
      Value<String?> pointId,
      required int sequence,
      required String kind,
      Value<String?> actorParticipantId,
      Value<String?> targetParticipantId,
      Value<String?> relatedActionId,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$RecordedActionEntriesTableUpdateCompanionBuilder =
    RecordedActionEntriesCompanion Function({
      Value<String> id,
      Value<String> gameId,
      Value<String?> pointId,
      Value<int> sequence,
      Value<String> kind,
      Value<String?> actorParticipantId,
      Value<String?> targetParticipantId,
      Value<String?> relatedActionId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$RecordedActionEntriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecordedActionEntriesTable,
          RecordedActionRecord
        > {
  $$RecordedActionEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GameEntriesTable _gameIdTable(_$AppDatabase db) => db.gameEntries
      .createAlias('recorded_action_entries__game_id__game_entries__id');

  $$GameEntriesTableProcessedTableManager get gameId {
    final $_column = $_itemColumn<String>('game_id')!;

    final manager = $$GameEntriesTableTableManager(
      $_db,
      $_db.gameEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_gameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PointEntriesTable _pointIdTable(_$AppDatabase db) => db.pointEntries
      .createAlias('recorded_action_entries__point_id__point_entries__id');

  $$PointEntriesTableProcessedTableManager? get pointId {
    final $_column = $_itemColumn<String>('point_id');
    if ($_column == null) return null;
    final manager = $$PointEntriesTableTableManager(
      $_db,
      $_db.pointEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pointIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PointParticipantEntriesTable _actorParticipantIdTable(
    _$AppDatabase db,
  ) => db.pointParticipantEntries.createAlias(
    'recorded_action_entries__actor_participant_id__point_participant_entries__id',
  );

  $$PointParticipantEntriesTableProcessedTableManager? get actorParticipantId {
    final $_column = $_itemColumn<String>('actor_participant_id');
    if ($_column == null) return null;
    final manager = $$PointParticipantEntriesTableTableManager(
      $_db,
      $_db.pointParticipantEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_actorParticipantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PointParticipantEntriesTable _targetParticipantIdTable(
    _$AppDatabase db,
  ) => db.pointParticipantEntries.createAlias(
    'recorded_action_entries__target_participant_id__point_participant_entries__id',
  );

  $$PointParticipantEntriesTableProcessedTableManager? get targetParticipantId {
    final $_column = $_itemColumn<String>('target_participant_id');
    if ($_column == null) return null;
    final manager = $$PointParticipantEntriesTableTableManager(
      $_db,
      $_db.pointParticipantEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetParticipantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecordedActionEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $RecordedActionEntriesTable> {
  $$RecordedActionEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get relatedActionId => $composableBuilder(
    column: $table.relatedActionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GameEntriesTableFilterComposer get gameId {
    final $$GameEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableFilterComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointEntriesTableFilterComposer get pointId {
    final $$PointEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableFilterComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointParticipantEntriesTableFilterComposer get actorParticipantId {
    final $$PointParticipantEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.actorParticipantId,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableFilterComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PointParticipantEntriesTableFilterComposer get targetParticipantId {
    final $$PointParticipantEntriesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.targetParticipantId,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableFilterComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RecordedActionEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecordedActionEntriesTable> {
  $$RecordedActionEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequence => $composableBuilder(
    column: $table.sequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get relatedActionId => $composableBuilder(
    column: $table.relatedActionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GameEntriesTableOrderingComposer get gameId {
    final $$GameEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointEntriesTableOrderingComposer get pointId {
    final $$PointEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointParticipantEntriesTableOrderingComposer get actorParticipantId {
    final $$PointParticipantEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.actorParticipantId,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PointParticipantEntriesTableOrderingComposer get targetParticipantId {
    final $$PointParticipantEntriesTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.targetParticipantId,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableOrderingComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RecordedActionEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecordedActionEntriesTable> {
  $$RecordedActionEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sequence =>
      $composableBuilder(column: $table.sequence, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get relatedActionId => $composableBuilder(
    column: $table.relatedActionId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GameEntriesTableAnnotationComposer get gameId {
    final $$GameEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.gameId,
      referencedTable: $db.gameEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GameEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.gameEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointEntriesTableAnnotationComposer get pointId {
    final $$PointEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pointId,
      referencedTable: $db.pointEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PointEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.pointEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PointParticipantEntriesTableAnnotationComposer get actorParticipantId {
    final $$PointParticipantEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.actorParticipantId,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PointParticipantEntriesTableAnnotationComposer get targetParticipantId {
    final $$PointParticipantEntriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.targetParticipantId,
          referencedTable: $db.pointParticipantEntries,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$PointParticipantEntriesTableAnnotationComposer(
                $db: $db,
                $table: $db.pointParticipantEntries,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$RecordedActionEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecordedActionEntriesTable,
          RecordedActionRecord,
          $$RecordedActionEntriesTableFilterComposer,
          $$RecordedActionEntriesTableOrderingComposer,
          $$RecordedActionEntriesTableAnnotationComposer,
          $$RecordedActionEntriesTableCreateCompanionBuilder,
          $$RecordedActionEntriesTableUpdateCompanionBuilder,
          (RecordedActionRecord, $$RecordedActionEntriesTableReferences),
          RecordedActionRecord,
          PrefetchHooks Function({
            bool gameId,
            bool pointId,
            bool actorParticipantId,
            bool targetParticipantId,
          })
        > {
  $$RecordedActionEntriesTableTableManager(
    _$AppDatabase db,
    $RecordedActionEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecordedActionEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RecordedActionEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecordedActionEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> gameId = const Value.absent(),
                Value<String?> pointId = const Value.absent(),
                Value<int> sequence = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<String?> actorParticipantId = const Value.absent(),
                Value<String?> targetParticipantId = const Value.absent(),
                Value<String?> relatedActionId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecordedActionEntriesCompanion(
                id: id,
                gameId: gameId,
                pointId: pointId,
                sequence: sequence,
                kind: kind,
                actorParticipantId: actorParticipantId,
                targetParticipantId: targetParticipantId,
                relatedActionId: relatedActionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String gameId,
                Value<String?> pointId = const Value.absent(),
                required int sequence,
                required String kind,
                Value<String?> actorParticipantId = const Value.absent(),
                Value<String?> targetParticipantId = const Value.absent(),
                Value<String?> relatedActionId = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RecordedActionEntriesCompanion.insert(
                id: id,
                gameId: gameId,
                pointId: pointId,
                sequence: sequence,
                kind: kind,
                actorParticipantId: actorParticipantId,
                targetParticipantId: targetParticipantId,
                relatedActionId: relatedActionId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecordedActionEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                gameId = false,
                pointId = false,
                actorParticipantId = false,
                targetParticipantId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (gameId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.gameId,
                            referencedTable:
                                $$RecordedActionEntriesTableReferences
                                    ._gameIdTable(db),
                            referencedColumn:
                                $$RecordedActionEntriesTableReferences
                                    ._gameIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (pointId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.pointId,
                            referencedTable:
                                $$RecordedActionEntriesTableReferences
                                    ._pointIdTable(db),
                            referencedColumn:
                                $$RecordedActionEntriesTableReferences
                                    ._pointIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (actorParticipantId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.actorParticipantId,
                            referencedTable:
                                $$RecordedActionEntriesTableReferences
                                    ._actorParticipantIdTable(db),
                            referencedColumn:
                                $$RecordedActionEntriesTableReferences
                                    ._actorParticipantIdTable(db)
                                    .id,
                          ) as T;
                        }
                        if (targetParticipantId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.targetParticipantId,
                            referencedTable:
                                $$RecordedActionEntriesTableReferences
                                    ._targetParticipantIdTable(db),
                            referencedColumn:
                                $$RecordedActionEntriesTableReferences
                                    ._targetParticipantIdTable(db)
                                    .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$RecordedActionEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecordedActionEntriesTable,
      RecordedActionRecord,
      $$RecordedActionEntriesTableFilterComposer,
      $$RecordedActionEntriesTableOrderingComposer,
      $$RecordedActionEntriesTableAnnotationComposer,
      $$RecordedActionEntriesTableCreateCompanionBuilder,
      $$RecordedActionEntriesTableUpdateCompanionBuilder,
      (RecordedActionRecord, $$RecordedActionEntriesTableReferences),
      RecordedActionRecord,
      PrefetchHooks Function({
        bool gameId,
        bool pointId,
        bool actorParticipantId,
        bool targetParticipantId,
      })
    >;
typedef $$AppSettingEntriesTableCreateCompanionBuilder =
    AppSettingEntriesCompanion Function({
      required String key,
      Value<String?> value,
      Value<int> rowid,
    });
typedef $$AppSettingEntriesTableUpdateCompanionBuilder =
    AppSettingEntriesCompanion Function({
      Value<String> key,
      Value<String?> value,
      Value<int> rowid,
    });

class $$AppSettingEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingEntriesTable> {
  $$AppSettingEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingEntriesTable> {
  $$AppSettingEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingEntriesTable> {
  $$AppSettingEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingEntriesTable,
          AppSettingRecord,
          $$AppSettingEntriesTableFilterComposer,
          $$AppSettingEntriesTableOrderingComposer,
          $$AppSettingEntriesTableAnnotationComposer,
          $$AppSettingEntriesTableCreateCompanionBuilder,
          $$AppSettingEntriesTableUpdateCompanionBuilder,
          (
            AppSettingRecord,
            BaseReferences<
              _$AppDatabase,
              $AppSettingEntriesTable,
              AppSettingRecord
            >,
          ),
          AppSettingRecord,
          PrefetchHooks Function()
        > {
  $$AppSettingEntriesTableTableManager(
    _$AppDatabase db,
    $AppSettingEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingEntriesCompanion(
                key: key,
                value: value,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                Value<String?> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingEntriesCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingEntriesTable,
      AppSettingRecord,
      $$AppSettingEntriesTableFilterComposer,
      $$AppSettingEntriesTableOrderingComposer,
      $$AppSettingEntriesTableAnnotationComposer,
      $$AppSettingEntriesTableCreateCompanionBuilder,
      $$AppSettingEntriesTableUpdateCompanionBuilder,
      (
        AppSettingRecord,
        BaseReferences<
          _$AppDatabase,
          $AppSettingEntriesTable,
          AppSettingRecord
        >,
      ),
      AppSettingRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeamEntriesTableTableManager get teamEntries =>
      $$TeamEntriesTableTableManager(_db, _db.teamEntries);
  $$PlayerEntriesTableTableManager get playerEntries =>
      $$PlayerEntriesTableTableManager(_db, _db.playerEntries);
  $$CompetitionEventEntriesTableTableManager get competitionEventEntries =>
      $$CompetitionEventEntriesTableTableManager(
        _db,
        _db.competitionEventEntries,
      );
  $$EventRosterEntriesTableTableManager get eventRosterEntries =>
      $$EventRosterEntriesTableTableManager(_db, _db.eventRosterEntries);
  $$LinePresetEntriesTableTableManager get linePresetEntries =>
      $$LinePresetEntriesTableTableManager(_db, _db.linePresetEntries);
  $$LinePresetMemberEntriesTableTableManager get linePresetMemberEntries =>
      $$LinePresetMemberEntriesTableTableManager(
        _db,
        _db.linePresetMemberEntries,
      );
  $$GameEntriesTableTableManager get gameEntries =>
      $$GameEntriesTableTableManager(_db, _db.gameEntries);
  $$GameRosterEntriesTableTableManager get gameRosterEntries =>
      $$GameRosterEntriesTableTableManager(_db, _db.gameRosterEntries);
  $$PointEntriesTableTableManager get pointEntries =>
      $$PointEntriesTableTableManager(_db, _db.pointEntries);
  $$PointParticipantEntriesTableTableManager get pointParticipantEntries =>
      $$PointParticipantEntriesTableTableManager(
        _db,
        _db.pointParticipantEntries,
      );
  $$RecordedActionEntriesTableTableManager get recordedActionEntries =>
      $$RecordedActionEntriesTableTableManager(_db, _db.recordedActionEntries);
  $$AppSettingEntriesTableTableManager get appSettingEntries =>
      $$AppSettingEntriesTableTableManager(_db, _db.appSettingEntries);
}
