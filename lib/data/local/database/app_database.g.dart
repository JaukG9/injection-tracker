// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles
    with TableInfo<$ProfilesTable, ProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
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
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexMeta = const VerificationMeta('sex');
  @override
  late final GeneratedColumn<String> sex = GeneratedColumn<String>(
    'sex',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unspecified'),
  );
  static const VerificationMeta _avatarPathMeta = const VerificationMeta(
    'avatarPath',
  );
  @override
  late final GeneratedColumn<String> avatarPath = GeneratedColumn<String>(
    'avatar_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitSystemMeta = const VerificationMeta(
    'unitSystem',
  );
  @override
  late final GeneratedColumn<String> unitSystem = GeneratedColumn<String>(
    'unit_system',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('imperial'),
  );
  static const VerificationMeta _colorSeedMeta = const VerificationMeta(
    'colorSeed',
  );
  @override
  late final GeneratedColumn<int> colorSeed = GeneratedColumn<int>(
    'color_seed',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _healthcareProviderMeta =
      const VerificationMeta('healthcareProvider');
  @override
  late final GeneratedColumn<String> healthcareProvider =
      GeneratedColumn<String>(
        'healthcare_provider',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
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
    dateOfBirth,
    sex,
    avatarPath,
    unitSystem,
    colorSeed,
    healthcareProvider,
    isArchived,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileRow> instance, {
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
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('sex')) {
      context.handle(
        _sexMeta,
        sex.isAcceptableOrUnknown(data['sex']!, _sexMeta),
      );
    }
    if (data.containsKey('avatar_path')) {
      context.handle(
        _avatarPathMeta,
        avatarPath.isAcceptableOrUnknown(data['avatar_path']!, _avatarPathMeta),
      );
    }
    if (data.containsKey('unit_system')) {
      context.handle(
        _unitSystemMeta,
        unitSystem.isAcceptableOrUnknown(data['unit_system']!, _unitSystemMeta),
      );
    }
    if (data.containsKey('color_seed')) {
      context.handle(
        _colorSeedMeta,
        colorSeed.isAcceptableOrUnknown(data['color_seed']!, _colorSeedMeta),
      );
    }
    if (data.containsKey('healthcare_provider')) {
      context.handle(
        _healthcareProviderMeta,
        healthcareProvider.isAcceptableOrUnknown(
          data['healthcare_provider']!,
          _healthcareProviderMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
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
  ProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      sex: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sex'],
      )!,
      avatarPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_path'],
      ),
      unitSystem: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_system'],
      )!,
      colorSeed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color_seed'],
      ),
      healthcareProvider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}healthcare_provider'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
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
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class ProfileRow extends DataClass implements Insertable<ProfileRow> {
  final String id;
  final String name;
  final DateTime? dateOfBirth;

  /// Stored as [Sex.name].
  final String sex;
  final String? avatarPath;

  /// Stored as [UnitSystem.name].
  final String unitSystem;

  /// Optional per-profile accent seed colour (ARGB int).
  final int? colorSeed;
  final String? healthcareProvider;
  final bool isArchived;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ProfileRow({
    required this.id,
    required this.name,
    this.dateOfBirth,
    required this.sex,
    this.avatarPath,
    required this.unitSystem,
    this.colorSeed,
    this.healthcareProvider,
    required this.isArchived,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    map['sex'] = Variable<String>(sex);
    if (!nullToAbsent || avatarPath != null) {
      map['avatar_path'] = Variable<String>(avatarPath);
    }
    map['unit_system'] = Variable<String>(unitSystem);
    if (!nullToAbsent || colorSeed != null) {
      map['color_seed'] = Variable<int>(colorSeed);
    }
    if (!nullToAbsent || healthcareProvider != null) {
      map['healthcare_provider'] = Variable<String>(healthcareProvider);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      name: Value(name),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      sex: Value(sex),
      avatarPath: avatarPath == null && nullToAbsent
          ? const Value.absent()
          : Value(avatarPath),
      unitSystem: Value(unitSystem),
      colorSeed: colorSeed == null && nullToAbsent
          ? const Value.absent()
          : Value(colorSeed),
      healthcareProvider: healthcareProvider == null && nullToAbsent
          ? const Value.absent()
          : Value(healthcareProvider),
      isArchived: Value(isArchived),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileRow(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      sex: serializer.fromJson<String>(json['sex']),
      avatarPath: serializer.fromJson<String?>(json['avatarPath']),
      unitSystem: serializer.fromJson<String>(json['unitSystem']),
      colorSeed: serializer.fromJson<int?>(json['colorSeed']),
      healthcareProvider: serializer.fromJson<String?>(
        json['healthcareProvider'],
      ),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
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
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'sex': serializer.toJson<String>(sex),
      'avatarPath': serializer.toJson<String?>(avatarPath),
      'unitSystem': serializer.toJson<String>(unitSystem),
      'colorSeed': serializer.toJson<int?>(colorSeed),
      'healthcareProvider': serializer.toJson<String?>(healthcareProvider),
      'isArchived': serializer.toJson<bool>(isArchived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ProfileRow copyWith({
    String? id,
    String? name,
    Value<DateTime?> dateOfBirth = const Value.absent(),
    String? sex,
    Value<String?> avatarPath = const Value.absent(),
    String? unitSystem,
    Value<int?> colorSeed = const Value.absent(),
    Value<String?> healthcareProvider = const Value.absent(),
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ProfileRow(
    id: id ?? this.id,
    name: name ?? this.name,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    sex: sex ?? this.sex,
    avatarPath: avatarPath.present ? avatarPath.value : this.avatarPath,
    unitSystem: unitSystem ?? this.unitSystem,
    colorSeed: colorSeed.present ? colorSeed.value : this.colorSeed,
    healthcareProvider: healthcareProvider.present
        ? healthcareProvider.value
        : this.healthcareProvider,
    isArchived: isArchived ?? this.isArchived,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ProfileRow copyWithCompanion(ProfilesCompanion data) {
    return ProfileRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      sex: data.sex.present ? data.sex.value : this.sex,
      avatarPath: data.avatarPath.present
          ? data.avatarPath.value
          : this.avatarPath,
      unitSystem: data.unitSystem.present
          ? data.unitSystem.value
          : this.unitSystem,
      colorSeed: data.colorSeed.present ? data.colorSeed.value : this.colorSeed,
      healthcareProvider: data.healthcareProvider.present
          ? data.healthcareProvider.value
          : this.healthcareProvider,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('sex: $sex, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('colorSeed: $colorSeed, ')
          ..write('healthcareProvider: $healthcareProvider, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    dateOfBirth,
    sex,
    avatarPath,
    unitSystem,
    colorSeed,
    healthcareProvider,
    isArchived,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.dateOfBirth == this.dateOfBirth &&
          other.sex == this.sex &&
          other.avatarPath == this.avatarPath &&
          other.unitSystem == this.unitSystem &&
          other.colorSeed == this.colorSeed &&
          other.healthcareProvider == this.healthcareProvider &&
          other.isArchived == this.isArchived &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ProfilesCompanion extends UpdateCompanion<ProfileRow> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime?> dateOfBirth;
  final Value<String> sex;
  final Value<String?> avatarPath;
  final Value<String> unitSystem;
  final Value<int?> colorSeed;
  final Value<String?> healthcareProvider;
  final Value<bool> isArchived;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.sex = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.colorSeed = const Value.absent(),
    this.healthcareProvider = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProfilesCompanion.insert({
    required String id,
    required String name,
    this.dateOfBirth = const Value.absent(),
    this.sex = const Value.absent(),
    this.avatarPath = const Value.absent(),
    this.unitSystem = const Value.absent(),
    this.colorSeed = const Value.absent(),
    this.healthcareProvider = const Value.absent(),
    this.isArchived = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProfileRow> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? sex,
    Expression<String>? avatarPath,
    Expression<String>? unitSystem,
    Expression<int>? colorSeed,
    Expression<String>? healthcareProvider,
    Expression<bool>? isArchived,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (sex != null) 'sex': sex,
      if (avatarPath != null) 'avatar_path': avatarPath,
      if (unitSystem != null) 'unit_system': unitSystem,
      if (colorSeed != null) 'color_seed': colorSeed,
      if (healthcareProvider != null) 'healthcare_provider': healthcareProvider,
      if (isArchived != null) 'is_archived': isArchived,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime?>? dateOfBirth,
    Value<String>? sex,
    Value<String?>? avatarPath,
    Value<String>? unitSystem,
    Value<int?>? colorSeed,
    Value<String?>? healthcareProvider,
    Value<bool>? isArchived,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      sex: sex ?? this.sex,
      avatarPath: avatarPath ?? this.avatarPath,
      unitSystem: unitSystem ?? this.unitSystem,
      colorSeed: colorSeed ?? this.colorSeed,
      healthcareProvider: healthcareProvider ?? this.healthcareProvider,
      isArchived: isArchived ?? this.isArchived,
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
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (sex.present) {
      map['sex'] = Variable<String>(sex.value);
    }
    if (avatarPath.present) {
      map['avatar_path'] = Variable<String>(avatarPath.value);
    }
    if (unitSystem.present) {
      map['unit_system'] = Variable<String>(unitSystem.value);
    }
    if (colorSeed.present) {
      map['color_seed'] = Variable<int>(colorSeed.value);
    }
    if (healthcareProvider.present) {
      map['healthcare_provider'] = Variable<String>(healthcareProvider.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
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
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('sex: $sex, ')
          ..write('avatarPath: $avatarPath, ')
          ..write('unitSystem: $unitSystem, ')
          ..write('colorSeed: $colorSeed, ')
          ..write('healthcareProvider: $healthcareProvider, ')
          ..write('isArchived: $isArchived, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTable extends Medications
    with TableInfo<$MedicationsTable, MedicationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _concentrationMeta = const VerificationMeta(
    'concentration',
  );
  @override
  late final GeneratedColumn<String> concentration = GeneratedColumn<String>(
    'concentration',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultDoseValueMeta = const VerificationMeta(
    'defaultDoseValue',
  );
  @override
  late final GeneratedColumn<double> defaultDoseValue = GeneratedColumn<double>(
    'default_dose_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultDoseUnitMeta = const VerificationMeta(
    'defaultDoseUnit',
  );
  @override
  late final GeneratedColumn<String> defaultDoseUnit = GeneratedColumn<String>(
    'default_dose_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mg'),
  );
  static const VerificationMeta _scheduleTypeMeta = const VerificationMeta(
    'scheduleType',
  );
  @override
  late final GeneratedColumn<String> scheduleType = GeneratedColumn<String>(
    'schedule_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('daily'),
  );
  static const VerificationMeta _scheduleConfigMeta = const VerificationMeta(
    'scheduleConfig',
  );
  @override
  late final GeneratedColumn<String> scheduleConfig = GeneratedColumn<String>(
    'schedule_config',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
    'reminder_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _routeMeta = const VerificationMeta('route');
  @override
  late final GeneratedColumn<String> route = GeneratedColumn<String>(
    'route',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('subcutaneous'),
  );
  static const VerificationMeta _presetIdMeta = const VerificationMeta(
    'presetId',
  );
  @override
  late final GeneratedColumn<String> presetId = GeneratedColumn<String>(
    'preset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    name,
    concentration,
    defaultDoseValue,
    defaultDoseUnit,
    scheduleType,
    scheduleConfig,
    reminderTime,
    startedAt,
    notes,
    isActive,
    route,
    presetId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('concentration')) {
      context.handle(
        _concentrationMeta,
        concentration.isAcceptableOrUnknown(
          data['concentration']!,
          _concentrationMeta,
        ),
      );
    }
    if (data.containsKey('default_dose_value')) {
      context.handle(
        _defaultDoseValueMeta,
        defaultDoseValue.isAcceptableOrUnknown(
          data['default_dose_value']!,
          _defaultDoseValueMeta,
        ),
      );
    }
    if (data.containsKey('default_dose_unit')) {
      context.handle(
        _defaultDoseUnitMeta,
        defaultDoseUnit.isAcceptableOrUnknown(
          data['default_dose_unit']!,
          _defaultDoseUnitMeta,
        ),
      );
    }
    if (data.containsKey('schedule_type')) {
      context.handle(
        _scheduleTypeMeta,
        scheduleType.isAcceptableOrUnknown(
          data['schedule_type']!,
          _scheduleTypeMeta,
        ),
      );
    }
    if (data.containsKey('schedule_config')) {
      context.handle(
        _scheduleConfigMeta,
        scheduleConfig.isAcceptableOrUnknown(
          data['schedule_config']!,
          _scheduleConfigMeta,
        ),
      );
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('route')) {
      context.handle(
        _routeMeta,
        route.isAcceptableOrUnknown(data['route']!, _routeMeta),
      );
    }
    if (data.containsKey('preset_id')) {
      context.handle(
        _presetIdMeta,
        presetId.isAcceptableOrUnknown(data['preset_id']!, _presetIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicationRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      concentration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concentration'],
      ),
      defaultDoseValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_dose_value'],
      ),
      defaultDoseUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_dose_unit'],
      )!,
      scheduleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_type'],
      )!,
      scheduleConfig: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schedule_config'],
      )!,
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_time'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      route: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route'],
      )!,
      presetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset_id'],
      ),
    );
  }

  @override
  $MedicationsTable createAlias(String alias) {
    return $MedicationsTable(attachedDatabase, alias);
  }
}

class MedicationRow extends DataClass implements Insertable<MedicationRow> {
  final String id;
  final String profileId;
  final String name;

  /// Free-text concentration, e.g. "5 mg/mL".
  final String? concentration;
  final double? defaultDoseValue;

  /// Stored as [DoseUnit.name].
  final String defaultDoseUnit;

  /// Stored as [ScheduleType.name].
  final String scheduleType;

  /// JSON blob describing the schedule (e.g. {"n":2} or {"weekdays":[1,3,5]}).
  final String scheduleConfig;

  /// Reminder time of day as "HH:mm", or null for no reminder.
  final String? reminderTime;
  final DateTime? startedAt;
  final String? notes;
  final bool isActive;

  /// Route of administration, stored as [InjectionRoute.name].
  final String route;

  /// The catalog preset this medication was created from, if any.
  final String? presetId;
  const MedicationRow({
    required this.id,
    required this.profileId,
    required this.name,
    this.concentration,
    this.defaultDoseValue,
    required this.defaultDoseUnit,
    required this.scheduleType,
    required this.scheduleConfig,
    this.reminderTime,
    this.startedAt,
    this.notes,
    required this.isActive,
    required this.route,
    this.presetId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || concentration != null) {
      map['concentration'] = Variable<String>(concentration);
    }
    if (!nullToAbsent || defaultDoseValue != null) {
      map['default_dose_value'] = Variable<double>(defaultDoseValue);
    }
    map['default_dose_unit'] = Variable<String>(defaultDoseUnit);
    map['schedule_type'] = Variable<String>(scheduleType);
    map['schedule_config'] = Variable<String>(scheduleConfig);
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(reminderTime);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['route'] = Variable<String>(route);
    if (!nullToAbsent || presetId != null) {
      map['preset_id'] = Variable<String>(presetId);
    }
    return map;
  }

  MedicationsCompanion toCompanion(bool nullToAbsent) {
    return MedicationsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      name: Value(name),
      concentration: concentration == null && nullToAbsent
          ? const Value.absent()
          : Value(concentration),
      defaultDoseValue: defaultDoseValue == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultDoseValue),
      defaultDoseUnit: Value(defaultDoseUnit),
      scheduleType: Value(scheduleType),
      scheduleConfig: Value(scheduleConfig),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isActive: Value(isActive),
      route: Value(route),
      presetId: presetId == null && nullToAbsent
          ? const Value.absent()
          : Value(presetId),
    );
  }

  factory MedicationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicationRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      name: serializer.fromJson<String>(json['name']),
      concentration: serializer.fromJson<String?>(json['concentration']),
      defaultDoseValue: serializer.fromJson<double?>(json['defaultDoseValue']),
      defaultDoseUnit: serializer.fromJson<String>(json['defaultDoseUnit']),
      scheduleType: serializer.fromJson<String>(json['scheduleType']),
      scheduleConfig: serializer.fromJson<String>(json['scheduleConfig']),
      reminderTime: serializer.fromJson<String?>(json['reminderTime']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      route: serializer.fromJson<String>(json['route']),
      presetId: serializer.fromJson<String?>(json['presetId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'name': serializer.toJson<String>(name),
      'concentration': serializer.toJson<String?>(concentration),
      'defaultDoseValue': serializer.toJson<double?>(defaultDoseValue),
      'defaultDoseUnit': serializer.toJson<String>(defaultDoseUnit),
      'scheduleType': serializer.toJson<String>(scheduleType),
      'scheduleConfig': serializer.toJson<String>(scheduleConfig),
      'reminderTime': serializer.toJson<String?>(reminderTime),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'notes': serializer.toJson<String?>(notes),
      'isActive': serializer.toJson<bool>(isActive),
      'route': serializer.toJson<String>(route),
      'presetId': serializer.toJson<String?>(presetId),
    };
  }

  MedicationRow copyWith({
    String? id,
    String? profileId,
    String? name,
    Value<String?> concentration = const Value.absent(),
    Value<double?> defaultDoseValue = const Value.absent(),
    String? defaultDoseUnit,
    String? scheduleType,
    String? scheduleConfig,
    Value<String?> reminderTime = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isActive,
    String? route,
    Value<String?> presetId = const Value.absent(),
  }) => MedicationRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    name: name ?? this.name,
    concentration: concentration.present
        ? concentration.value
        : this.concentration,
    defaultDoseValue: defaultDoseValue.present
        ? defaultDoseValue.value
        : this.defaultDoseValue,
    defaultDoseUnit: defaultDoseUnit ?? this.defaultDoseUnit,
    scheduleType: scheduleType ?? this.scheduleType,
    scheduleConfig: scheduleConfig ?? this.scheduleConfig,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    notes: notes.present ? notes.value : this.notes,
    isActive: isActive ?? this.isActive,
    route: route ?? this.route,
    presetId: presetId.present ? presetId.value : this.presetId,
  );
  MedicationRow copyWithCompanion(MedicationsCompanion data) {
    return MedicationRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      name: data.name.present ? data.name.value : this.name,
      concentration: data.concentration.present
          ? data.concentration.value
          : this.concentration,
      defaultDoseValue: data.defaultDoseValue.present
          ? data.defaultDoseValue.value
          : this.defaultDoseValue,
      defaultDoseUnit: data.defaultDoseUnit.present
          ? data.defaultDoseUnit.value
          : this.defaultDoseUnit,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      scheduleConfig: data.scheduleConfig.present
          ? data.scheduleConfig.value
          : this.scheduleConfig,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      route: data.route.present ? data.route.value : this.route,
      presetId: data.presetId.present ? data.presetId.value : this.presetId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicationRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('concentration: $concentration, ')
          ..write('defaultDoseValue: $defaultDoseValue, ')
          ..write('defaultDoseUnit: $defaultDoseUnit, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('scheduleConfig: $scheduleConfig, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('startedAt: $startedAt, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('route: $route, ')
          ..write('presetId: $presetId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    name,
    concentration,
    defaultDoseValue,
    defaultDoseUnit,
    scheduleType,
    scheduleConfig,
    reminderTime,
    startedAt,
    notes,
    isActive,
    route,
    presetId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicationRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.name == this.name &&
          other.concentration == this.concentration &&
          other.defaultDoseValue == this.defaultDoseValue &&
          other.defaultDoseUnit == this.defaultDoseUnit &&
          other.scheduleType == this.scheduleType &&
          other.scheduleConfig == this.scheduleConfig &&
          other.reminderTime == this.reminderTime &&
          other.startedAt == this.startedAt &&
          other.notes == this.notes &&
          other.isActive == this.isActive &&
          other.route == this.route &&
          other.presetId == this.presetId);
}

class MedicationsCompanion extends UpdateCompanion<MedicationRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> name;
  final Value<String?> concentration;
  final Value<double?> defaultDoseValue;
  final Value<String> defaultDoseUnit;
  final Value<String> scheduleType;
  final Value<String> scheduleConfig;
  final Value<String?> reminderTime;
  final Value<DateTime?> startedAt;
  final Value<String?> notes;
  final Value<bool> isActive;
  final Value<String> route;
  final Value<String?> presetId;
  final Value<int> rowid;
  const MedicationsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.name = const Value.absent(),
    this.concentration = const Value.absent(),
    this.defaultDoseValue = const Value.absent(),
    this.defaultDoseUnit = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.scheduleConfig = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.route = const Value.absent(),
    this.presetId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MedicationsCompanion.insert({
    required String id,
    required String profileId,
    required String name,
    this.concentration = const Value.absent(),
    this.defaultDoseValue = const Value.absent(),
    this.defaultDoseUnit = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.scheduleConfig = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.route = const Value.absent(),
    this.presetId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       name = Value(name);
  static Insertable<MedicationRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? name,
    Expression<String>? concentration,
    Expression<double>? defaultDoseValue,
    Expression<String>? defaultDoseUnit,
    Expression<String>? scheduleType,
    Expression<String>? scheduleConfig,
    Expression<String>? reminderTime,
    Expression<DateTime>? startedAt,
    Expression<String>? notes,
    Expression<bool>? isActive,
    Expression<String>? route,
    Expression<String>? presetId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (name != null) 'name': name,
      if (concentration != null) 'concentration': concentration,
      if (defaultDoseValue != null) 'default_dose_value': defaultDoseValue,
      if (defaultDoseUnit != null) 'default_dose_unit': defaultDoseUnit,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (scheduleConfig != null) 'schedule_config': scheduleConfig,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (startedAt != null) 'started_at': startedAt,
      if (notes != null) 'notes': notes,
      if (isActive != null) 'is_active': isActive,
      if (route != null) 'route': route,
      if (presetId != null) 'preset_id': presetId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MedicationsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? name,
    Value<String?>? concentration,
    Value<double?>? defaultDoseValue,
    Value<String>? defaultDoseUnit,
    Value<String>? scheduleType,
    Value<String>? scheduleConfig,
    Value<String?>? reminderTime,
    Value<DateTime?>? startedAt,
    Value<String?>? notes,
    Value<bool>? isActive,
    Value<String>? route,
    Value<String?>? presetId,
    Value<int>? rowid,
  }) {
    return MedicationsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      name: name ?? this.name,
      concentration: concentration ?? this.concentration,
      defaultDoseValue: defaultDoseValue ?? this.defaultDoseValue,
      defaultDoseUnit: defaultDoseUnit ?? this.defaultDoseUnit,
      scheduleType: scheduleType ?? this.scheduleType,
      scheduleConfig: scheduleConfig ?? this.scheduleConfig,
      reminderTime: reminderTime ?? this.reminderTime,
      startedAt: startedAt ?? this.startedAt,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
      route: route ?? this.route,
      presetId: presetId ?? this.presetId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (concentration.present) {
      map['concentration'] = Variable<String>(concentration.value);
    }
    if (defaultDoseValue.present) {
      map['default_dose_value'] = Variable<double>(defaultDoseValue.value);
    }
    if (defaultDoseUnit.present) {
      map['default_dose_unit'] = Variable<String>(defaultDoseUnit.value);
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<String>(scheduleType.value);
    }
    if (scheduleConfig.present) {
      map['schedule_config'] = Variable<String>(scheduleConfig.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (route.present) {
      map['route'] = Variable<String>(route.value);
    }
    if (presetId.present) {
      map['preset_id'] = Variable<String>(presetId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('name: $name, ')
          ..write('concentration: $concentration, ')
          ..write('defaultDoseValue: $defaultDoseValue, ')
          ..write('defaultDoseUnit: $defaultDoseUnit, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('scheduleConfig: $scheduleConfig, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('startedAt: $startedAt, ')
          ..write('notes: $notes, ')
          ..write('isActive: $isActive, ')
          ..write('route: $route, ')
          ..write('presetId: $presetId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DoseChangesTable extends DoseChanges
    with TableInfo<$DoseChangesTable, DoseChangeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoseChangesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _medicationIdMeta = const VerificationMeta(
    'medicationId',
  );
  @override
  late final GeneratedColumn<String> medicationId = GeneratedColumn<String>(
    'medication_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES medications (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _effectiveFromMeta = const VerificationMeta(
    'effectiveFrom',
  );
  @override
  late final GeneratedColumn<DateTime> effectiveFrom =
      GeneratedColumn<DateTime>(
        'effective_from',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    medicationId,
    value,
    unit,
    effectiveFrom,
    reason,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dose_changes';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoseChangeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
        _medicationIdMeta,
        medicationId.isAcceptableOrUnknown(
          data['medication_id']!,
          _medicationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('effective_from')) {
      context.handle(
        _effectiveFromMeta,
        effectiveFrom.isAcceptableOrUnknown(
          data['effective_from']!,
          _effectiveFromMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_effectiveFromMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoseChangeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoseChangeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      medicationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      effectiveFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}effective_from'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $DoseChangesTable createAlias(String alias) {
    return $DoseChangesTable(attachedDatabase, alias);
  }
}

class DoseChangeRow extends DataClass implements Insertable<DoseChangeRow> {
  final String id;
  final String profileId;
  final String medicationId;
  final double value;

  /// Stored as [DoseUnit.name].
  final String unit;
  final DateTime effectiveFrom;
  final String? reason;
  final String? notes;
  const DoseChangeRow({
    required this.id,
    required this.profileId,
    required this.medicationId,
    required this.value,
    required this.unit,
    required this.effectiveFrom,
    this.reason,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['medication_id'] = Variable<String>(medicationId);
    map['value'] = Variable<double>(value);
    map['unit'] = Variable<String>(unit);
    map['effective_from'] = Variable<DateTime>(effectiveFrom);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  DoseChangesCompanion toCompanion(bool nullToAbsent) {
    return DoseChangesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      medicationId: Value(medicationId),
      value: Value(value),
      unit: Value(unit),
      effectiveFrom: Value(effectiveFrom),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory DoseChangeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoseChangeRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      medicationId: serializer.fromJson<String>(json['medicationId']),
      value: serializer.fromJson<double>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      effectiveFrom: serializer.fromJson<DateTime>(json['effectiveFrom']),
      reason: serializer.fromJson<String?>(json['reason']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'medicationId': serializer.toJson<String>(medicationId),
      'value': serializer.toJson<double>(value),
      'unit': serializer.toJson<String>(unit),
      'effectiveFrom': serializer.toJson<DateTime>(effectiveFrom),
      'reason': serializer.toJson<String?>(reason),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  DoseChangeRow copyWith({
    String? id,
    String? profileId,
    String? medicationId,
    double? value,
    String? unit,
    DateTime? effectiveFrom,
    Value<String?> reason = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => DoseChangeRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    medicationId: medicationId ?? this.medicationId,
    value: value ?? this.value,
    unit: unit ?? this.unit,
    effectiveFrom: effectiveFrom ?? this.effectiveFrom,
    reason: reason.present ? reason.value : this.reason,
    notes: notes.present ? notes.value : this.notes,
  );
  DoseChangeRow copyWithCompanion(DoseChangesCompanion data) {
    return DoseChangeRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      effectiveFrom: data.effectiveFrom.present
          ? data.effectiveFrom.value
          : this.effectiveFrom,
      reason: data.reason.present ? data.reason.value : this.reason,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoseChangeRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('medicationId: $medicationId, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    medicationId,
    value,
    unit,
    effectiveFrom,
    reason,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoseChangeRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.medicationId == this.medicationId &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.effectiveFrom == this.effectiveFrom &&
          other.reason == this.reason &&
          other.notes == this.notes);
}

class DoseChangesCompanion extends UpdateCompanion<DoseChangeRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> medicationId;
  final Value<double> value;
  final Value<String> unit;
  final Value<DateTime> effectiveFrom;
  final Value<String?> reason;
  final Value<String?> notes;
  final Value<int> rowid;
  const DoseChangesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.effectiveFrom = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DoseChangesCompanion.insert({
    required String id,
    required String profileId,
    required String medicationId,
    required double value,
    required String unit,
    required DateTime effectiveFrom,
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       medicationId = Value(medicationId),
       value = Value(value),
       unit = Value(unit),
       effectiveFrom = Value(effectiveFrom);
  static Insertable<DoseChangeRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? medicationId,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<DateTime>? effectiveFrom,
    Expression<String>? reason,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (medicationId != null) 'medication_id': medicationId,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (effectiveFrom != null) 'effective_from': effectiveFrom,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DoseChangesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? medicationId,
    Value<double>? value,
    Value<String>? unit,
    Value<DateTime>? effectiveFrom,
    Value<String?>? reason,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return DoseChangesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      medicationId: medicationId ?? this.medicationId,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      effectiveFrom: effectiveFrom ?? this.effectiveFrom,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<String>(medicationId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (effectiveFrom.present) {
      map['effective_from'] = Variable<DateTime>(effectiveFrom.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoseChangesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('medicationId: $medicationId, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('effectiveFrom: $effectiveFrom, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InjectionSitesTable extends InjectionSites
    with TableInfo<$InjectionSitesTable, InjectionSiteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InjectionSitesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _siteKeyMeta = const VerificationMeta(
    'siteKey',
  );
  @override
  late final GeneratedColumn<String> siteKey = GeneratedColumn<String>(
    'site_key',
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
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyViewMeta = const VerificationMeta(
    'bodyView',
  );
  @override
  late final GeneratedColumn<String> bodyView = GeneratedColumn<String>(
    'body_view',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cxMeta = const VerificationMeta('cx');
  @override
  late final GeneratedColumn<double> cx = GeneratedColumn<double>(
    'cx',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cyMeta = const VerificationMeta('cy');
  @override
  late final GeneratedColumn<double> cy = GeneratedColumn<double>(
    'cy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rxMeta = const VerificationMeta('rx');
  @override
  late final GeneratedColumn<double> rx = GeneratedColumn<double>(
    'rx',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ryMeta = const VerificationMeta('ry');
  @override
  late final GeneratedColumn<double> ry = GeneratedColumn<double>(
    'ry',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isEnabledMeta = const VerificationMeta(
    'isEnabled',
  );
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
    'is_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    siteKey,
    name,
    region,
    bodyView,
    cx,
    cy,
    rx,
    ry,
    isEnabled,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'injection_sites';
  @override
  VerificationContext validateIntegrity(
    Insertable<InjectionSiteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('site_key')) {
      context.handle(
        _siteKeyMeta,
        siteKey.isAcceptableOrUnknown(data['site_key']!, _siteKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_siteKeyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('body_view')) {
      context.handle(
        _bodyViewMeta,
        bodyView.isAcceptableOrUnknown(data['body_view']!, _bodyViewMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyViewMeta);
    }
    if (data.containsKey('cx')) {
      context.handle(_cxMeta, cx.isAcceptableOrUnknown(data['cx']!, _cxMeta));
    } else if (isInserting) {
      context.missing(_cxMeta);
    }
    if (data.containsKey('cy')) {
      context.handle(_cyMeta, cy.isAcceptableOrUnknown(data['cy']!, _cyMeta));
    } else if (isInserting) {
      context.missing(_cyMeta);
    }
    if (data.containsKey('rx')) {
      context.handle(_rxMeta, rx.isAcceptableOrUnknown(data['rx']!, _rxMeta));
    } else if (isInserting) {
      context.missing(_rxMeta);
    }
    if (data.containsKey('ry')) {
      context.handle(_ryMeta, ry.isAcceptableOrUnknown(data['ry']!, _ryMeta));
    } else if (isInserting) {
      context.missing(_ryMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(
        _isEnabledMeta,
        isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InjectionSiteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InjectionSiteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      siteKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}site_key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      bodyView: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_view'],
      )!,
      cx: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cx'],
      )!,
      cy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cy'],
      )!,
      rx: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rx'],
      )!,
      ry: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ry'],
      )!,
      isEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_enabled'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $InjectionSitesTable createAlias(String alias) {
    return $InjectionSitesTable(attachedDatabase, alias);
  }
}

class InjectionSiteRow extends DataClass
    implements Insertable<InjectionSiteRow> {
  final String id;
  final String profileId;

  /// Stable key matching the original prototype (e.g. "leftThigh").
  final String siteKey;
  final String name;

  /// Stored as [BodyRegion.name].
  final String region;

  /// Stored as [BodyView.name].
  final String bodyView;
  final double cx;
  final double cy;
  final double rx;
  final double ry;
  final bool isEnabled;
  final int sortOrder;
  const InjectionSiteRow({
    required this.id,
    required this.profileId,
    required this.siteKey,
    required this.name,
    required this.region,
    required this.bodyView,
    required this.cx,
    required this.cy,
    required this.rx,
    required this.ry,
    required this.isEnabled,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['site_key'] = Variable<String>(siteKey);
    map['name'] = Variable<String>(name);
    map['region'] = Variable<String>(region);
    map['body_view'] = Variable<String>(bodyView);
    map['cx'] = Variable<double>(cx);
    map['cy'] = Variable<double>(cy);
    map['rx'] = Variable<double>(rx);
    map['ry'] = Variable<double>(ry);
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  InjectionSitesCompanion toCompanion(bool nullToAbsent) {
    return InjectionSitesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      siteKey: Value(siteKey),
      name: Value(name),
      region: Value(region),
      bodyView: Value(bodyView),
      cx: Value(cx),
      cy: Value(cy),
      rx: Value(rx),
      ry: Value(ry),
      isEnabled: Value(isEnabled),
      sortOrder: Value(sortOrder),
    );
  }

  factory InjectionSiteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InjectionSiteRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      siteKey: serializer.fromJson<String>(json['siteKey']),
      name: serializer.fromJson<String>(json['name']),
      region: serializer.fromJson<String>(json['region']),
      bodyView: serializer.fromJson<String>(json['bodyView']),
      cx: serializer.fromJson<double>(json['cx']),
      cy: serializer.fromJson<double>(json['cy']),
      rx: serializer.fromJson<double>(json['rx']),
      ry: serializer.fromJson<double>(json['ry']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'siteKey': serializer.toJson<String>(siteKey),
      'name': serializer.toJson<String>(name),
      'region': serializer.toJson<String>(region),
      'bodyView': serializer.toJson<String>(bodyView),
      'cx': serializer.toJson<double>(cx),
      'cy': serializer.toJson<double>(cy),
      'rx': serializer.toJson<double>(rx),
      'ry': serializer.toJson<double>(ry),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  InjectionSiteRow copyWith({
    String? id,
    String? profileId,
    String? siteKey,
    String? name,
    String? region,
    String? bodyView,
    double? cx,
    double? cy,
    double? rx,
    double? ry,
    bool? isEnabled,
    int? sortOrder,
  }) => InjectionSiteRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    siteKey: siteKey ?? this.siteKey,
    name: name ?? this.name,
    region: region ?? this.region,
    bodyView: bodyView ?? this.bodyView,
    cx: cx ?? this.cx,
    cy: cy ?? this.cy,
    rx: rx ?? this.rx,
    ry: ry ?? this.ry,
    isEnabled: isEnabled ?? this.isEnabled,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  InjectionSiteRow copyWithCompanion(InjectionSitesCompanion data) {
    return InjectionSiteRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      siteKey: data.siteKey.present ? data.siteKey.value : this.siteKey,
      name: data.name.present ? data.name.value : this.name,
      region: data.region.present ? data.region.value : this.region,
      bodyView: data.bodyView.present ? data.bodyView.value : this.bodyView,
      cx: data.cx.present ? data.cx.value : this.cx,
      cy: data.cy.present ? data.cy.value : this.cy,
      rx: data.rx.present ? data.rx.value : this.rx,
      ry: data.ry.present ? data.ry.value : this.ry,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InjectionSiteRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('siteKey: $siteKey, ')
          ..write('name: $name, ')
          ..write('region: $region, ')
          ..write('bodyView: $bodyView, ')
          ..write('cx: $cx, ')
          ..write('cy: $cy, ')
          ..write('rx: $rx, ')
          ..write('ry: $ry, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    siteKey,
    name,
    region,
    bodyView,
    cx,
    cy,
    rx,
    ry,
    isEnabled,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InjectionSiteRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.siteKey == this.siteKey &&
          other.name == this.name &&
          other.region == this.region &&
          other.bodyView == this.bodyView &&
          other.cx == this.cx &&
          other.cy == this.cy &&
          other.rx == this.rx &&
          other.ry == this.ry &&
          other.isEnabled == this.isEnabled &&
          other.sortOrder == this.sortOrder);
}

class InjectionSitesCompanion extends UpdateCompanion<InjectionSiteRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> siteKey;
  final Value<String> name;
  final Value<String> region;
  final Value<String> bodyView;
  final Value<double> cx;
  final Value<double> cy;
  final Value<double> rx;
  final Value<double> ry;
  final Value<bool> isEnabled;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const InjectionSitesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.siteKey = const Value.absent(),
    this.name = const Value.absent(),
    this.region = const Value.absent(),
    this.bodyView = const Value.absent(),
    this.cx = const Value.absent(),
    this.cy = const Value.absent(),
    this.rx = const Value.absent(),
    this.ry = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InjectionSitesCompanion.insert({
    required String id,
    required String profileId,
    required String siteKey,
    required String name,
    required String region,
    required String bodyView,
    required double cx,
    required double cy,
    required double rx,
    required double ry,
    this.isEnabled = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       siteKey = Value(siteKey),
       name = Value(name),
       region = Value(region),
       bodyView = Value(bodyView),
       cx = Value(cx),
       cy = Value(cy),
       rx = Value(rx),
       ry = Value(ry);
  static Insertable<InjectionSiteRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? siteKey,
    Expression<String>? name,
    Expression<String>? region,
    Expression<String>? bodyView,
    Expression<double>? cx,
    Expression<double>? cy,
    Expression<double>? rx,
    Expression<double>? ry,
    Expression<bool>? isEnabled,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (siteKey != null) 'site_key': siteKey,
      if (name != null) 'name': name,
      if (region != null) 'region': region,
      if (bodyView != null) 'body_view': bodyView,
      if (cx != null) 'cx': cx,
      if (cy != null) 'cy': cy,
      if (rx != null) 'rx': rx,
      if (ry != null) 'ry': ry,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InjectionSitesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? siteKey,
    Value<String>? name,
    Value<String>? region,
    Value<String>? bodyView,
    Value<double>? cx,
    Value<double>? cy,
    Value<double>? rx,
    Value<double>? ry,
    Value<bool>? isEnabled,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return InjectionSitesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      siteKey: siteKey ?? this.siteKey,
      name: name ?? this.name,
      region: region ?? this.region,
      bodyView: bodyView ?? this.bodyView,
      cx: cx ?? this.cx,
      cy: cy ?? this.cy,
      rx: rx ?? this.rx,
      ry: ry ?? this.ry,
      isEnabled: isEnabled ?? this.isEnabled,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (siteKey.present) {
      map['site_key'] = Variable<String>(siteKey.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (bodyView.present) {
      map['body_view'] = Variable<String>(bodyView.value);
    }
    if (cx.present) {
      map['cx'] = Variable<double>(cx.value);
    }
    if (cy.present) {
      map['cy'] = Variable<double>(cy.value);
    }
    if (rx.present) {
      map['rx'] = Variable<double>(rx.value);
    }
    if (ry.present) {
      map['ry'] = Variable<double>(ry.value);
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InjectionSitesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('siteKey: $siteKey, ')
          ..write('name: $name, ')
          ..write('region: $region, ')
          ..write('bodyView: $bodyView, ')
          ..write('cx: $cx, ')
          ..write('cy: $cy, ')
          ..write('rx: $rx, ')
          ..write('ry: $ry, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InjectionsTable extends Injections
    with TableInfo<$InjectionsTable, InjectionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InjectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _siteIdMeta = const VerificationMeta('siteId');
  @override
  late final GeneratedColumn<String> siteId = GeneratedColumn<String>(
    'site_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES injection_sites (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _medicationIdMeta = const VerificationMeta(
    'medicationId',
  );
  @override
  late final GeneratedColumn<String> medicationId = GeneratedColumn<String>(
    'medication_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES medications (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _injectedAtMeta = const VerificationMeta(
    'injectedAt',
  );
  @override
  late final GeneratedColumn<DateTime> injectedAt = GeneratedColumn<DateTime>(
    'injected_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doseValueMeta = const VerificationMeta(
    'doseValue',
  );
  @override
  late final GeneratedColumn<double> doseValue = GeneratedColumn<double>(
    'dose_value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doseUnitMeta = const VerificationMeta(
    'doseUnit',
  );
  @override
  late final GeneratedColumn<String> doseUnit = GeneratedColumn<String>(
    'dose_unit',
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
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _skippedMeta = const VerificationMeta(
    'skipped',
  );
  @override
  late final GeneratedColumn<bool> skipped = GeneratedColumn<bool>(
    'skipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("skipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _skippedReasonMeta = const VerificationMeta(
    'skippedReason',
  );
  @override
  late final GeneratedColumn<String> skippedReason = GeneratedColumn<String>(
    'skipped_reason',
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
    profileId,
    siteId,
    medicationId,
    injectedAt,
    doseValue,
    doseUnit,
    notes,
    tags,
    skipped,
    skippedReason,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'injections';
  @override
  VerificationContext validateIntegrity(
    Insertable<InjectionRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('site_id')) {
      context.handle(
        _siteIdMeta,
        siteId.isAcceptableOrUnknown(data['site_id']!, _siteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_siteIdMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
        _medicationIdMeta,
        medicationId.isAcceptableOrUnknown(
          data['medication_id']!,
          _medicationIdMeta,
        ),
      );
    }
    if (data.containsKey('injected_at')) {
      context.handle(
        _injectedAtMeta,
        injectedAt.isAcceptableOrUnknown(data['injected_at']!, _injectedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_injectedAtMeta);
    }
    if (data.containsKey('dose_value')) {
      context.handle(
        _doseValueMeta,
        doseValue.isAcceptableOrUnknown(data['dose_value']!, _doseValueMeta),
      );
    }
    if (data.containsKey('dose_unit')) {
      context.handle(
        _doseUnitMeta,
        doseUnit.isAcceptableOrUnknown(data['dose_unit']!, _doseUnitMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('skipped')) {
      context.handle(
        _skippedMeta,
        skipped.isAcceptableOrUnknown(data['skipped']!, _skippedMeta),
      );
    }
    if (data.containsKey('skipped_reason')) {
      context.handle(
        _skippedReasonMeta,
        skippedReason.isAcceptableOrUnknown(
          data['skipped_reason']!,
          _skippedReasonMeta,
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
  InjectionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InjectionRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      siteId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}site_id'],
      )!,
      medicationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication_id'],
      ),
      injectedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}injected_at'],
      )!,
      doseValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}dose_value'],
      ),
      doseUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose_unit'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      skipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}skipped'],
      )!,
      skippedReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skipped_reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $InjectionsTable createAlias(String alias) {
    return $InjectionsTable(attachedDatabase, alias);
  }
}

class InjectionRow extends DataClass implements Insertable<InjectionRow> {
  final String id;
  final String profileId;
  final String siteId;
  final String? medicationId;
  final DateTime injectedAt;
  final double? doseValue;
  final String? doseUnit;
  final String? notes;

  /// JSON array of tag strings.
  final String tags;
  final bool skipped;
  final String? skippedReason;
  final DateTime createdAt;
  const InjectionRow({
    required this.id,
    required this.profileId,
    required this.siteId,
    this.medicationId,
    required this.injectedAt,
    this.doseValue,
    this.doseUnit,
    this.notes,
    required this.tags,
    required this.skipped,
    this.skippedReason,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['site_id'] = Variable<String>(siteId);
    if (!nullToAbsent || medicationId != null) {
      map['medication_id'] = Variable<String>(medicationId);
    }
    map['injected_at'] = Variable<DateTime>(injectedAt);
    if (!nullToAbsent || doseValue != null) {
      map['dose_value'] = Variable<double>(doseValue);
    }
    if (!nullToAbsent || doseUnit != null) {
      map['dose_unit'] = Variable<String>(doseUnit);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['tags'] = Variable<String>(tags);
    map['skipped'] = Variable<bool>(skipped);
    if (!nullToAbsent || skippedReason != null) {
      map['skipped_reason'] = Variable<String>(skippedReason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  InjectionsCompanion toCompanion(bool nullToAbsent) {
    return InjectionsCompanion(
      id: Value(id),
      profileId: Value(profileId),
      siteId: Value(siteId),
      medicationId: medicationId == null && nullToAbsent
          ? const Value.absent()
          : Value(medicationId),
      injectedAt: Value(injectedAt),
      doseValue: doseValue == null && nullToAbsent
          ? const Value.absent()
          : Value(doseValue),
      doseUnit: doseUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(doseUnit),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      tags: Value(tags),
      skipped: Value(skipped),
      skippedReason: skippedReason == null && nullToAbsent
          ? const Value.absent()
          : Value(skippedReason),
      createdAt: Value(createdAt),
    );
  }

  factory InjectionRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InjectionRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      siteId: serializer.fromJson<String>(json['siteId']),
      medicationId: serializer.fromJson<String?>(json['medicationId']),
      injectedAt: serializer.fromJson<DateTime>(json['injectedAt']),
      doseValue: serializer.fromJson<double?>(json['doseValue']),
      doseUnit: serializer.fromJson<String?>(json['doseUnit']),
      notes: serializer.fromJson<String?>(json['notes']),
      tags: serializer.fromJson<String>(json['tags']),
      skipped: serializer.fromJson<bool>(json['skipped']),
      skippedReason: serializer.fromJson<String?>(json['skippedReason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'siteId': serializer.toJson<String>(siteId),
      'medicationId': serializer.toJson<String?>(medicationId),
      'injectedAt': serializer.toJson<DateTime>(injectedAt),
      'doseValue': serializer.toJson<double?>(doseValue),
      'doseUnit': serializer.toJson<String?>(doseUnit),
      'notes': serializer.toJson<String?>(notes),
      'tags': serializer.toJson<String>(tags),
      'skipped': serializer.toJson<bool>(skipped),
      'skippedReason': serializer.toJson<String?>(skippedReason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  InjectionRow copyWith({
    String? id,
    String? profileId,
    String? siteId,
    Value<String?> medicationId = const Value.absent(),
    DateTime? injectedAt,
    Value<double?> doseValue = const Value.absent(),
    Value<String?> doseUnit = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? tags,
    bool? skipped,
    Value<String?> skippedReason = const Value.absent(),
    DateTime? createdAt,
  }) => InjectionRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    siteId: siteId ?? this.siteId,
    medicationId: medicationId.present ? medicationId.value : this.medicationId,
    injectedAt: injectedAt ?? this.injectedAt,
    doseValue: doseValue.present ? doseValue.value : this.doseValue,
    doseUnit: doseUnit.present ? doseUnit.value : this.doseUnit,
    notes: notes.present ? notes.value : this.notes,
    tags: tags ?? this.tags,
    skipped: skipped ?? this.skipped,
    skippedReason: skippedReason.present
        ? skippedReason.value
        : this.skippedReason,
    createdAt: createdAt ?? this.createdAt,
  );
  InjectionRow copyWithCompanion(InjectionsCompanion data) {
    return InjectionRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      siteId: data.siteId.present ? data.siteId.value : this.siteId,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      injectedAt: data.injectedAt.present
          ? data.injectedAt.value
          : this.injectedAt,
      doseValue: data.doseValue.present ? data.doseValue.value : this.doseValue,
      doseUnit: data.doseUnit.present ? data.doseUnit.value : this.doseUnit,
      notes: data.notes.present ? data.notes.value : this.notes,
      tags: data.tags.present ? data.tags.value : this.tags,
      skipped: data.skipped.present ? data.skipped.value : this.skipped,
      skippedReason: data.skippedReason.present
          ? data.skippedReason.value
          : this.skippedReason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InjectionRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('siteId: $siteId, ')
          ..write('medicationId: $medicationId, ')
          ..write('injectedAt: $injectedAt, ')
          ..write('doseValue: $doseValue, ')
          ..write('doseUnit: $doseUnit, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags, ')
          ..write('skipped: $skipped, ')
          ..write('skippedReason: $skippedReason, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    siteId,
    medicationId,
    injectedAt,
    doseValue,
    doseUnit,
    notes,
    tags,
    skipped,
    skippedReason,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InjectionRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.siteId == this.siteId &&
          other.medicationId == this.medicationId &&
          other.injectedAt == this.injectedAt &&
          other.doseValue == this.doseValue &&
          other.doseUnit == this.doseUnit &&
          other.notes == this.notes &&
          other.tags == this.tags &&
          other.skipped == this.skipped &&
          other.skippedReason == this.skippedReason &&
          other.createdAt == this.createdAt);
}

class InjectionsCompanion extends UpdateCompanion<InjectionRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<String> siteId;
  final Value<String?> medicationId;
  final Value<DateTime> injectedAt;
  final Value<double?> doseValue;
  final Value<String?> doseUnit;
  final Value<String?> notes;
  final Value<String> tags;
  final Value<bool> skipped;
  final Value<String?> skippedReason;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const InjectionsCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.siteId = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.injectedAt = const Value.absent(),
    this.doseValue = const Value.absent(),
    this.doseUnit = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    this.skipped = const Value.absent(),
    this.skippedReason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InjectionsCompanion.insert({
    required String id,
    required String profileId,
    required String siteId,
    this.medicationId = const Value.absent(),
    required DateTime injectedAt,
    this.doseValue = const Value.absent(),
    this.doseUnit = const Value.absent(),
    this.notes = const Value.absent(),
    this.tags = const Value.absent(),
    this.skipped = const Value.absent(),
    this.skippedReason = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       siteId = Value(siteId),
       injectedAt = Value(injectedAt),
       createdAt = Value(createdAt);
  static Insertable<InjectionRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<String>? siteId,
    Expression<String>? medicationId,
    Expression<DateTime>? injectedAt,
    Expression<double>? doseValue,
    Expression<String>? doseUnit,
    Expression<String>? notes,
    Expression<String>? tags,
    Expression<bool>? skipped,
    Expression<String>? skippedReason,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (siteId != null) 'site_id': siteId,
      if (medicationId != null) 'medication_id': medicationId,
      if (injectedAt != null) 'injected_at': injectedAt,
      if (doseValue != null) 'dose_value': doseValue,
      if (doseUnit != null) 'dose_unit': doseUnit,
      if (notes != null) 'notes': notes,
      if (tags != null) 'tags': tags,
      if (skipped != null) 'skipped': skipped,
      if (skippedReason != null) 'skipped_reason': skippedReason,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InjectionsCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<String>? siteId,
    Value<String?>? medicationId,
    Value<DateTime>? injectedAt,
    Value<double?>? doseValue,
    Value<String?>? doseUnit,
    Value<String?>? notes,
    Value<String>? tags,
    Value<bool>? skipped,
    Value<String?>? skippedReason,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return InjectionsCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      siteId: siteId ?? this.siteId,
      medicationId: medicationId ?? this.medicationId,
      injectedAt: injectedAt ?? this.injectedAt,
      doseValue: doseValue ?? this.doseValue,
      doseUnit: doseUnit ?? this.doseUnit,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      skipped: skipped ?? this.skipped,
      skippedReason: skippedReason ?? this.skippedReason,
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
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (siteId.present) {
      map['site_id'] = Variable<String>(siteId.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<String>(medicationId.value);
    }
    if (injectedAt.present) {
      map['injected_at'] = Variable<DateTime>(injectedAt.value);
    }
    if (doseValue.present) {
      map['dose_value'] = Variable<double>(doseValue.value);
    }
    if (doseUnit.present) {
      map['dose_unit'] = Variable<String>(doseUnit.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (skipped.present) {
      map['skipped'] = Variable<bool>(skipped.value);
    }
    if (skippedReason.present) {
      map['skipped_reason'] = Variable<String>(skippedReason.value);
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
    return (StringBuffer('InjectionsCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('siteId: $siteId, ')
          ..write('medicationId: $medicationId, ')
          ..write('injectedAt: $injectedAt, ')
          ..write('doseValue: $doseValue, ')
          ..write('doseUnit: $doseUnit, ')
          ..write('notes: $notes, ')
          ..write('tags: $tags, ')
          ..write('skipped: $skipped, ')
          ..write('skippedReason: $skippedReason, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrowthEntriesTable extends GrowthEntries
    with TableInfo<$GrowthEntriesTable, GrowthEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrowthEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _profileIdMeta = const VerificationMeta(
    'profileId',
  );
  @override
  late final GeneratedColumn<String> profileId = GeneratedColumn<String>(
    'profile_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _measuredAtMeta = const VerificationMeta(
    'measuredAt',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
    'measured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('manual'),
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    profileId,
    measuredAt,
    heightCm,
    weightKg,
    notes,
    source,
    tags,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'growth_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrowthEntryRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('profile_id')) {
      context.handle(
        _profileIdMeta,
        profileId.isAcceptableOrUnknown(data['profile_id']!, _profileIdMeta),
      );
    } else if (isInserting) {
      context.missing(_profileIdMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
        _measuredAtMeta,
        measuredAt.isAcceptableOrUnknown(data['measured_at']!, _measuredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrowthEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrowthEntryRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      profileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_id'],
      )!,
      measuredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}measured_at'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $GrowthEntriesTable createAlias(String alias) {
    return $GrowthEntriesTable(attachedDatabase, alias);
  }
}

class GrowthEntryRow extends DataClass implements Insertable<GrowthEntryRow> {
  final String id;
  final String profileId;
  final DateTime measuredAt;
  final double? heightCm;
  final double? weightKg;
  final String? notes;

  /// manual / health / clinic.
  final String source;
  final String tags;
  const GrowthEntryRow({
    required this.id,
    required this.profileId,
    required this.measuredAt,
    this.heightCm,
    this.weightKg,
    this.notes,
    required this.source,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['profile_id'] = Variable<String>(profileId);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['source'] = Variable<String>(source);
    map['tags'] = Variable<String>(tags);
    return map;
  }

  GrowthEntriesCompanion toCompanion(bool nullToAbsent) {
    return GrowthEntriesCompanion(
      id: Value(id),
      profileId: Value(profileId),
      measuredAt: Value(measuredAt),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      source: Value(source),
      tags: Value(tags),
    );
  }

  factory GrowthEntryRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrowthEntryRow(
      id: serializer.fromJson<String>(json['id']),
      profileId: serializer.fromJson<String>(json['profileId']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      notes: serializer.fromJson<String?>(json['notes']),
      source: serializer.fromJson<String>(json['source']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'profileId': serializer.toJson<String>(profileId),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'heightCm': serializer.toJson<double?>(heightCm),
      'weightKg': serializer.toJson<double?>(weightKg),
      'notes': serializer.toJson<String?>(notes),
      'source': serializer.toJson<String>(source),
      'tags': serializer.toJson<String>(tags),
    };
  }

  GrowthEntryRow copyWith({
    String? id,
    String? profileId,
    DateTime? measuredAt,
    Value<double?> heightCm = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? source,
    String? tags,
  }) => GrowthEntryRow(
    id: id ?? this.id,
    profileId: profileId ?? this.profileId,
    measuredAt: measuredAt ?? this.measuredAt,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    notes: notes.present ? notes.value : this.notes,
    source: source ?? this.source,
    tags: tags ?? this.tags,
  );
  GrowthEntryRow copyWithCompanion(GrowthEntriesCompanion data) {
    return GrowthEntryRow(
      id: data.id.present ? data.id.value : this.id,
      profileId: data.profileId.present ? data.profileId.value : this.profileId,
      measuredAt: data.measuredAt.present
          ? data.measuredAt.value
          : this.measuredAt,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      notes: data.notes.present ? data.notes.value : this.notes,
      source: data.source.present ? data.source.value : this.source,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrowthEntryRow(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('source: $source, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    profileId,
    measuredAt,
    heightCm,
    weightKg,
    notes,
    source,
    tags,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrowthEntryRow &&
          other.id == this.id &&
          other.profileId == this.profileId &&
          other.measuredAt == this.measuredAt &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.notes == this.notes &&
          other.source == this.source &&
          other.tags == this.tags);
}

class GrowthEntriesCompanion extends UpdateCompanion<GrowthEntryRow> {
  final Value<String> id;
  final Value<String> profileId;
  final Value<DateTime> measuredAt;
  final Value<double?> heightCm;
  final Value<double?> weightKg;
  final Value<String?> notes;
  final Value<String> source;
  final Value<String> tags;
  final Value<int> rowid;
  const GrowthEntriesCompanion({
    this.id = const Value.absent(),
    this.profileId = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.source = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrowthEntriesCompanion.insert({
    required String id,
    required String profileId,
    required DateTime measuredAt,
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.notes = const Value.absent(),
    this.source = const Value.absent(),
    this.tags = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       profileId = Value(profileId),
       measuredAt = Value(measuredAt);
  static Insertable<GrowthEntryRow> custom({
    Expression<String>? id,
    Expression<String>? profileId,
    Expression<DateTime>? measuredAt,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? notes,
    Expression<String>? source,
    Expression<String>? tags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (profileId != null) 'profile_id': profileId,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (notes != null) 'notes': notes,
      if (source != null) 'source': source,
      if (tags != null) 'tags': tags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrowthEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? profileId,
    Value<DateTime>? measuredAt,
    Value<double?>? heightCm,
    Value<double?>? weightKg,
    Value<String?>? notes,
    Value<String>? source,
    Value<String>? tags,
    Value<int>? rowid,
  }) {
    return GrowthEntriesCompanion(
      id: id ?? this.id,
      profileId: profileId ?? this.profileId,
      measuredAt: measuredAt ?? this.measuredAt,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      notes: notes ?? this.notes,
      source: source ?? this.source,
      tags: tags ?? this.tags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (profileId.present) {
      map['profile_id'] = Variable<String>(profileId.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrowthEntriesCompanion(')
          ..write('id: $id, ')
          ..write('profileId: $profileId, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('notes: $notes, ')
          ..write('source: $source, ')
          ..write('tags: $tags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppMetasTable extends AppMetas
    with TableInfo<$AppMetasTable, AppMetaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppMetasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('app'),
  );
  static const VerificationMeta _activeProfileIdMeta = const VerificationMeta(
    'activeProfileId',
  );
  @override
  late final GeneratedColumn<String> activeProfileId = GeneratedColumn<String>(
    'active_profile_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appLockEnabledMeta = const VerificationMeta(
    'appLockEnabled',
  );
  @override
  late final GeneratedColumn<bool> appLockEnabled = GeneratedColumn<bool>(
    'app_lock_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("app_lock_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastBackupAtMeta = const VerificationMeta(
    'lastBackupAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
    'last_backup_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    activeProfileId,
    appLockEnabled,
    lastBackupAt,
    themeMode,
    onboardingComplete,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_metas';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppMetaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('active_profile_id')) {
      context.handle(
        _activeProfileIdMeta,
        activeProfileId.isAcceptableOrUnknown(
          data['active_profile_id']!,
          _activeProfileIdMeta,
        ),
      );
    }
    if (data.containsKey('app_lock_enabled')) {
      context.handle(
        _appLockEnabledMeta,
        appLockEnabled.isAcceptableOrUnknown(
          data['app_lock_enabled']!,
          _appLockEnabledMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
        _lastBackupAtMeta,
        lastBackupAt.isAcceptableOrUnknown(
          data['last_backup_at']!,
          _lastBackupAtMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppMetaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppMetaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      activeProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}active_profile_id'],
      ),
      appLockEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}app_lock_enabled'],
      )!,
      lastBackupAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_at'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
    );
  }

  @override
  $AppMetasTable createAlias(String alias) {
    return $AppMetasTable(attachedDatabase, alias);
  }
}

class AppMetaRow extends DataClass implements Insertable<AppMetaRow> {
  final String id;
  final String? activeProfileId;
  final bool appLockEnabled;
  final DateTime? lastBackupAt;

  /// Stored as ThemeMode.name (system/light/dark).
  final String themeMode;
  final bool onboardingComplete;
  const AppMetaRow({
    required this.id,
    this.activeProfileId,
    required this.appLockEnabled,
    this.lastBackupAt,
    required this.themeMode,
    required this.onboardingComplete,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || activeProfileId != null) {
      map['active_profile_id'] = Variable<String>(activeProfileId);
    }
    map['app_lock_enabled'] = Variable<bool>(appLockEnabled);
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    return map;
  }

  AppMetasCompanion toCompanion(bool nullToAbsent) {
    return AppMetasCompanion(
      id: Value(id),
      activeProfileId: activeProfileId == null && nullToAbsent
          ? const Value.absent()
          : Value(activeProfileId),
      appLockEnabled: Value(appLockEnabled),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
      themeMode: Value(themeMode),
      onboardingComplete: Value(onboardingComplete),
    );
  }

  factory AppMetaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppMetaRow(
      id: serializer.fromJson<String>(json['id']),
      activeProfileId: serializer.fromJson<String?>(json['activeProfileId']),
      appLockEnabled: serializer.fromJson<bool>(json['appLockEnabled']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'activeProfileId': serializer.toJson<String?>(activeProfileId),
      'appLockEnabled': serializer.toJson<bool>(appLockEnabled),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
      'themeMode': serializer.toJson<String>(themeMode),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
    };
  }

  AppMetaRow copyWith({
    String? id,
    Value<String?> activeProfileId = const Value.absent(),
    bool? appLockEnabled,
    Value<DateTime?> lastBackupAt = const Value.absent(),
    String? themeMode,
    bool? onboardingComplete,
  }) => AppMetaRow(
    id: id ?? this.id,
    activeProfileId: activeProfileId.present
        ? activeProfileId.value
        : this.activeProfileId,
    appLockEnabled: appLockEnabled ?? this.appLockEnabled,
    lastBackupAt: lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
    themeMode: themeMode ?? this.themeMode,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
  );
  AppMetaRow copyWithCompanion(AppMetasCompanion data) {
    return AppMetaRow(
      id: data.id.present ? data.id.value : this.id,
      activeProfileId: data.activeProfileId.present
          ? data.activeProfileId.value
          : this.activeProfileId,
      appLockEnabled: data.appLockEnabled.present
          ? data.appLockEnabled.value
          : this.appLockEnabled,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppMetaRow(')
          ..write('id: $id, ')
          ..write('activeProfileId: $activeProfileId, ')
          ..write('appLockEnabled: $appLockEnabled, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('themeMode: $themeMode, ')
          ..write('onboardingComplete: $onboardingComplete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    activeProfileId,
    appLockEnabled,
    lastBackupAt,
    themeMode,
    onboardingComplete,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppMetaRow &&
          other.id == this.id &&
          other.activeProfileId == this.activeProfileId &&
          other.appLockEnabled == this.appLockEnabled &&
          other.lastBackupAt == this.lastBackupAt &&
          other.themeMode == this.themeMode &&
          other.onboardingComplete == this.onboardingComplete);
}

class AppMetasCompanion extends UpdateCompanion<AppMetaRow> {
  final Value<String> id;
  final Value<String?> activeProfileId;
  final Value<bool> appLockEnabled;
  final Value<DateTime?> lastBackupAt;
  final Value<String> themeMode;
  final Value<bool> onboardingComplete;
  final Value<int> rowid;
  const AppMetasCompanion({
    this.id = const Value.absent(),
    this.activeProfileId = const Value.absent(),
    this.appLockEnabled = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppMetasCompanion.insert({
    this.id = const Value.absent(),
    this.activeProfileId = const Value.absent(),
    this.appLockEnabled = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  static Insertable<AppMetaRow> custom({
    Expression<String>? id,
    Expression<String>? activeProfileId,
    Expression<bool>? appLockEnabled,
    Expression<DateTime>? lastBackupAt,
    Expression<String>? themeMode,
    Expression<bool>? onboardingComplete,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (activeProfileId != null) 'active_profile_id': activeProfileId,
      if (appLockEnabled != null) 'app_lock_enabled': appLockEnabled,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
      if (themeMode != null) 'theme_mode': themeMode,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppMetasCompanion copyWith({
    Value<String>? id,
    Value<String?>? activeProfileId,
    Value<bool>? appLockEnabled,
    Value<DateTime?>? lastBackupAt,
    Value<String>? themeMode,
    Value<bool>? onboardingComplete,
    Value<int>? rowid,
  }) {
    return AppMetasCompanion(
      id: id ?? this.id,
      activeProfileId: activeProfileId ?? this.activeProfileId,
      appLockEnabled: appLockEnabled ?? this.appLockEnabled,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      themeMode: themeMode ?? this.themeMode,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (activeProfileId.present) {
      map['active_profile_id'] = Variable<String>(activeProfileId.value);
    }
    if (appLockEnabled.present) {
      map['app_lock_enabled'] = Variable<bool>(appLockEnabled.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppMetasCompanion(')
          ..write('id: $id, ')
          ..write('activeProfileId: $activeProfileId, ')
          ..write('appLockEnabled: $appLockEnabled, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('themeMode: $themeMode, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $MedicationsTable medications = $MedicationsTable(this);
  late final $DoseChangesTable doseChanges = $DoseChangesTable(this);
  late final $InjectionSitesTable injectionSites = $InjectionSitesTable(this);
  late final $InjectionsTable injections = $InjectionsTable(this);
  late final $GrowthEntriesTable growthEntries = $GrowthEntriesTable(this);
  late final $AppMetasTable appMetas = $AppMetasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    medications,
    doseChanges,
    injectionSites,
    injections,
    growthEntries,
    appMetas,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('medications', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('dose_changes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'medications',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('dose_changes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injection_sites', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injections', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'injection_sites',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injections', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'medications',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('injections', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('growth_entries', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      required String id,
      required String name,
      Value<DateTime?> dateOfBirth,
      Value<String> sex,
      Value<String?> avatarPath,
      Value<String> unitSystem,
      Value<int?> colorSeed,
      Value<String?> healthcareProvider,
      Value<bool> isArchived,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime?> dateOfBirth,
      Value<String> sex,
      Value<String?> avatarPath,
      Value<String> unitSystem,
      Value<int?> colorSeed,
      Value<String?> healthcareProvider,
      Value<bool> isArchived,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$ProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $ProfilesTable, ProfileRow> {
  $$ProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MedicationsTable, List<MedicationRow>>
  _medicationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.medications,
    aliasName: 'profiles__id__medications__profile_id',
  );

  $$MedicationsTableProcessedTableManager get medicationsRefs {
    final manager = $$MedicationsTableTableManager(
      $_db,
      $_db.medications,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_medicationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DoseChangesTable, List<DoseChangeRow>>
  _doseChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.doseChanges,
    aliasName: 'profiles__id__dose_changes__profile_id',
  );

  $$DoseChangesTableProcessedTableManager get doseChangesRefs {
    final manager = $$DoseChangesTableTableManager(
      $_db,
      $_db.doseChanges,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_doseChangesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InjectionSitesTable, List<InjectionSiteRow>>
  _injectionSitesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.injectionSites,
    aliasName: 'profiles__id__injection_sites__profile_id',
  );

  $$InjectionSitesTableProcessedTableManager get injectionSitesRefs {
    final manager = $$InjectionSitesTableTableManager(
      $_db,
      $_db.injectionSites,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_injectionSitesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InjectionsTable, List<InjectionRow>>
  _injectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.injections,
    aliasName: 'profiles__id__injections__profile_id',
  );

  $$InjectionsTableProcessedTableManager get injectionsRefs {
    final manager = $$InjectionsTableTableManager(
      $_db,
      $_db.injections,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_injectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GrowthEntriesTable, List<GrowthEntryRow>>
  _growthEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.growthEntries,
    aliasName: 'profiles__id__growth_entries__profile_id',
  );

  $$GrowthEntriesTableProcessedTableManager get growthEntriesRefs {
    final manager = $$GrowthEntriesTableTableManager(
      $_db,
      $_db.growthEntries,
    ).filter((f) => f.profileId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_growthEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
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

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get colorSeed => $composableBuilder(
    column: $table.colorSeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get healthcareProvider => $composableBuilder(
    column: $table.healthcareProvider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
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

  Expression<bool> medicationsRefs(
    Expression<bool> Function($$MedicationsTableFilterComposer f) f,
  ) {
    final $$MedicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableFilterComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> doseChangesRefs(
    Expression<bool> Function($$DoseChangesTableFilterComposer f) f,
  ) {
    final $$DoseChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseChanges,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseChangesTableFilterComposer(
            $db: $db,
            $table: $db.doseChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> injectionSitesRefs(
    Expression<bool> Function($$InjectionSitesTableFilterComposer f) f,
  ) {
    final $$InjectionSitesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injectionSites,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionSitesTableFilterComposer(
            $db: $db,
            $table: $db.injectionSites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> injectionsRefs(
    Expression<bool> Function($$InjectionsTableFilterComposer f) f,
  ) {
    final $$InjectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injections,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionsTableFilterComposer(
            $db: $db,
            $table: $db.injections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> growthEntriesRefs(
    Expression<bool> Function($$GrowthEntriesTableFilterComposer f) f,
  ) {
    final $$GrowthEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.growthEntries,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthEntriesTableFilterComposer(
            $db: $db,
            $table: $db.growthEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sex => $composableBuilder(
    column: $table.sex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get colorSeed => $composableBuilder(
    column: $table.colorSeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get healthcareProvider => $composableBuilder(
    column: $table.healthcareProvider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
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

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sex =>
      $composableBuilder(column: $table.sex, builder: (column) => column);

  GeneratedColumn<String> get avatarPath => $composableBuilder(
    column: $table.avatarPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unitSystem => $composableBuilder(
    column: $table.unitSystem,
    builder: (column) => column,
  );

  GeneratedColumn<int> get colorSeed =>
      $composableBuilder(column: $table.colorSeed, builder: (column) => column);

  GeneratedColumn<String> get healthcareProvider => $composableBuilder(
    column: $table.healthcareProvider,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> medicationsRefs<T extends Object>(
    Expression<T> Function($$MedicationsTableAnnotationComposer a) f,
  ) {
    final $$MedicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> doseChangesRefs<T extends Object>(
    Expression<T> Function($$DoseChangesTableAnnotationComposer a) f,
  ) {
    final $$DoseChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseChanges,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.doseChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> injectionSitesRefs<T extends Object>(
    Expression<T> Function($$InjectionSitesTableAnnotationComposer a) f,
  ) {
    final $$InjectionSitesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injectionSites,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionSitesTableAnnotationComposer(
            $db: $db,
            $table: $db.injectionSites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> injectionsRefs<T extends Object>(
    Expression<T> Function($$InjectionsTableAnnotationComposer a) f,
  ) {
    final $$InjectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injections,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.injections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> growthEntriesRefs<T extends Object>(
    Expression<T> Function($$GrowthEntriesTableAnnotationComposer a) f,
  ) {
    final $$GrowthEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.growthEntries,
      getReferencedColumn: (t) => t.profileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GrowthEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.growthEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          ProfileRow,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (ProfileRow, $$ProfilesTableReferences),
          ProfileRow,
          PrefetchHooks Function({
            bool medicationsRefs,
            bool doseChangesRefs,
            bool injectionSitesRefs,
            bool injectionsRefs,
            bool growthEntriesRefs,
          })
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<int?> colorSeed = const Value.absent(),
                Value<String?> healthcareProvider = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                name: name,
                dateOfBirth: dateOfBirth,
                sex: sex,
                avatarPath: avatarPath,
                unitSystem: unitSystem,
                colorSeed: colorSeed,
                healthcareProvider: healthcareProvider,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String> sex = const Value.absent(),
                Value<String?> avatarPath = const Value.absent(),
                Value<String> unitSystem = const Value.absent(),
                Value<int?> colorSeed = const Value.absent(),
                Value<String?> healthcareProvider = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ProfilesCompanion.insert(
                id: id,
                name: name,
                dateOfBirth: dateOfBirth,
                sex: sex,
                avatarPath: avatarPath,
                unitSystem: unitSystem,
                colorSeed: colorSeed,
                healthcareProvider: healthcareProvider,
                isArchived: isArchived,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                medicationsRefs = false,
                doseChangesRefs = false,
                injectionSitesRefs = false,
                injectionsRefs = false,
                growthEntriesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (medicationsRefs) db.medications,
                    if (doseChangesRefs) db.doseChanges,
                    if (injectionSitesRefs) db.injectionSites,
                    if (injectionsRefs) db.injections,
                    if (growthEntriesRefs) db.growthEntries,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (medicationsRefs)
                        await $_getPrefetchedData<
                          ProfileRow,
                          $ProfilesTable,
                          MedicationRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._medicationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).medicationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (doseChangesRefs)
                        await $_getPrefetchedData<
                          ProfileRow,
                          $ProfilesTable,
                          DoseChangeRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._doseChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).doseChangesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (injectionSitesRefs)
                        await $_getPrefetchedData<
                          ProfileRow,
                          $ProfilesTable,
                          InjectionSiteRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._injectionSitesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).injectionSitesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (injectionsRefs)
                        await $_getPrefetchedData<
                          ProfileRow,
                          $ProfilesTable,
                          InjectionRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._injectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).injectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (growthEntriesRefs)
                        await $_getPrefetchedData<
                          ProfileRow,
                          $ProfilesTable,
                          GrowthEntryRow
                        >(
                          currentTable: table,
                          referencedTable: $$ProfilesTableReferences
                              ._growthEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).growthEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.profileId == item.id,
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

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      ProfileRow,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (ProfileRow, $$ProfilesTableReferences),
      ProfileRow,
      PrefetchHooks Function({
        bool medicationsRefs,
        bool doseChangesRefs,
        bool injectionSitesRefs,
        bool injectionsRefs,
        bool growthEntriesRefs,
      })
    >;
typedef $$MedicationsTableCreateCompanionBuilder =
    MedicationsCompanion Function({
      required String id,
      required String profileId,
      required String name,
      Value<String?> concentration,
      Value<double?> defaultDoseValue,
      Value<String> defaultDoseUnit,
      Value<String> scheduleType,
      Value<String> scheduleConfig,
      Value<String?> reminderTime,
      Value<DateTime?> startedAt,
      Value<String?> notes,
      Value<bool> isActive,
      Value<String> route,
      Value<String?> presetId,
      Value<int> rowid,
    });
typedef $$MedicationsTableUpdateCompanionBuilder =
    MedicationsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> name,
      Value<String?> concentration,
      Value<double?> defaultDoseValue,
      Value<String> defaultDoseUnit,
      Value<String> scheduleType,
      Value<String> scheduleConfig,
      Value<String?> reminderTime,
      Value<DateTime?> startedAt,
      Value<String?> notes,
      Value<bool> isActive,
      Value<String> route,
      Value<String?> presetId,
      Value<int> rowid,
    });

final class $$MedicationsTableReferences
    extends BaseReferences<_$AppDatabase, $MedicationsTable, MedicationRow> {
  $$MedicationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('medications__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DoseChangesTable, List<DoseChangeRow>>
  _doseChangesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.doseChanges,
    aliasName: 'medications__id__dose_changes__medication_id',
  );

  $$DoseChangesTableProcessedTableManager get doseChangesRefs {
    final manager = $$DoseChangesTableTableManager(
      $_db,
      $_db.doseChanges,
    ).filter((f) => f.medicationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_doseChangesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InjectionsTable, List<InjectionRow>>
  _injectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.injections,
    aliasName: 'medications__id__injections__medication_id',
  );

  $$InjectionsTableProcessedTableManager get injectionsRefs {
    final manager = $$InjectionsTableTableManager(
      $_db,
      $_db.injections,
    ).filter((f) => f.medicationId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_injectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MedicationsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableFilterComposer({
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

  ColumnFilters<String> get concentration => $composableBuilder(
    column: $table.concentration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultDoseValue => $composableBuilder(
    column: $table.defaultDoseValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultDoseUnit => $composableBuilder(
    column: $table.defaultDoseUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get presetId => $composableBuilder(
    column: $table.presetId,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> doseChangesRefs(
    Expression<bool> Function($$DoseChangesTableFilterComposer f) f,
  ) {
    final $$DoseChangesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseChanges,
      getReferencedColumn: (t) => t.medicationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseChangesTableFilterComposer(
            $db: $db,
            $table: $db.doseChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> injectionsRefs(
    Expression<bool> Function($$InjectionsTableFilterComposer f) f,
  ) {
    final $$InjectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injections,
      getReferencedColumn: (t) => t.medicationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionsTableFilterComposer(
            $db: $db,
            $table: $db.injections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MedicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableOrderingComposer({
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

  ColumnOrderings<String> get concentration => $composableBuilder(
    column: $table.concentration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultDoseValue => $composableBuilder(
    column: $table.defaultDoseValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultDoseUnit => $composableBuilder(
    column: $table.defaultDoseUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get route => $composableBuilder(
    column: $table.route,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get presetId => $composableBuilder(
    column: $table.presetId,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MedicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableAnnotationComposer({
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

  GeneratedColumn<String> get concentration => $composableBuilder(
    column: $table.concentration,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultDoseValue => $composableBuilder(
    column: $table.defaultDoseValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultDoseUnit => $composableBuilder(
    column: $table.defaultDoseUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scheduleConfig => $composableBuilder(
    column: $table.scheduleConfig,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get route =>
      $composableBuilder(column: $table.route, builder: (column) => column);

  GeneratedColumn<String> get presetId =>
      $composableBuilder(column: $table.presetId, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> doseChangesRefs<T extends Object>(
    Expression<T> Function($$DoseChangesTableAnnotationComposer a) f,
  ) {
    final $$DoseChangesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.doseChanges,
      getReferencedColumn: (t) => t.medicationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DoseChangesTableAnnotationComposer(
            $db: $db,
            $table: $db.doseChanges,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> injectionsRefs<T extends Object>(
    Expression<T> Function($$InjectionsTableAnnotationComposer a) f,
  ) {
    final $$InjectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injections,
      getReferencedColumn: (t) => t.medicationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.injections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MedicationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicationsTable,
          MedicationRow,
          $$MedicationsTableFilterComposer,
          $$MedicationsTableOrderingComposer,
          $$MedicationsTableAnnotationComposer,
          $$MedicationsTableCreateCompanionBuilder,
          $$MedicationsTableUpdateCompanionBuilder,
          (MedicationRow, $$MedicationsTableReferences),
          MedicationRow,
          PrefetchHooks Function({
            bool profileId,
            bool doseChangesRefs,
            bool injectionsRefs,
          })
        > {
  $$MedicationsTableTableManager(_$AppDatabase db, $MedicationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> concentration = const Value.absent(),
                Value<double?> defaultDoseValue = const Value.absent(),
                Value<String> defaultDoseUnit = const Value.absent(),
                Value<String> scheduleType = const Value.absent(),
                Value<String> scheduleConfig = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> route = const Value.absent(),
                Value<String?> presetId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicationsCompanion(
                id: id,
                profileId: profileId,
                name: name,
                concentration: concentration,
                defaultDoseValue: defaultDoseValue,
                defaultDoseUnit: defaultDoseUnit,
                scheduleType: scheduleType,
                scheduleConfig: scheduleConfig,
                reminderTime: reminderTime,
                startedAt: startedAt,
                notes: notes,
                isActive: isActive,
                route: route,
                presetId: presetId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String name,
                Value<String?> concentration = const Value.absent(),
                Value<double?> defaultDoseValue = const Value.absent(),
                Value<String> defaultDoseUnit = const Value.absent(),
                Value<String> scheduleType = const Value.absent(),
                Value<String> scheduleConfig = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> route = const Value.absent(),
                Value<String?> presetId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MedicationsCompanion.insert(
                id: id,
                profileId: profileId,
                name: name,
                concentration: concentration,
                defaultDoseValue: defaultDoseValue,
                defaultDoseUnit: defaultDoseUnit,
                scheduleType: scheduleType,
                scheduleConfig: scheduleConfig,
                reminderTime: reminderTime,
                startedAt: startedAt,
                notes: notes,
                isActive: isActive,
                route: route,
                presetId: presetId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MedicationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                profileId = false,
                doseChangesRefs = false,
                injectionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (doseChangesRefs) db.doseChanges,
                    if (injectionsRefs) db.injections,
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable:
                                        $$MedicationsTableReferences
                                            ._profileIdTable(db),
                                    referencedColumn:
                                        $$MedicationsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (doseChangesRefs)
                        await $_getPrefetchedData<
                          MedicationRow,
                          $MedicationsTable,
                          DoseChangeRow
                        >(
                          currentTable: table,
                          referencedTable: $$MedicationsTableReferences
                              ._doseChangesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MedicationsTableReferences(
                                db,
                                table,
                                p0,
                              ).doseChangesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.medicationId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (injectionsRefs)
                        await $_getPrefetchedData<
                          MedicationRow,
                          $MedicationsTable,
                          InjectionRow
                        >(
                          currentTable: table,
                          referencedTable: $$MedicationsTableReferences
                              ._injectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MedicationsTableReferences(
                                db,
                                table,
                                p0,
                              ).injectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.medicationId == item.id,
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

typedef $$MedicationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicationsTable,
      MedicationRow,
      $$MedicationsTableFilterComposer,
      $$MedicationsTableOrderingComposer,
      $$MedicationsTableAnnotationComposer,
      $$MedicationsTableCreateCompanionBuilder,
      $$MedicationsTableUpdateCompanionBuilder,
      (MedicationRow, $$MedicationsTableReferences),
      MedicationRow,
      PrefetchHooks Function({
        bool profileId,
        bool doseChangesRefs,
        bool injectionsRefs,
      })
    >;
typedef $$DoseChangesTableCreateCompanionBuilder =
    DoseChangesCompanion Function({
      required String id,
      required String profileId,
      required String medicationId,
      required double value,
      required String unit,
      required DateTime effectiveFrom,
      Value<String?> reason,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$DoseChangesTableUpdateCompanionBuilder =
    DoseChangesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> medicationId,
      Value<double> value,
      Value<String> unit,
      Value<DateTime> effectiveFrom,
      Value<String?> reason,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$DoseChangesTableReferences
    extends BaseReferences<_$AppDatabase, $DoseChangesTable, DoseChangeRow> {
  $$DoseChangesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('dose_changes__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MedicationsTable _medicationIdTable(_$AppDatabase db) => db
      .medications
      .createAlias('dose_changes__medication_id__medications__id');

  $$MedicationsTableProcessedTableManager get medicationId {
    final $_column = $_itemColumn<String>('medication_id')!;

    final manager = $$MedicationsTableTableManager(
      $_db,
      $_db.medications,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DoseChangesTableFilterComposer
    extends Composer<_$AppDatabase, $DoseChangesTable> {
  $$DoseChangesTableFilterComposer({
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

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicationsTableFilterComposer get medicationId {
    final $$MedicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicationId,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableFilterComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DoseChangesTableOrderingComposer
    extends Composer<_$AppDatabase, $DoseChangesTable> {
  $$DoseChangesTableOrderingComposer({
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

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicationsTableOrderingComposer get medicationId {
    final $$MedicationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicationId,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableOrderingComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DoseChangesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoseChangesTable> {
  $$DoseChangesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<DateTime> get effectiveFrom => $composableBuilder(
    column: $table.effectiveFrom,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicationsTableAnnotationComposer get medicationId {
    final $$MedicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicationId,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DoseChangesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoseChangesTable,
          DoseChangeRow,
          $$DoseChangesTableFilterComposer,
          $$DoseChangesTableOrderingComposer,
          $$DoseChangesTableAnnotationComposer,
          $$DoseChangesTableCreateCompanionBuilder,
          $$DoseChangesTableUpdateCompanionBuilder,
          (DoseChangeRow, $$DoseChangesTableReferences),
          DoseChangeRow,
          PrefetchHooks Function({bool profileId, bool medicationId})
        > {
  $$DoseChangesTableTableManager(_$AppDatabase db, $DoseChangesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoseChangesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoseChangesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoseChangesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> medicationId = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<DateTime> effectiveFrom = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseChangesCompanion(
                id: id,
                profileId: profileId,
                medicationId: medicationId,
                value: value,
                unit: unit,
                effectiveFrom: effectiveFrom,
                reason: reason,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String medicationId,
                required double value,
                required String unit,
                required DateTime effectiveFrom,
                Value<String?> reason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DoseChangesCompanion.insert(
                id: id,
                profileId: profileId,
                medicationId: medicationId,
                value: value,
                unit: unit,
                effectiveFrom: effectiveFrom,
                reason: reason,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DoseChangesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, medicationId = false}) {
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$DoseChangesTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$DoseChangesTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (medicationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.medicationId,
                                referencedTable: $$DoseChangesTableReferences
                                    ._medicationIdTable(db),
                                referencedColumn: $$DoseChangesTableReferences
                                    ._medicationIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$DoseChangesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoseChangesTable,
      DoseChangeRow,
      $$DoseChangesTableFilterComposer,
      $$DoseChangesTableOrderingComposer,
      $$DoseChangesTableAnnotationComposer,
      $$DoseChangesTableCreateCompanionBuilder,
      $$DoseChangesTableUpdateCompanionBuilder,
      (DoseChangeRow, $$DoseChangesTableReferences),
      DoseChangeRow,
      PrefetchHooks Function({bool profileId, bool medicationId})
    >;
typedef $$InjectionSitesTableCreateCompanionBuilder =
    InjectionSitesCompanion Function({
      required String id,
      required String profileId,
      required String siteKey,
      required String name,
      required String region,
      required String bodyView,
      required double cx,
      required double cy,
      required double rx,
      required double ry,
      Value<bool> isEnabled,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$InjectionSitesTableUpdateCompanionBuilder =
    InjectionSitesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> siteKey,
      Value<String> name,
      Value<String> region,
      Value<String> bodyView,
      Value<double> cx,
      Value<double> cy,
      Value<double> rx,
      Value<double> ry,
      Value<bool> isEnabled,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$InjectionSitesTableReferences
    extends
        BaseReferences<_$AppDatabase, $InjectionSitesTable, InjectionSiteRow> {
  $$InjectionSitesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('injection_sites__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InjectionsTable, List<InjectionRow>>
  _injectionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.injections,
    aliasName: 'injection_sites__id__injections__site_id',
  );

  $$InjectionsTableProcessedTableManager get injectionsRefs {
    final manager = $$InjectionsTableTableManager(
      $_db,
      $_db.injections,
    ).filter((f) => f.siteId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_injectionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InjectionSitesTableFilterComposer
    extends Composer<_$AppDatabase, $InjectionSitesTable> {
  $$InjectionSitesTableFilterComposer({
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

  ColumnFilters<String> get siteKey => $composableBuilder(
    column: $table.siteKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyView => $composableBuilder(
    column: $table.bodyView,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cx => $composableBuilder(
    column: $table.cx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cy => $composableBuilder(
    column: $table.cy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rx => $composableBuilder(
    column: $table.rx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ry => $composableBuilder(
    column: $table.ry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> injectionsRefs(
    Expression<bool> Function($$InjectionsTableFilterComposer f) f,
  ) {
    final $$InjectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injections,
      getReferencedColumn: (t) => t.siteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionsTableFilterComposer(
            $db: $db,
            $table: $db.injections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InjectionSitesTableOrderingComposer
    extends Composer<_$AppDatabase, $InjectionSitesTable> {
  $$InjectionSitesTableOrderingComposer({
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

  ColumnOrderings<String> get siteKey => $composableBuilder(
    column: $table.siteKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyView => $composableBuilder(
    column: $table.bodyView,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cx => $composableBuilder(
    column: $table.cx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cy => $composableBuilder(
    column: $table.cy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rx => $composableBuilder(
    column: $table.rx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ry => $composableBuilder(
    column: $table.ry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
    column: $table.isEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InjectionSitesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InjectionSitesTable> {
  $$InjectionSitesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get siteKey =>
      $composableBuilder(column: $table.siteKey, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get bodyView =>
      $composableBuilder(column: $table.bodyView, builder: (column) => column);

  GeneratedColumn<double> get cx =>
      $composableBuilder(column: $table.cx, builder: (column) => column);

  GeneratedColumn<double> get cy =>
      $composableBuilder(column: $table.cy, builder: (column) => column);

  GeneratedColumn<double> get rx =>
      $composableBuilder(column: $table.rx, builder: (column) => column);

  GeneratedColumn<double> get ry =>
      $composableBuilder(column: $table.ry, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> injectionsRefs<T extends Object>(
    Expression<T> Function($$InjectionsTableAnnotationComposer a) f,
  ) {
    final $$InjectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.injections,
      getReferencedColumn: (t) => t.siteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.injections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InjectionSitesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InjectionSitesTable,
          InjectionSiteRow,
          $$InjectionSitesTableFilterComposer,
          $$InjectionSitesTableOrderingComposer,
          $$InjectionSitesTableAnnotationComposer,
          $$InjectionSitesTableCreateCompanionBuilder,
          $$InjectionSitesTableUpdateCompanionBuilder,
          (InjectionSiteRow, $$InjectionSitesTableReferences),
          InjectionSiteRow,
          PrefetchHooks Function({bool profileId, bool injectionsRefs})
        > {
  $$InjectionSitesTableTableManager(
    _$AppDatabase db,
    $InjectionSitesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InjectionSitesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InjectionSitesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InjectionSitesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> siteKey = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<String> bodyView = const Value.absent(),
                Value<double> cx = const Value.absent(),
                Value<double> cy = const Value.absent(),
                Value<double> rx = const Value.absent(),
                Value<double> ry = const Value.absent(),
                Value<bool> isEnabled = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InjectionSitesCompanion(
                id: id,
                profileId: profileId,
                siteKey: siteKey,
                name: name,
                region: region,
                bodyView: bodyView,
                cx: cx,
                cy: cy,
                rx: rx,
                ry: ry,
                isEnabled: isEnabled,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String siteKey,
                required String name,
                required String region,
                required String bodyView,
                required double cx,
                required double cy,
                required double rx,
                required double ry,
                Value<bool> isEnabled = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InjectionSitesCompanion.insert(
                id: id,
                profileId: profileId,
                siteKey: siteKey,
                name: name,
                region: region,
                bodyView: bodyView,
                cx: cx,
                cy: cy,
                rx: rx,
                ry: ry,
                isEnabled: isEnabled,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InjectionSitesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false, injectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (injectionsRefs) db.injections],
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$InjectionSitesTableReferences
                                    ._profileIdTable(db),
                                referencedColumn:
                                    $$InjectionSitesTableReferences
                                        ._profileIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (injectionsRefs)
                    await $_getPrefetchedData<
                      InjectionSiteRow,
                      $InjectionSitesTable,
                      InjectionRow
                    >(
                      currentTable: table,
                      referencedTable: $$InjectionSitesTableReferences
                          ._injectionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$InjectionSitesTableReferences(
                            db,
                            table,
                            p0,
                          ).injectionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.siteId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$InjectionSitesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InjectionSitesTable,
      InjectionSiteRow,
      $$InjectionSitesTableFilterComposer,
      $$InjectionSitesTableOrderingComposer,
      $$InjectionSitesTableAnnotationComposer,
      $$InjectionSitesTableCreateCompanionBuilder,
      $$InjectionSitesTableUpdateCompanionBuilder,
      (InjectionSiteRow, $$InjectionSitesTableReferences),
      InjectionSiteRow,
      PrefetchHooks Function({bool profileId, bool injectionsRefs})
    >;
typedef $$InjectionsTableCreateCompanionBuilder =
    InjectionsCompanion Function({
      required String id,
      required String profileId,
      required String siteId,
      Value<String?> medicationId,
      required DateTime injectedAt,
      Value<double?> doseValue,
      Value<String?> doseUnit,
      Value<String?> notes,
      Value<String> tags,
      Value<bool> skipped,
      Value<String?> skippedReason,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$InjectionsTableUpdateCompanionBuilder =
    InjectionsCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<String> siteId,
      Value<String?> medicationId,
      Value<DateTime> injectedAt,
      Value<double?> doseValue,
      Value<String?> doseUnit,
      Value<String?> notes,
      Value<String> tags,
      Value<bool> skipped,
      Value<String?> skippedReason,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$InjectionsTableReferences
    extends BaseReferences<_$AppDatabase, $InjectionsTable, InjectionRow> {
  $$InjectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('injections__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InjectionSitesTable _siteIdTable(_$AppDatabase db) =>
      db.injectionSites.createAlias('injections__site_id__injection_sites__id');

  $$InjectionSitesTableProcessedTableManager get siteId {
    final $_column = $_itemColumn<String>('site_id')!;

    final manager = $$InjectionSitesTableTableManager(
      $_db,
      $_db.injectionSites,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_siteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MedicationsTable _medicationIdTable(_$AppDatabase db) =>
      db.medications.createAlias('injections__medication_id__medications__id');

  $$MedicationsTableProcessedTableManager? get medicationId {
    final $_column = $_itemColumn<String>('medication_id');
    if ($_column == null) return null;
    final manager = $$MedicationsTableTableManager(
      $_db,
      $_db.medications,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InjectionsTableFilterComposer
    extends Composer<_$AppDatabase, $InjectionsTable> {
  $$InjectionsTableFilterComposer({
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

  ColumnFilters<DateTime> get injectedAt => $composableBuilder(
    column: $table.injectedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get doseValue => $composableBuilder(
    column: $table.doseValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doseUnit => $composableBuilder(
    column: $table.doseUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skippedReason => $composableBuilder(
    column: $table.skippedReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InjectionSitesTableFilterComposer get siteId {
    final $$InjectionSitesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.siteId,
      referencedTable: $db.injectionSites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionSitesTableFilterComposer(
            $db: $db,
            $table: $db.injectionSites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicationsTableFilterComposer get medicationId {
    final $$MedicationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicationId,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableFilterComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InjectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $InjectionsTable> {
  $$InjectionsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get injectedAt => $composableBuilder(
    column: $table.injectedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get doseValue => $composableBuilder(
    column: $table.doseValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doseUnit => $composableBuilder(
    column: $table.doseUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get skipped => $composableBuilder(
    column: $table.skipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skippedReason => $composableBuilder(
    column: $table.skippedReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InjectionSitesTableOrderingComposer get siteId {
    final $$InjectionSitesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.siteId,
      referencedTable: $db.injectionSites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionSitesTableOrderingComposer(
            $db: $db,
            $table: $db.injectionSites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicationsTableOrderingComposer get medicationId {
    final $$MedicationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicationId,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableOrderingComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InjectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InjectionsTable> {
  $$InjectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get injectedAt => $composableBuilder(
    column: $table.injectedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get doseValue =>
      $composableBuilder(column: $table.doseValue, builder: (column) => column);

  GeneratedColumn<String> get doseUnit =>
      $composableBuilder(column: $table.doseUnit, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<bool> get skipped =>
      $composableBuilder(column: $table.skipped, builder: (column) => column);

  GeneratedColumn<String> get skippedReason => $composableBuilder(
    column: $table.skippedReason,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InjectionSitesTableAnnotationComposer get siteId {
    final $$InjectionSitesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.siteId,
      referencedTable: $db.injectionSites,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InjectionSitesTableAnnotationComposer(
            $db: $db,
            $table: $db.injectionSites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicationsTableAnnotationComposer get medicationId {
    final $$MedicationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicationId,
      referencedTable: $db.medications,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicationsTableAnnotationComposer(
            $db: $db,
            $table: $db.medications,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InjectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InjectionsTable,
          InjectionRow,
          $$InjectionsTableFilterComposer,
          $$InjectionsTableOrderingComposer,
          $$InjectionsTableAnnotationComposer,
          $$InjectionsTableCreateCompanionBuilder,
          $$InjectionsTableUpdateCompanionBuilder,
          (InjectionRow, $$InjectionsTableReferences),
          InjectionRow,
          PrefetchHooks Function({
            bool profileId,
            bool siteId,
            bool medicationId,
          })
        > {
  $$InjectionsTableTableManager(_$AppDatabase db, $InjectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InjectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InjectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InjectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<String> siteId = const Value.absent(),
                Value<String?> medicationId = const Value.absent(),
                Value<DateTime> injectedAt = const Value.absent(),
                Value<double?> doseValue = const Value.absent(),
                Value<String?> doseUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<bool> skipped = const Value.absent(),
                Value<String?> skippedReason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InjectionsCompanion(
                id: id,
                profileId: profileId,
                siteId: siteId,
                medicationId: medicationId,
                injectedAt: injectedAt,
                doseValue: doseValue,
                doseUnit: doseUnit,
                notes: notes,
                tags: tags,
                skipped: skipped,
                skippedReason: skippedReason,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required String siteId,
                Value<String?> medicationId = const Value.absent(),
                required DateTime injectedAt,
                Value<double?> doseValue = const Value.absent(),
                Value<String?> doseUnit = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<bool> skipped = const Value.absent(),
                Value<String?> skippedReason = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => InjectionsCompanion.insert(
                id: id,
                profileId: profileId,
                siteId: siteId,
                medicationId: medicationId,
                injectedAt: injectedAt,
                doseValue: doseValue,
                doseUnit: doseUnit,
                notes: notes,
                tags: tags,
                skipped: skipped,
                skippedReason: skippedReason,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InjectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({profileId = false, siteId = false, medicationId = false}) {
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
                        if (profileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.profileId,
                                    referencedTable: $$InjectionsTableReferences
                                        ._profileIdTable(db),
                                    referencedColumn:
                                        $$InjectionsTableReferences
                                            ._profileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (siteId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.siteId,
                                    referencedTable: $$InjectionsTableReferences
                                        ._siteIdTable(db),
                                    referencedColumn:
                                        $$InjectionsTableReferences
                                            ._siteIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (medicationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.medicationId,
                                    referencedTable: $$InjectionsTableReferences
                                        ._medicationIdTable(db),
                                    referencedColumn:
                                        $$InjectionsTableReferences
                                            ._medicationIdTable(db)
                                            .id,
                                  )
                                  as T;
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

typedef $$InjectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InjectionsTable,
      InjectionRow,
      $$InjectionsTableFilterComposer,
      $$InjectionsTableOrderingComposer,
      $$InjectionsTableAnnotationComposer,
      $$InjectionsTableCreateCompanionBuilder,
      $$InjectionsTableUpdateCompanionBuilder,
      (InjectionRow, $$InjectionsTableReferences),
      InjectionRow,
      PrefetchHooks Function({bool profileId, bool siteId, bool medicationId})
    >;
typedef $$GrowthEntriesTableCreateCompanionBuilder =
    GrowthEntriesCompanion Function({
      required String id,
      required String profileId,
      required DateTime measuredAt,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<String?> notes,
      Value<String> source,
      Value<String> tags,
      Value<int> rowid,
    });
typedef $$GrowthEntriesTableUpdateCompanionBuilder =
    GrowthEntriesCompanion Function({
      Value<String> id,
      Value<String> profileId,
      Value<DateTime> measuredAt,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<String?> notes,
      Value<String> source,
      Value<String> tags,
      Value<int> rowid,
    });

final class $$GrowthEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $GrowthEntriesTable, GrowthEntryRow> {
  $$GrowthEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProfilesTable _profileIdTable(_$AppDatabase db) =>
      db.profiles.createAlias('growth_entries__profile_id__profiles__id');

  $$ProfilesTableProcessedTableManager get profileId {
    final $_column = $_itemColumn<String>('profile_id')!;

    final manager = $$ProfilesTableTableManager(
      $_db,
      $_db.profiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_profileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GrowthEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $GrowthEntriesTable> {
  $$GrowthEntriesTableFilterComposer({
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

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  $$ProfilesTableFilterComposer get profileId {
    final $$ProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableFilterComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $GrowthEntriesTable> {
  $$GrowthEntriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProfilesTableOrderingComposer get profileId {
    final $$ProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrowthEntriesTable> {
  $$GrowthEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  $$ProfilesTableAnnotationComposer get profileId {
    final $$ProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.profileId,
      referencedTable: $db.profiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.profiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GrowthEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrowthEntriesTable,
          GrowthEntryRow,
          $$GrowthEntriesTableFilterComposer,
          $$GrowthEntriesTableOrderingComposer,
          $$GrowthEntriesTableAnnotationComposer,
          $$GrowthEntriesTableCreateCompanionBuilder,
          $$GrowthEntriesTableUpdateCompanionBuilder,
          (GrowthEntryRow, $$GrowthEntriesTableReferences),
          GrowthEntryRow,
          PrefetchHooks Function({bool profileId})
        > {
  $$GrowthEntriesTableTableManager(_$AppDatabase db, $GrowthEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrowthEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrowthEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrowthEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> profileId = const Value.absent(),
                Value<DateTime> measuredAt = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrowthEntriesCompanion(
                id: id,
                profileId: profileId,
                measuredAt: measuredAt,
                heightCm: heightCm,
                weightKg: weightKg,
                notes: notes,
                source: source,
                tags: tags,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String profileId,
                required DateTime measuredAt,
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrowthEntriesCompanion.insert(
                id: id,
                profileId: profileId,
                measuredAt: measuredAt,
                heightCm: heightCm,
                weightKg: weightKg,
                notes: notes,
                source: source,
                tags: tags,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GrowthEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({profileId = false}) {
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
                    if (profileId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.profileId,
                                referencedTable: $$GrowthEntriesTableReferences
                                    ._profileIdTable(db),
                                referencedColumn: $$GrowthEntriesTableReferences
                                    ._profileIdTable(db)
                                    .id,
                              )
                              as T;
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

typedef $$GrowthEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrowthEntriesTable,
      GrowthEntryRow,
      $$GrowthEntriesTableFilterComposer,
      $$GrowthEntriesTableOrderingComposer,
      $$GrowthEntriesTableAnnotationComposer,
      $$GrowthEntriesTableCreateCompanionBuilder,
      $$GrowthEntriesTableUpdateCompanionBuilder,
      (GrowthEntryRow, $$GrowthEntriesTableReferences),
      GrowthEntryRow,
      PrefetchHooks Function({bool profileId})
    >;
typedef $$AppMetasTableCreateCompanionBuilder =
    AppMetasCompanion Function({
      Value<String> id,
      Value<String?> activeProfileId,
      Value<bool> appLockEnabled,
      Value<DateTime?> lastBackupAt,
      Value<String> themeMode,
      Value<bool> onboardingComplete,
      Value<int> rowid,
    });
typedef $$AppMetasTableUpdateCompanionBuilder =
    AppMetasCompanion Function({
      Value<String> id,
      Value<String?> activeProfileId,
      Value<bool> appLockEnabled,
      Value<DateTime?> lastBackupAt,
      Value<String> themeMode,
      Value<bool> onboardingComplete,
      Value<int> rowid,
    });

class $$AppMetasTableFilterComposer
    extends Composer<_$AppDatabase, $AppMetasTable> {
  $$AppMetasTableFilterComposer({
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

  ColumnFilters<String> get activeProfileId => $composableBuilder(
    column: $table.activeProfileId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get appLockEnabled => $composableBuilder(
    column: $table.appLockEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppMetasTableOrderingComposer
    extends Composer<_$AppDatabase, $AppMetasTable> {
  $$AppMetasTableOrderingComposer({
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

  ColumnOrderings<String> get activeProfileId => $composableBuilder(
    column: $table.activeProfileId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get appLockEnabled => $composableBuilder(
    column: $table.appLockEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppMetasTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppMetasTable> {
  $$AppMetasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get activeProfileId => $composableBuilder(
    column: $table.activeProfileId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get appLockEnabled => $composableBuilder(
    column: $table.appLockEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );
}

class $$AppMetasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppMetasTable,
          AppMetaRow,
          $$AppMetasTableFilterComposer,
          $$AppMetasTableOrderingComposer,
          $$AppMetasTableAnnotationComposer,
          $$AppMetasTableCreateCompanionBuilder,
          $$AppMetasTableUpdateCompanionBuilder,
          (
            AppMetaRow,
            BaseReferences<_$AppDatabase, $AppMetasTable, AppMetaRow>,
          ),
          AppMetaRow,
          PrefetchHooks Function()
        > {
  $$AppMetasTableTableManager(_$AppDatabase db, $AppMetasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppMetasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppMetasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppMetasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> activeProfileId = const Value.absent(),
                Value<bool> appLockEnabled = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetasCompanion(
                id: id,
                activeProfileId: activeProfileId,
                appLockEnabled: appLockEnabled,
                lastBackupAt: lastBackupAt,
                themeMode: themeMode,
                onboardingComplete: onboardingComplete,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> activeProfileId = const Value.absent(),
                Value<bool> appLockEnabled = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppMetasCompanion.insert(
                id: id,
                activeProfileId: activeProfileId,
                appLockEnabled: appLockEnabled,
                lastBackupAt: lastBackupAt,
                themeMode: themeMode,
                onboardingComplete: onboardingComplete,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppMetasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppMetasTable,
      AppMetaRow,
      $$AppMetasTableFilterComposer,
      $$AppMetasTableOrderingComposer,
      $$AppMetasTableAnnotationComposer,
      $$AppMetasTableCreateCompanionBuilder,
      $$AppMetasTableUpdateCompanionBuilder,
      (AppMetaRow, BaseReferences<_$AppDatabase, $AppMetasTable, AppMetaRow>),
      AppMetaRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db, _db.medications);
  $$DoseChangesTableTableManager get doseChanges =>
      $$DoseChangesTableTableManager(_db, _db.doseChanges);
  $$InjectionSitesTableTableManager get injectionSites =>
      $$InjectionSitesTableTableManager(_db, _db.injectionSites);
  $$InjectionsTableTableManager get injections =>
      $$InjectionsTableTableManager(_db, _db.injections);
  $$GrowthEntriesTableTableManager get growthEntries =>
      $$GrowthEntriesTableTableManager(_db, _db.growthEntries);
  $$AppMetasTableTableManager get appMetas =>
      $$AppMetasTableTableManager(_db, _db.appMetas);
}
