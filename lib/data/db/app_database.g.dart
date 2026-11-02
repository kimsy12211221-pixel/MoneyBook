// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $AppSettingsTableTable extends AppSettingsTable
    with TableInfo<$AppSettingsTableTable, AppSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
      'key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
      'value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [key, value, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AppSettingsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
          _keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingsTableData(
      key: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AppSettingsTableTable createAlias(String alias) {
    return $AppSettingsTableTable(attachedDatabase, alias);
  }
}

class AppSettingsTableData extends DataClass
    implements Insertable<AppSettingsTableData> {
  final String key;
  final String value;
  final DateTime updatedAt;
  const AppSettingsTableData(
      {required this.key, required this.value, required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AppSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsTableCompanion(
      key: Value(key),
      value: Value(value),
      updatedAt: Value(updatedAt),
    );
  }

  factory AppSettingsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingsTableData(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AppSettingsTableData copyWith(
          {String? key, String? value, DateTime? updatedAt}) =>
      AppSettingsTableData(
        key: key ?? this.key,
        value: value ?? this.value,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AppSettingsTableData copyWithCompanion(AppSettingsTableCompanion data) {
    return AppSettingsTableData(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsTableData(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingsTableData &&
          other.key == this.key &&
          other.value == this.value &&
          other.updatedAt == this.updatedAt);
}

class AppSettingsTableCompanion extends UpdateCompanion<AppSettingsTableData> {
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const AppSettingsTableCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsTableCompanion.insert({
    required String key,
    required String value,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : key = Value(key),
        value = Value(value),
        updatedAt = Value(updatedAt);
  static Insertable<AppSettingsTableData> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsTableCompanion copyWith(
      {Value<String>? key,
      Value<String>? value,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return AppSettingsTableCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
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
    return (StringBuffer('AppSettingsTableCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnnualSpecialBudgetsTableTable extends AnnualSpecialBudgetsTable
    with
        TableInfo<$AnnualSpecialBudgetsTableTable,
            AnnualSpecialBudgetsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnnualSpecialBudgetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _budgetAmountMeta =
      const VerificationMeta('budgetAmount');
  @override
  late final GeneratedColumn<int> budgetAmount = GeneratedColumn<int>(
      'budget_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('KRW'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, year, budgetAmount, currencyCode, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'annual_special_budgets_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<AnnualSpecialBudgetsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('budget_amount')) {
      context.handle(
          _budgetAmountMeta,
          budgetAmount.isAcceptableOrUnknown(
              data['budget_amount']!, _budgetAmountMeta));
    } else if (isInserting) {
      context.missing(_budgetAmountMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {year},
      ];
  @override
  AnnualSpecialBudgetsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnnualSpecialBudgetsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      budgetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}budget_amount'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AnnualSpecialBudgetsTableTable createAlias(String alias) {
    return $AnnualSpecialBudgetsTableTable(attachedDatabase, alias);
  }
}

class AnnualSpecialBudgetsTableData extends DataClass
    implements Insertable<AnnualSpecialBudgetsTableData> {
  final int id;
  final int year;
  final int budgetAmount;
  final String currencyCode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AnnualSpecialBudgetsTableData(
      {required this.id,
      required this.year,
      required this.budgetAmount,
      required this.currencyCode,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year'] = Variable<int>(year);
    map['budget_amount'] = Variable<int>(budgetAmount);
    map['currency_code'] = Variable<String>(currencyCode);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AnnualSpecialBudgetsTableCompanion toCompanion(bool nullToAbsent) {
    return AnnualSpecialBudgetsTableCompanion(
      id: Value(id),
      year: Value(year),
      budgetAmount: Value(budgetAmount),
      currencyCode: Value(currencyCode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AnnualSpecialBudgetsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnnualSpecialBudgetsTableData(
      id: serializer.fromJson<int>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      budgetAmount: serializer.fromJson<int>(json['budgetAmount']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'year': serializer.toJson<int>(year),
      'budgetAmount': serializer.toJson<int>(budgetAmount),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AnnualSpecialBudgetsTableData copyWith(
          {int? id,
          int? year,
          int? budgetAmount,
          String? currencyCode,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      AnnualSpecialBudgetsTableData(
        id: id ?? this.id,
        year: year ?? this.year,
        budgetAmount: budgetAmount ?? this.budgetAmount,
        currencyCode: currencyCode ?? this.currencyCode,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  AnnualSpecialBudgetsTableData copyWithCompanion(
      AnnualSpecialBudgetsTableCompanion data) {
    return AnnualSpecialBudgetsTableData(
      id: data.id.present ? data.id.value : this.id,
      year: data.year.present ? data.year.value : this.year,
      budgetAmount: data.budgetAmount.present
          ? data.budgetAmount.value
          : this.budgetAmount,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnnualSpecialBudgetsTableData(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, year, budgetAmount, currencyCode, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnnualSpecialBudgetsTableData &&
          other.id == this.id &&
          other.year == this.year &&
          other.budgetAmount == this.budgetAmount &&
          other.currencyCode == this.currencyCode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AnnualSpecialBudgetsTableCompanion
    extends UpdateCompanion<AnnualSpecialBudgetsTableData> {
  final Value<int> id;
  final Value<int> year;
  final Value<int> budgetAmount;
  final Value<String> currencyCode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AnnualSpecialBudgetsTableCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.budgetAmount = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AnnualSpecialBudgetsTableCompanion.insert({
    this.id = const Value.absent(),
    required int year,
    required int budgetAmount,
    this.currencyCode = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : year = Value(year),
        budgetAmount = Value(budgetAmount),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<AnnualSpecialBudgetsTableData> custom({
    Expression<int>? id,
    Expression<int>? year,
    Expression<int>? budgetAmount,
    Expression<String>? currencyCode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (budgetAmount != null) 'budget_amount': budgetAmount,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AnnualSpecialBudgetsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? year,
      Value<int>? budgetAmount,
      Value<String>? currencyCode,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return AnnualSpecialBudgetsTableCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      currencyCode: currencyCode ?? this.currencyCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (budgetAmount.present) {
      map['budget_amount'] = Variable<int>(budgetAmount.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnnualSpecialBudgetsTableCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BudgetsTableTable extends BudgetsTable
    with TableInfo<$BudgetsTableTable, BudgetsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _monthlyBudgetMeta =
      const VerificationMeta('monthlyBudget');
  @override
  late final GeneratedColumn<int> monthlyBudget = GeneratedColumn<int>(
      'monthly_budget', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currencyCodeMeta =
      const VerificationMeta('currencyCode');
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
      'currency_code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('KRW'));
  static const VerificationMeta _effectiveMonthMeta =
      const VerificationMeta('effectiveMonth');
  @override
  late final GeneratedColumn<String> effectiveMonth = GeneratedColumn<String>(
      'effective_month', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, monthlyBudget, currencyCode, effectiveMonth, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budgets_table';
  @override
  VerificationContext validateIntegrity(Insertable<BudgetsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monthly_budget')) {
      context.handle(
          _monthlyBudgetMeta,
          monthlyBudget.isAcceptableOrUnknown(
              data['monthly_budget']!, _monthlyBudgetMeta));
    } else if (isInserting) {
      context.missing(_monthlyBudgetMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
          _currencyCodeMeta,
          currencyCode.isAcceptableOrUnknown(
              data['currency_code']!, _currencyCodeMeta));
    }
    if (data.containsKey('effective_month')) {
      context.handle(
          _effectiveMonthMeta,
          effectiveMonth.isAcceptableOrUnknown(
              data['effective_month']!, _effectiveMonthMeta));
    } else if (isInserting) {
      context.missing(_effectiveMonthMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {effectiveMonth},
      ];
  @override
  BudgetsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      monthlyBudget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}monthly_budget'])!,
      currencyCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}currency_code'])!,
      effectiveMonth: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}effective_month'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $BudgetsTableTable createAlias(String alias) {
    return $BudgetsTableTable(attachedDatabase, alias);
  }
}

class BudgetsTableData extends DataClass
    implements Insertable<BudgetsTableData> {
  final int id;
  final int monthlyBudget;
  final String currencyCode;
  final String effectiveMonth;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BudgetsTableData(
      {required this.id,
      required this.monthlyBudget,
      required this.currencyCode,
      required this.effectiveMonth,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monthly_budget'] = Variable<int>(monthlyBudget);
    map['currency_code'] = Variable<String>(currencyCode);
    map['effective_month'] = Variable<String>(effectiveMonth);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BudgetsTableCompanion toCompanion(bool nullToAbsent) {
    return BudgetsTableCompanion(
      id: Value(id),
      monthlyBudget: Value(monthlyBudget),
      currencyCode: Value(currencyCode),
      effectiveMonth: Value(effectiveMonth),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BudgetsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetsTableData(
      id: serializer.fromJson<int>(json['id']),
      monthlyBudget: serializer.fromJson<int>(json['monthlyBudget']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      effectiveMonth: serializer.fromJson<String>(json['effectiveMonth']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monthlyBudget': serializer.toJson<int>(monthlyBudget),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'effectiveMonth': serializer.toJson<String>(effectiveMonth),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BudgetsTableData copyWith(
          {int? id,
          int? monthlyBudget,
          String? currencyCode,
          String? effectiveMonth,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      BudgetsTableData(
        id: id ?? this.id,
        monthlyBudget: monthlyBudget ?? this.monthlyBudget,
        currencyCode: currencyCode ?? this.currencyCode,
        effectiveMonth: effectiveMonth ?? this.effectiveMonth,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  BudgetsTableData copyWithCompanion(BudgetsTableCompanion data) {
    return BudgetsTableData(
      id: data.id.present ? data.id.value : this.id,
      monthlyBudget: data.monthlyBudget.present
          ? data.monthlyBudget.value
          : this.monthlyBudget,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      effectiveMonth: data.effectiveMonth.present
          ? data.effectiveMonth.value
          : this.effectiveMonth,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsTableData(')
          ..write('id: $id, ')
          ..write('monthlyBudget: $monthlyBudget, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('effectiveMonth: $effectiveMonth, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, monthlyBudget, currencyCode, effectiveMonth, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetsTableData &&
          other.id == this.id &&
          other.monthlyBudget == this.monthlyBudget &&
          other.currencyCode == this.currencyCode &&
          other.effectiveMonth == this.effectiveMonth &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BudgetsTableCompanion extends UpdateCompanion<BudgetsTableData> {
  final Value<int> id;
  final Value<int> monthlyBudget;
  final Value<String> currencyCode;
  final Value<String> effectiveMonth;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BudgetsTableCompanion({
    this.id = const Value.absent(),
    this.monthlyBudget = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.effectiveMonth = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BudgetsTableCompanion.insert({
    this.id = const Value.absent(),
    required int monthlyBudget,
    this.currencyCode = const Value.absent(),
    required String effectiveMonth,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : monthlyBudget = Value(monthlyBudget),
        effectiveMonth = Value(effectiveMonth),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<BudgetsTableData> custom({
    Expression<int>? id,
    Expression<int>? monthlyBudget,
    Expression<String>? currencyCode,
    Expression<String>? effectiveMonth,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthlyBudget != null) 'monthly_budget': monthlyBudget,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (effectiveMonth != null) 'effective_month': effectiveMonth,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BudgetsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? monthlyBudget,
      Value<String>? currencyCode,
      Value<String>? effectiveMonth,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return BudgetsTableCompanion(
      id: id ?? this.id,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      currencyCode: currencyCode ?? this.currencyCode,
      effectiveMonth: effectiveMonth ?? this.effectiveMonth,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monthlyBudget.present) {
      map['monthly_budget'] = Variable<int>(monthlyBudget.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (effectiveMonth.present) {
      map['effective_month'] = Variable<String>(effectiveMonth.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetsTableCompanion(')
          ..write('id: $id, ')
          ..write('monthlyBudget: $monthlyBudget, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('effectiveMonth: $effectiveMonth, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTableTable extends CategoriesTable
    with TableInfo<$CategoriesTableTable, CategoriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('circle'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _colorTokenMeta =
      const VerificationMeta('colorToken');
  @override
  late final GeneratedColumn<String> colorToken = GeneratedColumn<String>(
      'color_token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sortOrderMeta =
      const VerificationMeta('sortOrder');
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
      'sort_order', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        icon,
        description,
        colorToken,
        sortOrder,
        isActive,
        isDefault,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoriesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('color_token')) {
      context.handle(
          _colorTokenMeta,
          colorToken.isAcceptableOrUnknown(
              data['color_token']!, _colorTokenMeta));
    }
    if (data.containsKey('sort_order')) {
      context.handle(_sortOrderMeta,
          sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta));
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {name},
      ];
  @override
  CategoriesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoriesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      colorToken: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color_token']),
      sortOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sort_order'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CategoriesTableTable createAlias(String alias) {
    return $CategoriesTableTable(attachedDatabase, alias);
  }
}

class CategoriesTableData extends DataClass
    implements Insertable<CategoriesTableData> {
  final int id;
  final String name;
  final String icon;
  final String? description;
  final String? colorToken;
  final int sortOrder;
  final bool isActive;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CategoriesTableData(
      {required this.id,
      required this.name,
      required this.icon,
      this.description,
      this.colorToken,
      required this.sortOrder,
      required this.isActive,
      required this.isDefault,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || colorToken != null) {
      map['color_token'] = Variable<String>(colorToken);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoriesTableCompanion toCompanion(bool nullToAbsent) {
    return CategoriesTableCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      colorToken: colorToken == null && nullToAbsent
          ? const Value.absent()
          : Value(colorToken),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoriesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      description: serializer.fromJson<String?>(json['description']),
      colorToken: serializer.fromJson<String?>(json['colorToken']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'description': serializer.toJson<String?>(description),
      'colorToken': serializer.toJson<String?>(colorToken),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoriesTableData copyWith(
          {int? id,
          String? name,
          String? icon,
          Value<String?> description = const Value.absent(),
          Value<String?> colorToken = const Value.absent(),
          int? sortOrder,
          bool? isActive,
          bool? isDefault,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CategoriesTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        description: description.present ? description.value : this.description,
        colorToken: colorToken.present ? colorToken.value : this.colorToken,
        sortOrder: sortOrder ?? this.sortOrder,
        isActive: isActive ?? this.isActive,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CategoriesTableData copyWithCompanion(CategoriesTableCompanion data) {
    return CategoriesTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      description:
          data.description.present ? data.description.value : this.description,
      colorToken:
          data.colorToken.present ? data.colorToken.value : this.colorToken,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('colorToken: $colorToken, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon, description, colorToken,
      sortOrder, isActive, isDefault, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.description == this.description &&
          other.colorToken == this.colorToken &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoriesTableCompanion extends UpdateCompanion<CategoriesTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> icon;
  final Value<String?> description;
  final Value<String?> colorToken;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CategoriesTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.description = const Value.absent(),
    this.colorToken = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoriesTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.icon = const Value.absent(),
    this.description = const Value.absent(),
    this.colorToken = const Value.absent(),
    required int sortOrder,
    this.isActive = const Value.absent(),
    this.isDefault = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : name = Value(name),
        sortOrder = Value(sortOrder),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CategoriesTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? description,
    Expression<String>? colorToken,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (description != null) 'description': description,
      if (colorToken != null) 'color_token': colorToken,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoriesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? icon,
      Value<String?>? description,
      Value<String?>? colorToken,
      Value<int>? sortOrder,
      Value<bool>? isActive,
      Value<bool>? isDefault,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CategoriesTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      colorToken: colorToken ?? this.colorToken,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (colorToken.present) {
      map['color_token'] = Variable<String>(colorToken.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('colorToken: $colorToken, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SavingPlansTableTable extends SavingPlansTable
    with TableInfo<$SavingPlansTableTable, SavingPlansTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavingPlansTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _yearMonthMeta =
      const VerificationMeta('yearMonth');
  @override
  late final GeneratedColumn<String> yearMonth = GeneratedColumn<String>(
      'year_month', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _salaryAmountMeta =
      const VerificationMeta('salaryAmount');
  @override
  late final GeneratedColumn<int> salaryAmount = GeneratedColumn<int>(
      'salary_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _etfLabelMeta =
      const VerificationMeta('etfLabel');
  @override
  late final GeneratedColumn<String> etfLabel = GeneratedColumn<String>(
      'etf_label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('신한투자 / ETF투자'));
  static const VerificationMeta _etfTargetMeta =
      const VerificationMeta('etfTarget');
  @override
  late final GeneratedColumn<int> etfTarget = GeneratedColumn<int>(
      'etf_target', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _annualSpecialLabelMeta =
      const VerificationMeta('annualSpecialLabel');
  @override
  late final GeneratedColumn<String> annualSpecialLabel =
      GeneratedColumn<String>('annual_special_label', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('토스나눠모으기 / ANNUAL SPECIAL'));
  static const VerificationMeta _annualSpecialTargetMeta =
      const VerificationMeta('annualSpecialTarget');
  @override
  late final GeneratedColumn<int> annualSpecialTarget = GeneratedColumn<int>(
      'annual_special_target', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _livingLabelMeta =
      const VerificationMeta('livingLabel');
  @override
  late final GeneratedColumn<String> livingLabel = GeneratedColumn<String>(
      'living_label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('케이뱅크 / 생활비이체'));
  static const VerificationMeta _livingBudgetTargetMeta =
      const VerificationMeta('livingBudgetTarget');
  @override
  late final GeneratedColumn<int> livingBudgetTarget = GeneratedColumn<int>(
      'living_budget_target', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _housingLabelMeta =
      const VerificationMeta('housingLabel');
  @override
  late final GeneratedColumn<String> housingLabel = GeneratedColumn<String>(
      'housing_label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('토스나눠모으기 / 비상금'));
  static const VerificationMeta _housingTargetMeta =
      const VerificationMeta('housingTarget');
  @override
  late final GeneratedColumn<int> housingTarget = GeneratedColumn<int>(
      'housing_target', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _fixedCostLabelMeta =
      const VerificationMeta('fixedCostLabel');
  @override
  late final GeneratedColumn<String> fixedCostLabel = GeneratedColumn<String>(
      'fixed_cost_label', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('토스통장 / 고정비확보'));
  static const VerificationMeta _fixedCostTargetMeta =
      const VerificationMeta('fixedCostTarget');
  @override
  late final GeneratedColumn<int> fixedCostTarget = GeneratedColumn<int>(
      'fixed_cost_target', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _etfDoneAtMeta =
      const VerificationMeta('etfDoneAt');
  @override
  late final GeneratedColumn<DateTime> etfDoneAt = GeneratedColumn<DateTime>(
      'etf_done_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _annualSpecialDoneAtMeta =
      const VerificationMeta('annualSpecialDoneAt');
  @override
  late final GeneratedColumn<DateTime> annualSpecialDoneAt =
      GeneratedColumn<DateTime>('annual_special_done_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _livingDoneAtMeta =
      const VerificationMeta('livingDoneAt');
  @override
  late final GeneratedColumn<DateTime> livingDoneAt = GeneratedColumn<DateTime>(
      'living_done_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _housingDoneAtMeta =
      const VerificationMeta('housingDoneAt');
  @override
  late final GeneratedColumn<DateTime> housingDoneAt =
      GeneratedColumn<DateTime>('housing_done_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _fixedCostDoneAtMeta =
      const VerificationMeta('fixedCostDoneAt');
  @override
  late final GeneratedColumn<DateTime> fixedCostDoneAt =
      GeneratedColumn<DateTime>('fixed_cost_done_at', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _sweepAmountMeta =
      const VerificationMeta('sweepAmount');
  @override
  late final GeneratedColumn<int> sweepAmount = GeneratedColumn<int>(
      'sweep_amount', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sweptAtMeta =
      const VerificationMeta('sweptAt');
  @override
  late final GeneratedColumn<DateTime> sweptAt = GeneratedColumn<DateTime>(
      'swept_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        yearMonth,
        salaryAmount,
        etfLabel,
        etfTarget,
        annualSpecialLabel,
        annualSpecialTarget,
        livingLabel,
        livingBudgetTarget,
        housingLabel,
        housingTarget,
        fixedCostLabel,
        fixedCostTarget,
        etfDoneAt,
        annualSpecialDoneAt,
        livingDoneAt,
        housingDoneAt,
        fixedCostDoneAt,
        sweepAmount,
        sweptAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saving_plans_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<SavingPlansTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('year_month')) {
      context.handle(_yearMonthMeta,
          yearMonth.isAcceptableOrUnknown(data['year_month']!, _yearMonthMeta));
    } else if (isInserting) {
      context.missing(_yearMonthMeta);
    }
    if (data.containsKey('salary_amount')) {
      context.handle(
          _salaryAmountMeta,
          salaryAmount.isAcceptableOrUnknown(
              data['salary_amount']!, _salaryAmountMeta));
    } else if (isInserting) {
      context.missing(_salaryAmountMeta);
    }
    if (data.containsKey('etf_label')) {
      context.handle(_etfLabelMeta,
          etfLabel.isAcceptableOrUnknown(data['etf_label']!, _etfLabelMeta));
    }
    if (data.containsKey('etf_target')) {
      context.handle(_etfTargetMeta,
          etfTarget.isAcceptableOrUnknown(data['etf_target']!, _etfTargetMeta));
    } else if (isInserting) {
      context.missing(_etfTargetMeta);
    }
    if (data.containsKey('annual_special_label')) {
      context.handle(
          _annualSpecialLabelMeta,
          annualSpecialLabel.isAcceptableOrUnknown(
              data['annual_special_label']!, _annualSpecialLabelMeta));
    }
    if (data.containsKey('annual_special_target')) {
      context.handle(
          _annualSpecialTargetMeta,
          annualSpecialTarget.isAcceptableOrUnknown(
              data['annual_special_target']!, _annualSpecialTargetMeta));
    } else if (isInserting) {
      context.missing(_annualSpecialTargetMeta);
    }
    if (data.containsKey('living_label')) {
      context.handle(
          _livingLabelMeta,
          livingLabel.isAcceptableOrUnknown(
              data['living_label']!, _livingLabelMeta));
    }
    if (data.containsKey('living_budget_target')) {
      context.handle(
          _livingBudgetTargetMeta,
          livingBudgetTarget.isAcceptableOrUnknown(
              data['living_budget_target']!, _livingBudgetTargetMeta));
    } else if (isInserting) {
      context.missing(_livingBudgetTargetMeta);
    }
    if (data.containsKey('housing_label')) {
      context.handle(
          _housingLabelMeta,
          housingLabel.isAcceptableOrUnknown(
              data['housing_label']!, _housingLabelMeta));
    }
    if (data.containsKey('housing_target')) {
      context.handle(
          _housingTargetMeta,
          housingTarget.isAcceptableOrUnknown(
              data['housing_target']!, _housingTargetMeta));
    } else if (isInserting) {
      context.missing(_housingTargetMeta);
    }
    if (data.containsKey('fixed_cost_label')) {
      context.handle(
          _fixedCostLabelMeta,
          fixedCostLabel.isAcceptableOrUnknown(
              data['fixed_cost_label']!, _fixedCostLabelMeta));
    }
    if (data.containsKey('fixed_cost_target')) {
      context.handle(
          _fixedCostTargetMeta,
          fixedCostTarget.isAcceptableOrUnknown(
              data['fixed_cost_target']!, _fixedCostTargetMeta));
    } else if (isInserting) {
      context.missing(_fixedCostTargetMeta);
    }
    if (data.containsKey('etf_done_at')) {
      context.handle(
          _etfDoneAtMeta,
          etfDoneAt.isAcceptableOrUnknown(
              data['etf_done_at']!, _etfDoneAtMeta));
    }
    if (data.containsKey('annual_special_done_at')) {
      context.handle(
          _annualSpecialDoneAtMeta,
          annualSpecialDoneAt.isAcceptableOrUnknown(
              data['annual_special_done_at']!, _annualSpecialDoneAtMeta));
    }
    if (data.containsKey('living_done_at')) {
      context.handle(
          _livingDoneAtMeta,
          livingDoneAt.isAcceptableOrUnknown(
              data['living_done_at']!, _livingDoneAtMeta));
    }
    if (data.containsKey('housing_done_at')) {
      context.handle(
          _housingDoneAtMeta,
          housingDoneAt.isAcceptableOrUnknown(
              data['housing_done_at']!, _housingDoneAtMeta));
    }
    if (data.containsKey('fixed_cost_done_at')) {
      context.handle(
          _fixedCostDoneAtMeta,
          fixedCostDoneAt.isAcceptableOrUnknown(
              data['fixed_cost_done_at']!, _fixedCostDoneAtMeta));
    }
    if (data.containsKey('sweep_amount')) {
      context.handle(
          _sweepAmountMeta,
          sweepAmount.isAcceptableOrUnknown(
              data['sweep_amount']!, _sweepAmountMeta));
    }
    if (data.containsKey('swept_at')) {
      context.handle(_sweptAtMeta,
          sweptAt.isAcceptableOrUnknown(data['swept_at']!, _sweptAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {yearMonth},
      ];
  @override
  SavingPlansTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavingPlansTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      yearMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}year_month'])!,
      salaryAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}salary_amount'])!,
      etfLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}etf_label'])!,
      etfTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}etf_target'])!,
      annualSpecialLabel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}annual_special_label'])!,
      annualSpecialTarget: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}annual_special_target'])!,
      livingLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}living_label'])!,
      livingBudgetTarget: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}living_budget_target'])!,
      housingLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}housing_label'])!,
      housingTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}housing_target'])!,
      fixedCostLabel: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}fixed_cost_label'])!,
      fixedCostTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}fixed_cost_target'])!,
      etfDoneAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}etf_done_at']),
      annualSpecialDoneAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}annual_special_done_at']),
      livingDoneAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}living_done_at']),
      housingDoneAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}housing_done_at']),
      fixedCostDoneAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fixed_cost_done_at']),
      sweepAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sweep_amount']),
      sweptAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}swept_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $SavingPlansTableTable createAlias(String alias) {
    return $SavingPlansTableTable(attachedDatabase, alias);
  }
}

class SavingPlansTableData extends DataClass
    implements Insertable<SavingPlansTableData> {
  final int id;
  final String yearMonth;
  final int salaryAmount;
  final String etfLabel;
  final int etfTarget;
  final String annualSpecialLabel;
  final int annualSpecialTarget;
  final String livingLabel;
  final int livingBudgetTarget;
  final String housingLabel;
  final int housingTarget;
  final String fixedCostLabel;
  final int fixedCostTarget;
  final DateTime? etfDoneAt;
  final DateTime? annualSpecialDoneAt;
  final DateTime? livingDoneAt;
  final DateTime? housingDoneAt;
  final DateTime? fixedCostDoneAt;
  final int? sweepAmount;
  final DateTime? sweptAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SavingPlansTableData(
      {required this.id,
      required this.yearMonth,
      required this.salaryAmount,
      required this.etfLabel,
      required this.etfTarget,
      required this.annualSpecialLabel,
      required this.annualSpecialTarget,
      required this.livingLabel,
      required this.livingBudgetTarget,
      required this.housingLabel,
      required this.housingTarget,
      required this.fixedCostLabel,
      required this.fixedCostTarget,
      this.etfDoneAt,
      this.annualSpecialDoneAt,
      this.livingDoneAt,
      this.housingDoneAt,
      this.fixedCostDoneAt,
      this.sweepAmount,
      this.sweptAt,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['year_month'] = Variable<String>(yearMonth);
    map['salary_amount'] = Variable<int>(salaryAmount);
    map['etf_label'] = Variable<String>(etfLabel);
    map['etf_target'] = Variable<int>(etfTarget);
    map['annual_special_label'] = Variable<String>(annualSpecialLabel);
    map['annual_special_target'] = Variable<int>(annualSpecialTarget);
    map['living_label'] = Variable<String>(livingLabel);
    map['living_budget_target'] = Variable<int>(livingBudgetTarget);
    map['housing_label'] = Variable<String>(housingLabel);
    map['housing_target'] = Variable<int>(housingTarget);
    map['fixed_cost_label'] = Variable<String>(fixedCostLabel);
    map['fixed_cost_target'] = Variable<int>(fixedCostTarget);
    if (!nullToAbsent || etfDoneAt != null) {
      map['etf_done_at'] = Variable<DateTime>(etfDoneAt);
    }
    if (!nullToAbsent || annualSpecialDoneAt != null) {
      map['annual_special_done_at'] = Variable<DateTime>(annualSpecialDoneAt);
    }
    if (!nullToAbsent || livingDoneAt != null) {
      map['living_done_at'] = Variable<DateTime>(livingDoneAt);
    }
    if (!nullToAbsent || housingDoneAt != null) {
      map['housing_done_at'] = Variable<DateTime>(housingDoneAt);
    }
    if (!nullToAbsent || fixedCostDoneAt != null) {
      map['fixed_cost_done_at'] = Variable<DateTime>(fixedCostDoneAt);
    }
    if (!nullToAbsent || sweepAmount != null) {
      map['sweep_amount'] = Variable<int>(sweepAmount);
    }
    if (!nullToAbsent || sweptAt != null) {
      map['swept_at'] = Variable<DateTime>(sweptAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SavingPlansTableCompanion toCompanion(bool nullToAbsent) {
    return SavingPlansTableCompanion(
      id: Value(id),
      yearMonth: Value(yearMonth),
      salaryAmount: Value(salaryAmount),
      etfLabel: Value(etfLabel),
      etfTarget: Value(etfTarget),
      annualSpecialLabel: Value(annualSpecialLabel),
      annualSpecialTarget: Value(annualSpecialTarget),
      livingLabel: Value(livingLabel),
      livingBudgetTarget: Value(livingBudgetTarget),
      housingLabel: Value(housingLabel),
      housingTarget: Value(housingTarget),
      fixedCostLabel: Value(fixedCostLabel),
      fixedCostTarget: Value(fixedCostTarget),
      etfDoneAt: etfDoneAt == null && nullToAbsent
          ? const Value.absent()
          : Value(etfDoneAt),
      annualSpecialDoneAt: annualSpecialDoneAt == null && nullToAbsent
          ? const Value.absent()
          : Value(annualSpecialDoneAt),
      livingDoneAt: livingDoneAt == null && nullToAbsent
          ? const Value.absent()
          : Value(livingDoneAt),
      housingDoneAt: housingDoneAt == null && nullToAbsent
          ? const Value.absent()
          : Value(housingDoneAt),
      fixedCostDoneAt: fixedCostDoneAt == null && nullToAbsent
          ? const Value.absent()
          : Value(fixedCostDoneAt),
      sweepAmount: sweepAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(sweepAmount),
      sweptAt: sweptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sweptAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SavingPlansTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavingPlansTableData(
      id: serializer.fromJson<int>(json['id']),
      yearMonth: serializer.fromJson<String>(json['yearMonth']),
      salaryAmount: serializer.fromJson<int>(json['salaryAmount']),
      etfLabel: serializer.fromJson<String>(json['etfLabel']),
      etfTarget: serializer.fromJson<int>(json['etfTarget']),
      annualSpecialLabel:
          serializer.fromJson<String>(json['annualSpecialLabel']),
      annualSpecialTarget:
          serializer.fromJson<int>(json['annualSpecialTarget']),
      livingLabel: serializer.fromJson<String>(json['livingLabel']),
      livingBudgetTarget: serializer.fromJson<int>(json['livingBudgetTarget']),
      housingLabel: serializer.fromJson<String>(json['housingLabel']),
      housingTarget: serializer.fromJson<int>(json['housingTarget']),
      fixedCostLabel: serializer.fromJson<String>(json['fixedCostLabel']),
      fixedCostTarget: serializer.fromJson<int>(json['fixedCostTarget']),
      etfDoneAt: serializer.fromJson<DateTime?>(json['etfDoneAt']),
      annualSpecialDoneAt:
          serializer.fromJson<DateTime?>(json['annualSpecialDoneAt']),
      livingDoneAt: serializer.fromJson<DateTime?>(json['livingDoneAt']),
      housingDoneAt: serializer.fromJson<DateTime?>(json['housingDoneAt']),
      fixedCostDoneAt: serializer.fromJson<DateTime?>(json['fixedCostDoneAt']),
      sweepAmount: serializer.fromJson<int?>(json['sweepAmount']),
      sweptAt: serializer.fromJson<DateTime?>(json['sweptAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'yearMonth': serializer.toJson<String>(yearMonth),
      'salaryAmount': serializer.toJson<int>(salaryAmount),
      'etfLabel': serializer.toJson<String>(etfLabel),
      'etfTarget': serializer.toJson<int>(etfTarget),
      'annualSpecialLabel': serializer.toJson<String>(annualSpecialLabel),
      'annualSpecialTarget': serializer.toJson<int>(annualSpecialTarget),
      'livingLabel': serializer.toJson<String>(livingLabel),
      'livingBudgetTarget': serializer.toJson<int>(livingBudgetTarget),
      'housingLabel': serializer.toJson<String>(housingLabel),
      'housingTarget': serializer.toJson<int>(housingTarget),
      'fixedCostLabel': serializer.toJson<String>(fixedCostLabel),
      'fixedCostTarget': serializer.toJson<int>(fixedCostTarget),
      'etfDoneAt': serializer.toJson<DateTime?>(etfDoneAt),
      'annualSpecialDoneAt': serializer.toJson<DateTime?>(annualSpecialDoneAt),
      'livingDoneAt': serializer.toJson<DateTime?>(livingDoneAt),
      'housingDoneAt': serializer.toJson<DateTime?>(housingDoneAt),
      'fixedCostDoneAt': serializer.toJson<DateTime?>(fixedCostDoneAt),
      'sweepAmount': serializer.toJson<int?>(sweepAmount),
      'sweptAt': serializer.toJson<DateTime?>(sweptAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SavingPlansTableData copyWith(
          {int? id,
          String? yearMonth,
          int? salaryAmount,
          String? etfLabel,
          int? etfTarget,
          String? annualSpecialLabel,
          int? annualSpecialTarget,
          String? livingLabel,
          int? livingBudgetTarget,
          String? housingLabel,
          int? housingTarget,
          String? fixedCostLabel,
          int? fixedCostTarget,
          Value<DateTime?> etfDoneAt = const Value.absent(),
          Value<DateTime?> annualSpecialDoneAt = const Value.absent(),
          Value<DateTime?> livingDoneAt = const Value.absent(),
          Value<DateTime?> housingDoneAt = const Value.absent(),
          Value<DateTime?> fixedCostDoneAt = const Value.absent(),
          Value<int?> sweepAmount = const Value.absent(),
          Value<DateTime?> sweptAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      SavingPlansTableData(
        id: id ?? this.id,
        yearMonth: yearMonth ?? this.yearMonth,
        salaryAmount: salaryAmount ?? this.salaryAmount,
        etfLabel: etfLabel ?? this.etfLabel,
        etfTarget: etfTarget ?? this.etfTarget,
        annualSpecialLabel: annualSpecialLabel ?? this.annualSpecialLabel,
        annualSpecialTarget: annualSpecialTarget ?? this.annualSpecialTarget,
        livingLabel: livingLabel ?? this.livingLabel,
        livingBudgetTarget: livingBudgetTarget ?? this.livingBudgetTarget,
        housingLabel: housingLabel ?? this.housingLabel,
        housingTarget: housingTarget ?? this.housingTarget,
        fixedCostLabel: fixedCostLabel ?? this.fixedCostLabel,
        fixedCostTarget: fixedCostTarget ?? this.fixedCostTarget,
        etfDoneAt: etfDoneAt.present ? etfDoneAt.value : this.etfDoneAt,
        annualSpecialDoneAt: annualSpecialDoneAt.present
            ? annualSpecialDoneAt.value
            : this.annualSpecialDoneAt,
        livingDoneAt:
            livingDoneAt.present ? livingDoneAt.value : this.livingDoneAt,
        housingDoneAt:
            housingDoneAt.present ? housingDoneAt.value : this.housingDoneAt,
        fixedCostDoneAt: fixedCostDoneAt.present
            ? fixedCostDoneAt.value
            : this.fixedCostDoneAt,
        sweepAmount: sweepAmount.present ? sweepAmount.value : this.sweepAmount,
        sweptAt: sweptAt.present ? sweptAt.value : this.sweptAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  SavingPlansTableData copyWithCompanion(SavingPlansTableCompanion data) {
    return SavingPlansTableData(
      id: data.id.present ? data.id.value : this.id,
      yearMonth: data.yearMonth.present ? data.yearMonth.value : this.yearMonth,
      salaryAmount: data.salaryAmount.present
          ? data.salaryAmount.value
          : this.salaryAmount,
      etfLabel: data.etfLabel.present ? data.etfLabel.value : this.etfLabel,
      etfTarget: data.etfTarget.present ? data.etfTarget.value : this.etfTarget,
      annualSpecialLabel: data.annualSpecialLabel.present
          ? data.annualSpecialLabel.value
          : this.annualSpecialLabel,
      annualSpecialTarget: data.annualSpecialTarget.present
          ? data.annualSpecialTarget.value
          : this.annualSpecialTarget,
      livingLabel:
          data.livingLabel.present ? data.livingLabel.value : this.livingLabel,
      livingBudgetTarget: data.livingBudgetTarget.present
          ? data.livingBudgetTarget.value
          : this.livingBudgetTarget,
      housingLabel: data.housingLabel.present
          ? data.housingLabel.value
          : this.housingLabel,
      housingTarget: data.housingTarget.present
          ? data.housingTarget.value
          : this.housingTarget,
      fixedCostLabel: data.fixedCostLabel.present
          ? data.fixedCostLabel.value
          : this.fixedCostLabel,
      fixedCostTarget: data.fixedCostTarget.present
          ? data.fixedCostTarget.value
          : this.fixedCostTarget,
      etfDoneAt: data.etfDoneAt.present ? data.etfDoneAt.value : this.etfDoneAt,
      annualSpecialDoneAt: data.annualSpecialDoneAt.present
          ? data.annualSpecialDoneAt.value
          : this.annualSpecialDoneAt,
      livingDoneAt: data.livingDoneAt.present
          ? data.livingDoneAt.value
          : this.livingDoneAt,
      housingDoneAt: data.housingDoneAt.present
          ? data.housingDoneAt.value
          : this.housingDoneAt,
      fixedCostDoneAt: data.fixedCostDoneAt.present
          ? data.fixedCostDoneAt.value
          : this.fixedCostDoneAt,
      sweepAmount:
          data.sweepAmount.present ? data.sweepAmount.value : this.sweepAmount,
      sweptAt: data.sweptAt.present ? data.sweptAt.value : this.sweptAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavingPlansTableData(')
          ..write('id: $id, ')
          ..write('yearMonth: $yearMonth, ')
          ..write('salaryAmount: $salaryAmount, ')
          ..write('etfLabel: $etfLabel, ')
          ..write('etfTarget: $etfTarget, ')
          ..write('annualSpecialLabel: $annualSpecialLabel, ')
          ..write('annualSpecialTarget: $annualSpecialTarget, ')
          ..write('livingLabel: $livingLabel, ')
          ..write('livingBudgetTarget: $livingBudgetTarget, ')
          ..write('housingLabel: $housingLabel, ')
          ..write('housingTarget: $housingTarget, ')
          ..write('fixedCostLabel: $fixedCostLabel, ')
          ..write('fixedCostTarget: $fixedCostTarget, ')
          ..write('etfDoneAt: $etfDoneAt, ')
          ..write('annualSpecialDoneAt: $annualSpecialDoneAt, ')
          ..write('livingDoneAt: $livingDoneAt, ')
          ..write('housingDoneAt: $housingDoneAt, ')
          ..write('fixedCostDoneAt: $fixedCostDoneAt, ')
          ..write('sweepAmount: $sweepAmount, ')
          ..write('sweptAt: $sweptAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        yearMonth,
        salaryAmount,
        etfLabel,
        etfTarget,
        annualSpecialLabel,
        annualSpecialTarget,
        livingLabel,
        livingBudgetTarget,
        housingLabel,
        housingTarget,
        fixedCostLabel,
        fixedCostTarget,
        etfDoneAt,
        annualSpecialDoneAt,
        livingDoneAt,
        housingDoneAt,
        fixedCostDoneAt,
        sweepAmount,
        sweptAt,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavingPlansTableData &&
          other.id == this.id &&
          other.yearMonth == this.yearMonth &&
          other.salaryAmount == this.salaryAmount &&
          other.etfLabel == this.etfLabel &&
          other.etfTarget == this.etfTarget &&
          other.annualSpecialLabel == this.annualSpecialLabel &&
          other.annualSpecialTarget == this.annualSpecialTarget &&
          other.livingLabel == this.livingLabel &&
          other.livingBudgetTarget == this.livingBudgetTarget &&
          other.housingLabel == this.housingLabel &&
          other.housingTarget == this.housingTarget &&
          other.fixedCostLabel == this.fixedCostLabel &&
          other.fixedCostTarget == this.fixedCostTarget &&
          other.etfDoneAt == this.etfDoneAt &&
          other.annualSpecialDoneAt == this.annualSpecialDoneAt &&
          other.livingDoneAt == this.livingDoneAt &&
          other.housingDoneAt == this.housingDoneAt &&
          other.fixedCostDoneAt == this.fixedCostDoneAt &&
          other.sweepAmount == this.sweepAmount &&
          other.sweptAt == this.sweptAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SavingPlansTableCompanion extends UpdateCompanion<SavingPlansTableData> {
  final Value<int> id;
  final Value<String> yearMonth;
  final Value<int> salaryAmount;
  final Value<String> etfLabel;
  final Value<int> etfTarget;
  final Value<String> annualSpecialLabel;
  final Value<int> annualSpecialTarget;
  final Value<String> livingLabel;
  final Value<int> livingBudgetTarget;
  final Value<String> housingLabel;
  final Value<int> housingTarget;
  final Value<String> fixedCostLabel;
  final Value<int> fixedCostTarget;
  final Value<DateTime?> etfDoneAt;
  final Value<DateTime?> annualSpecialDoneAt;
  final Value<DateTime?> livingDoneAt;
  final Value<DateTime?> housingDoneAt;
  final Value<DateTime?> fixedCostDoneAt;
  final Value<int?> sweepAmount;
  final Value<DateTime?> sweptAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SavingPlansTableCompanion({
    this.id = const Value.absent(),
    this.yearMonth = const Value.absent(),
    this.salaryAmount = const Value.absent(),
    this.etfLabel = const Value.absent(),
    this.etfTarget = const Value.absent(),
    this.annualSpecialLabel = const Value.absent(),
    this.annualSpecialTarget = const Value.absent(),
    this.livingLabel = const Value.absent(),
    this.livingBudgetTarget = const Value.absent(),
    this.housingLabel = const Value.absent(),
    this.housingTarget = const Value.absent(),
    this.fixedCostLabel = const Value.absent(),
    this.fixedCostTarget = const Value.absent(),
    this.etfDoneAt = const Value.absent(),
    this.annualSpecialDoneAt = const Value.absent(),
    this.livingDoneAt = const Value.absent(),
    this.housingDoneAt = const Value.absent(),
    this.fixedCostDoneAt = const Value.absent(),
    this.sweepAmount = const Value.absent(),
    this.sweptAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SavingPlansTableCompanion.insert({
    this.id = const Value.absent(),
    required String yearMonth,
    required int salaryAmount,
    this.etfLabel = const Value.absent(),
    required int etfTarget,
    this.annualSpecialLabel = const Value.absent(),
    required int annualSpecialTarget,
    this.livingLabel = const Value.absent(),
    required int livingBudgetTarget,
    this.housingLabel = const Value.absent(),
    required int housingTarget,
    this.fixedCostLabel = const Value.absent(),
    required int fixedCostTarget,
    this.etfDoneAt = const Value.absent(),
    this.annualSpecialDoneAt = const Value.absent(),
    this.livingDoneAt = const Value.absent(),
    this.housingDoneAt = const Value.absent(),
    this.fixedCostDoneAt = const Value.absent(),
    this.sweepAmount = const Value.absent(),
    this.sweptAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : yearMonth = Value(yearMonth),
        salaryAmount = Value(salaryAmount),
        etfTarget = Value(etfTarget),
        annualSpecialTarget = Value(annualSpecialTarget),
        livingBudgetTarget = Value(livingBudgetTarget),
        housingTarget = Value(housingTarget),
        fixedCostTarget = Value(fixedCostTarget),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<SavingPlansTableData> custom({
    Expression<int>? id,
    Expression<String>? yearMonth,
    Expression<int>? salaryAmount,
    Expression<String>? etfLabel,
    Expression<int>? etfTarget,
    Expression<String>? annualSpecialLabel,
    Expression<int>? annualSpecialTarget,
    Expression<String>? livingLabel,
    Expression<int>? livingBudgetTarget,
    Expression<String>? housingLabel,
    Expression<int>? housingTarget,
    Expression<String>? fixedCostLabel,
    Expression<int>? fixedCostTarget,
    Expression<DateTime>? etfDoneAt,
    Expression<DateTime>? annualSpecialDoneAt,
    Expression<DateTime>? livingDoneAt,
    Expression<DateTime>? housingDoneAt,
    Expression<DateTime>? fixedCostDoneAt,
    Expression<int>? sweepAmount,
    Expression<DateTime>? sweptAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (yearMonth != null) 'year_month': yearMonth,
      if (salaryAmount != null) 'salary_amount': salaryAmount,
      if (etfLabel != null) 'etf_label': etfLabel,
      if (etfTarget != null) 'etf_target': etfTarget,
      if (annualSpecialLabel != null)
        'annual_special_label': annualSpecialLabel,
      if (annualSpecialTarget != null)
        'annual_special_target': annualSpecialTarget,
      if (livingLabel != null) 'living_label': livingLabel,
      if (livingBudgetTarget != null)
        'living_budget_target': livingBudgetTarget,
      if (housingLabel != null) 'housing_label': housingLabel,
      if (housingTarget != null) 'housing_target': housingTarget,
      if (fixedCostLabel != null) 'fixed_cost_label': fixedCostLabel,
      if (fixedCostTarget != null) 'fixed_cost_target': fixedCostTarget,
      if (etfDoneAt != null) 'etf_done_at': etfDoneAt,
      if (annualSpecialDoneAt != null)
        'annual_special_done_at': annualSpecialDoneAt,
      if (livingDoneAt != null) 'living_done_at': livingDoneAt,
      if (housingDoneAt != null) 'housing_done_at': housingDoneAt,
      if (fixedCostDoneAt != null) 'fixed_cost_done_at': fixedCostDoneAt,
      if (sweepAmount != null) 'sweep_amount': sweepAmount,
      if (sweptAt != null) 'swept_at': sweptAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SavingPlansTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? yearMonth,
      Value<int>? salaryAmount,
      Value<String>? etfLabel,
      Value<int>? etfTarget,
      Value<String>? annualSpecialLabel,
      Value<int>? annualSpecialTarget,
      Value<String>? livingLabel,
      Value<int>? livingBudgetTarget,
      Value<String>? housingLabel,
      Value<int>? housingTarget,
      Value<String>? fixedCostLabel,
      Value<int>? fixedCostTarget,
      Value<DateTime?>? etfDoneAt,
      Value<DateTime?>? annualSpecialDoneAt,
      Value<DateTime?>? livingDoneAt,
      Value<DateTime?>? housingDoneAt,
      Value<DateTime?>? fixedCostDoneAt,
      Value<int?>? sweepAmount,
      Value<DateTime?>? sweptAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return SavingPlansTableCompanion(
      id: id ?? this.id,
      yearMonth: yearMonth ?? this.yearMonth,
      salaryAmount: salaryAmount ?? this.salaryAmount,
      etfLabel: etfLabel ?? this.etfLabel,
      etfTarget: etfTarget ?? this.etfTarget,
      annualSpecialLabel: annualSpecialLabel ?? this.annualSpecialLabel,
      annualSpecialTarget: annualSpecialTarget ?? this.annualSpecialTarget,
      livingLabel: livingLabel ?? this.livingLabel,
      livingBudgetTarget: livingBudgetTarget ?? this.livingBudgetTarget,
      housingLabel: housingLabel ?? this.housingLabel,
      housingTarget: housingTarget ?? this.housingTarget,
      fixedCostLabel: fixedCostLabel ?? this.fixedCostLabel,
      fixedCostTarget: fixedCostTarget ?? this.fixedCostTarget,
      etfDoneAt: etfDoneAt ?? this.etfDoneAt,
      annualSpecialDoneAt: annualSpecialDoneAt ?? this.annualSpecialDoneAt,
      livingDoneAt: livingDoneAt ?? this.livingDoneAt,
      housingDoneAt: housingDoneAt ?? this.housingDoneAt,
      fixedCostDoneAt: fixedCostDoneAt ?? this.fixedCostDoneAt,
      sweepAmount: sweepAmount ?? this.sweepAmount,
      sweptAt: sweptAt ?? this.sweptAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (yearMonth.present) {
      map['year_month'] = Variable<String>(yearMonth.value);
    }
    if (salaryAmount.present) {
      map['salary_amount'] = Variable<int>(salaryAmount.value);
    }
    if (etfLabel.present) {
      map['etf_label'] = Variable<String>(etfLabel.value);
    }
    if (etfTarget.present) {
      map['etf_target'] = Variable<int>(etfTarget.value);
    }
    if (annualSpecialLabel.present) {
      map['annual_special_label'] = Variable<String>(annualSpecialLabel.value);
    }
    if (annualSpecialTarget.present) {
      map['annual_special_target'] = Variable<int>(annualSpecialTarget.value);
    }
    if (livingLabel.present) {
      map['living_label'] = Variable<String>(livingLabel.value);
    }
    if (livingBudgetTarget.present) {
      map['living_budget_target'] = Variable<int>(livingBudgetTarget.value);
    }
    if (housingLabel.present) {
      map['housing_label'] = Variable<String>(housingLabel.value);
    }
    if (housingTarget.present) {
      map['housing_target'] = Variable<int>(housingTarget.value);
    }
    if (fixedCostLabel.present) {
      map['fixed_cost_label'] = Variable<String>(fixedCostLabel.value);
    }
    if (fixedCostTarget.present) {
      map['fixed_cost_target'] = Variable<int>(fixedCostTarget.value);
    }
    if (etfDoneAt.present) {
      map['etf_done_at'] = Variable<DateTime>(etfDoneAt.value);
    }
    if (annualSpecialDoneAt.present) {
      map['annual_special_done_at'] =
          Variable<DateTime>(annualSpecialDoneAt.value);
    }
    if (livingDoneAt.present) {
      map['living_done_at'] = Variable<DateTime>(livingDoneAt.value);
    }
    if (housingDoneAt.present) {
      map['housing_done_at'] = Variable<DateTime>(housingDoneAt.value);
    }
    if (fixedCostDoneAt.present) {
      map['fixed_cost_done_at'] = Variable<DateTime>(fixedCostDoneAt.value);
    }
    if (sweepAmount.present) {
      map['sweep_amount'] = Variable<int>(sweepAmount.value);
    }
    if (sweptAt.present) {
      map['swept_at'] = Variable<DateTime>(sweptAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavingPlansTableCompanion(')
          ..write('id: $id, ')
          ..write('yearMonth: $yearMonth, ')
          ..write('salaryAmount: $salaryAmount, ')
          ..write('etfLabel: $etfLabel, ')
          ..write('etfTarget: $etfTarget, ')
          ..write('annualSpecialLabel: $annualSpecialLabel, ')
          ..write('annualSpecialTarget: $annualSpecialTarget, ')
          ..write('livingLabel: $livingLabel, ')
          ..write('livingBudgetTarget: $livingBudgetTarget, ')
          ..write('housingLabel: $housingLabel, ')
          ..write('housingTarget: $housingTarget, ')
          ..write('fixedCostLabel: $fixedCostLabel, ')
          ..write('fixedCostTarget: $fixedCostTarget, ')
          ..write('etfDoneAt: $etfDoneAt, ')
          ..write('annualSpecialDoneAt: $annualSpecialDoneAt, ')
          ..write('livingDoneAt: $livingDoneAt, ')
          ..write('housingDoneAt: $housingDoneAt, ')
          ..write('fixedCostDoneAt: $fixedCostDoneAt, ')
          ..write('sweepAmount: $sweepAmount, ')
          ..write('sweptAt: $sweptAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CategoryBudgetAllocationsTableTable
    extends CategoryBudgetAllocationsTable
    with
        TableInfo<$CategoryBudgetAllocationsTableTable,
            CategoryBudgetAllocationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryBudgetAllocationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories_table (id)'));
  static const VerificationMeta _yearMonthMeta =
      const VerificationMeta('yearMonth');
  @override
  late final GeneratedColumn<String> yearMonth = GeneratedColumn<String>(
      'year_month', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _budgetAmountMeta =
      const VerificationMeta('budgetAmount');
  @override
  late final GeneratedColumn<int> budgetAmount = GeneratedColumn<int>(
      'budget_amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, categoryId, yearMonth, budgetAmount, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category_budget_allocations_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<CategoryBudgetAllocationsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('year_month')) {
      context.handle(_yearMonthMeta,
          yearMonth.isAcceptableOrUnknown(data['year_month']!, _yearMonthMeta));
    } else if (isInserting) {
      context.missing(_yearMonthMeta);
    }
    if (data.containsKey('budget_amount')) {
      context.handle(
          _budgetAmountMeta,
          budgetAmount.isAcceptableOrUnknown(
              data['budget_amount']!, _budgetAmountMeta));
    } else if (isInserting) {
      context.missing(_budgetAmountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {categoryId, yearMonth},
      ];
  @override
  CategoryBudgetAllocationsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryBudgetAllocationsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id'])!,
      yearMonth: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}year_month'])!,
      budgetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}budget_amount'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CategoryBudgetAllocationsTableTable createAlias(String alias) {
    return $CategoryBudgetAllocationsTableTable(attachedDatabase, alias);
  }
}

class CategoryBudgetAllocationsTableData extends DataClass
    implements Insertable<CategoryBudgetAllocationsTableData> {
  final int id;
  final int categoryId;
  final String yearMonth;
  final int budgetAmount;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CategoryBudgetAllocationsTableData(
      {required this.id,
      required this.categoryId,
      required this.yearMonth,
      required this.budgetAmount,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['year_month'] = Variable<String>(yearMonth);
    map['budget_amount'] = Variable<int>(budgetAmount);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CategoryBudgetAllocationsTableCompanion toCompanion(bool nullToAbsent) {
    return CategoryBudgetAllocationsTableCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      yearMonth: Value(yearMonth),
      budgetAmount: Value(budgetAmount),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CategoryBudgetAllocationsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryBudgetAllocationsTableData(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      yearMonth: serializer.fromJson<String>(json['yearMonth']),
      budgetAmount: serializer.fromJson<int>(json['budgetAmount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'yearMonth': serializer.toJson<String>(yearMonth),
      'budgetAmount': serializer.toJson<int>(budgetAmount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CategoryBudgetAllocationsTableData copyWith(
          {int? id,
          int? categoryId,
          String? yearMonth,
          int? budgetAmount,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CategoryBudgetAllocationsTableData(
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        yearMonth: yearMonth ?? this.yearMonth,
        budgetAmount: budgetAmount ?? this.budgetAmount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CategoryBudgetAllocationsTableData copyWithCompanion(
      CategoryBudgetAllocationsTableCompanion data) {
    return CategoryBudgetAllocationsTableData(
      id: data.id.present ? data.id.value : this.id,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      yearMonth: data.yearMonth.present ? data.yearMonth.value : this.yearMonth,
      budgetAmount: data.budgetAmount.present
          ? data.budgetAmount.value
          : this.budgetAmount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryBudgetAllocationsTableData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('yearMonth: $yearMonth, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, categoryId, yearMonth, budgetAmount, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryBudgetAllocationsTableData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.yearMonth == this.yearMonth &&
          other.budgetAmount == this.budgetAmount &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CategoryBudgetAllocationsTableCompanion
    extends UpdateCompanion<CategoryBudgetAllocationsTableData> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> yearMonth;
  final Value<int> budgetAmount;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CategoryBudgetAllocationsTableCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.yearMonth = const Value.absent(),
    this.budgetAmount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CategoryBudgetAllocationsTableCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String yearMonth,
    required int budgetAmount,
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : categoryId = Value(categoryId),
        yearMonth = Value(yearMonth),
        budgetAmount = Value(budgetAmount),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<CategoryBudgetAllocationsTableData> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? yearMonth,
    Expression<int>? budgetAmount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (yearMonth != null) 'year_month': yearMonth,
      if (budgetAmount != null) 'budget_amount': budgetAmount,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CategoryBudgetAllocationsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? categoryId,
      Value<String>? yearMonth,
      Value<int>? budgetAmount,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return CategoryBudgetAllocationsTableCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      yearMonth: yearMonth ?? this.yearMonth,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (yearMonth.present) {
      map['year_month'] = Variable<String>(yearMonth.value);
    }
    if (budgetAmount.present) {
      map['budget_amount'] = Variable<int>(budgetAmount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryBudgetAllocationsTableCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('yearMonth: $yearMonth, ')
          ..write('budgetAmount: $budgetAmount, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _budgetTypeMeta =
      const VerificationMeta('budgetType');
  @override
  late final GeneratedColumn<String> budgetType = GeneratedColumn<String>(
      'budget_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('monthly'));
  static const VerificationMeta _specialCategoryMeta =
      const VerificationMeta('specialCategory');
  @override
  late final GeneratedColumn<String> specialCategory = GeneratedColumn<String>(
      'special_category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _paymentMethodMeta =
      const VerificationMeta('paymentMethod');
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
      'payment_method', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('cash'));
  static const VerificationMeta _prepaidAtMeta =
      const VerificationMeta('prepaidAt');
  @override
  late final GeneratedColumn<DateTime> prepaidAt = GeneratedColumn<DateTime>(
      'prepaid_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories_table (id)'));
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _linkedUpcomingExpenseIdMeta =
      const VerificationMeta('linkedUpcomingExpenseId');
  @override
  late final GeneratedColumn<int> linkedUpcomingExpenseId =
      GeneratedColumn<int>('linked_upcoming_expense_id', aliasedName, true,
          type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        amount,
        type,
        budgetType,
        specialCategory,
        paymentMethod,
        prepaidAt,
        categoryId,
        occurredAt,
        memo,
        source,
        linkedUpcomingExpenseId,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('budget_type')) {
      context.handle(
          _budgetTypeMeta,
          budgetType.isAcceptableOrUnknown(
              data['budget_type']!, _budgetTypeMeta));
    }
    if (data.containsKey('special_category')) {
      context.handle(
          _specialCategoryMeta,
          specialCategory.isAcceptableOrUnknown(
              data['special_category']!, _specialCategoryMeta));
    }
    if (data.containsKey('payment_method')) {
      context.handle(
          _paymentMethodMeta,
          paymentMethod.isAcceptableOrUnknown(
              data['payment_method']!, _paymentMethodMeta));
    }
    if (data.containsKey('prepaid_at')) {
      context.handle(_prepaidAtMeta,
          prepaidAt.isAcceptableOrUnknown(data['prepaid_at']!, _prepaidAtMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('linked_upcoming_expense_id')) {
      context.handle(
          _linkedUpcomingExpenseIdMeta,
          linkedUpcomingExpenseId.isAcceptableOrUnknown(
              data['linked_upcoming_expense_id']!,
              _linkedUpcomingExpenseIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      budgetType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}budget_type'])!,
      specialCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}special_category']),
      paymentMethod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payment_method'])!,
      prepaidAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}prepaid_at']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      linkedUpcomingExpenseId: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}linked_upcoming_expense_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionsTableData extends DataClass
    implements Insertable<TransactionsTableData> {
  final int id;
  final int amount;
  final String type;
  final String budgetType;
  final String? specialCategory;
  final String paymentMethod;
  final DateTime? prepaidAt;
  final int? categoryId;
  final DateTime occurredAt;
  final String? memo;
  final String source;
  final int? linkedUpcomingExpenseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const TransactionsTableData(
      {required this.id,
      required this.amount,
      required this.type,
      required this.budgetType,
      this.specialCategory,
      required this.paymentMethod,
      this.prepaidAt,
      this.categoryId,
      required this.occurredAt,
      this.memo,
      required this.source,
      this.linkedUpcomingExpenseId,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['amount'] = Variable<int>(amount);
    map['type'] = Variable<String>(type);
    map['budget_type'] = Variable<String>(budgetType);
    if (!nullToAbsent || specialCategory != null) {
      map['special_category'] = Variable<String>(specialCategory);
    }
    map['payment_method'] = Variable<String>(paymentMethod);
    if (!nullToAbsent || prepaidAt != null) {
      map['prepaid_at'] = Variable<DateTime>(prepaidAt);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || linkedUpcomingExpenseId != null) {
      map['linked_upcoming_expense_id'] =
          Variable<int>(linkedUpcomingExpenseId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      amount: Value(amount),
      type: Value(type),
      budgetType: Value(budgetType),
      specialCategory: specialCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(specialCategory),
      paymentMethod: Value(paymentMethod),
      prepaidAt: prepaidAt == null && nullToAbsent
          ? const Value.absent()
          : Value(prepaidAt),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      occurredAt: Value(occurredAt),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      source: Value(source),
      linkedUpcomingExpenseId: linkedUpcomingExpenseId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedUpcomingExpenseId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory TransactionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsTableData(
      id: serializer.fromJson<int>(json['id']),
      amount: serializer.fromJson<int>(json['amount']),
      type: serializer.fromJson<String>(json['type']),
      budgetType: serializer.fromJson<String>(json['budgetType']),
      specialCategory: serializer.fromJson<String?>(json['specialCategory']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      prepaidAt: serializer.fromJson<DateTime?>(json['prepaidAt']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      memo: serializer.fromJson<String?>(json['memo']),
      source: serializer.fromJson<String>(json['source']),
      linkedUpcomingExpenseId:
          serializer.fromJson<int?>(json['linkedUpcomingExpenseId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'amount': serializer.toJson<int>(amount),
      'type': serializer.toJson<String>(type),
      'budgetType': serializer.toJson<String>(budgetType),
      'specialCategory': serializer.toJson<String?>(specialCategory),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'prepaidAt': serializer.toJson<DateTime?>(prepaidAt),
      'categoryId': serializer.toJson<int?>(categoryId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'memo': serializer.toJson<String?>(memo),
      'source': serializer.toJson<String>(source),
      'linkedUpcomingExpenseId':
          serializer.toJson<int?>(linkedUpcomingExpenseId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  TransactionsTableData copyWith(
          {int? id,
          int? amount,
          String? type,
          String? budgetType,
          Value<String?> specialCategory = const Value.absent(),
          String? paymentMethod,
          Value<DateTime?> prepaidAt = const Value.absent(),
          Value<int?> categoryId = const Value.absent(),
          DateTime? occurredAt,
          Value<String?> memo = const Value.absent(),
          String? source,
          Value<int?> linkedUpcomingExpenseId = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      TransactionsTableData(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        budgetType: budgetType ?? this.budgetType,
        specialCategory: specialCategory.present
            ? specialCategory.value
            : this.specialCategory,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        prepaidAt: prepaidAt.present ? prepaidAt.value : this.prepaidAt,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        occurredAt: occurredAt ?? this.occurredAt,
        memo: memo.present ? memo.value : this.memo,
        source: source ?? this.source,
        linkedUpcomingExpenseId: linkedUpcomingExpenseId.present
            ? linkedUpcomingExpenseId.value
            : this.linkedUpcomingExpenseId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  TransactionsTableData copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      amount: data.amount.present ? data.amount.value : this.amount,
      type: data.type.present ? data.type.value : this.type,
      budgetType:
          data.budgetType.present ? data.budgetType.value : this.budgetType,
      specialCategory: data.specialCategory.present
          ? data.specialCategory.value
          : this.specialCategory,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      prepaidAt: data.prepaidAt.present ? data.prepaidAt.value : this.prepaidAt,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      memo: data.memo.present ? data.memo.value : this.memo,
      source: data.source.present ? data.source.value : this.source,
      linkedUpcomingExpenseId: data.linkedUpcomingExpenseId.present
          ? data.linkedUpcomingExpenseId.value
          : this.linkedUpcomingExpenseId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableData(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('budgetType: $budgetType, ')
          ..write('specialCategory: $specialCategory, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('prepaidAt: $prepaidAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('memo: $memo, ')
          ..write('source: $source, ')
          ..write('linkedUpcomingExpenseId: $linkedUpcomingExpenseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      amount,
      type,
      budgetType,
      specialCategory,
      paymentMethod,
      prepaidAt,
      categoryId,
      occurredAt,
      memo,
      source,
      linkedUpcomingExpenseId,
      createdAt,
      updatedAt,
      deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsTableData &&
          other.id == this.id &&
          other.amount == this.amount &&
          other.type == this.type &&
          other.budgetType == this.budgetType &&
          other.specialCategory == this.specialCategory &&
          other.paymentMethod == this.paymentMethod &&
          other.prepaidAt == this.prepaidAt &&
          other.categoryId == this.categoryId &&
          other.occurredAt == this.occurredAt &&
          other.memo == this.memo &&
          other.source == this.source &&
          other.linkedUpcomingExpenseId == this.linkedUpcomingExpenseId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class TransactionsTableCompanion
    extends UpdateCompanion<TransactionsTableData> {
  final Value<int> id;
  final Value<int> amount;
  final Value<String> type;
  final Value<String> budgetType;
  final Value<String?> specialCategory;
  final Value<String> paymentMethod;
  final Value<DateTime?> prepaidAt;
  final Value<int?> categoryId;
  final Value<DateTime> occurredAt;
  final Value<String?> memo;
  final Value<String> source;
  final Value<int?> linkedUpcomingExpenseId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
    this.budgetType = const Value.absent(),
    this.specialCategory = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.prepaidAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.memo = const Value.absent(),
    this.source = const Value.absent(),
    this.linkedUpcomingExpenseId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    this.id = const Value.absent(),
    required int amount,
    required String type,
    this.budgetType = const Value.absent(),
    this.specialCategory = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.prepaidAt = const Value.absent(),
    this.categoryId = const Value.absent(),
    required DateTime occurredAt,
    this.memo = const Value.absent(),
    this.source = const Value.absent(),
    this.linkedUpcomingExpenseId = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
  })  : amount = Value(amount),
        type = Value(type),
        occurredAt = Value(occurredAt),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<TransactionsTableData> custom({
    Expression<int>? id,
    Expression<int>? amount,
    Expression<String>? type,
    Expression<String>? budgetType,
    Expression<String>? specialCategory,
    Expression<String>? paymentMethod,
    Expression<DateTime>? prepaidAt,
    Expression<int>? categoryId,
    Expression<DateTime>? occurredAt,
    Expression<String>? memo,
    Expression<String>? source,
    Expression<int>? linkedUpcomingExpenseId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
      if (budgetType != null) 'budget_type': budgetType,
      if (specialCategory != null) 'special_category': specialCategory,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (prepaidAt != null) 'prepaid_at': prepaidAt,
      if (categoryId != null) 'category_id': categoryId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (memo != null) 'memo': memo,
      if (source != null) 'source': source,
      if (linkedUpcomingExpenseId != null)
        'linked_upcoming_expense_id': linkedUpcomingExpenseId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
    });
  }

  TransactionsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? amount,
      Value<String>? type,
      Value<String>? budgetType,
      Value<String?>? specialCategory,
      Value<String>? paymentMethod,
      Value<DateTime?>? prepaidAt,
      Value<int?>? categoryId,
      Value<DateTime>? occurredAt,
      Value<String?>? memo,
      Value<String>? source,
      Value<int?>? linkedUpcomingExpenseId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt}) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      budgetType: budgetType ?? this.budgetType,
      specialCategory: specialCategory ?? this.specialCategory,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      prepaidAt: prepaidAt ?? this.prepaidAt,
      categoryId: categoryId ?? this.categoryId,
      occurredAt: occurredAt ?? this.occurredAt,
      memo: memo ?? this.memo,
      source: source ?? this.source,
      linkedUpcomingExpenseId:
          linkedUpcomingExpenseId ?? this.linkedUpcomingExpenseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (budgetType.present) {
      map['budget_type'] = Variable<String>(budgetType.value);
    }
    if (specialCategory.present) {
      map['special_category'] = Variable<String>(specialCategory.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (prepaidAt.present) {
      map['prepaid_at'] = Variable<DateTime>(prepaidAt.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (linkedUpcomingExpenseId.present) {
      map['linked_upcoming_expense_id'] =
          Variable<int>(linkedUpcomingExpenseId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('budgetType: $budgetType, ')
          ..write('specialCategory: $specialCategory, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('prepaidAt: $prepaidAt, ')
          ..write('categoryId: $categoryId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('memo: $memo, ')
          ..write('source: $source, ')
          ..write('linkedUpcomingExpenseId: $linkedUpcomingExpenseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }
}

class $UpcomingExpensesTableTable extends UpcomingExpensesTable
    with TableInfo<$UpcomingExpensesTableTable, UpcomingExpensesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UpcomingExpensesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
      'amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scheduledDateMeta =
      const VerificationMeta('scheduledDate');
  @override
  late final GeneratedColumn<DateTime> scheduledDate =
      GeneratedColumn<DateTime>('scheduled_date', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES categories_table (id)'));
  static const VerificationMeta _isRecurringMeta =
      const VerificationMeta('isRecurring');
  @override
  late final GeneratedColumn<bool> isRecurring = GeneratedColumn<bool>(
      'is_recurring', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_recurring" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _recurrenceTypeMeta =
      const VerificationMeta('recurrenceType');
  @override
  late final GeneratedColumn<String> recurrenceType = GeneratedColumn<String>(
      'recurrence_type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('none'));
  static const VerificationMeta _recurrenceIntervalMeta =
      const VerificationMeta('recurrenceInterval');
  @override
  late final GeneratedColumn<int> recurrenceInterval = GeneratedColumn<int>(
      'recurrence_interval', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isPaidMeta = const VerificationMeta('isPaid');
  @override
  late final GeneratedColumn<bool> isPaid = GeneratedColumn<bool>(
      'is_paid', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_paid" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _paidTransactionIdMeta =
      const VerificationMeta('paidTransactionId');
  @override
  late final GeneratedColumn<int> paidTransactionId = GeneratedColumn<int>(
      'paid_transaction_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        amount,
        scheduledDate,
        categoryId,
        isRecurring,
        recurrenceType,
        recurrenceInterval,
        isPaid,
        paidTransactionId,
        note,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'upcoming_expenses_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<UpcomingExpensesTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('scheduled_date')) {
      context.handle(
          _scheduledDateMeta,
          scheduledDate.isAcceptableOrUnknown(
              data['scheduled_date']!, _scheduledDateMeta));
    } else if (isInserting) {
      context.missing(_scheduledDateMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('is_recurring')) {
      context.handle(
          _isRecurringMeta,
          isRecurring.isAcceptableOrUnknown(
              data['is_recurring']!, _isRecurringMeta));
    }
    if (data.containsKey('recurrence_type')) {
      context.handle(
          _recurrenceTypeMeta,
          recurrenceType.isAcceptableOrUnknown(
              data['recurrence_type']!, _recurrenceTypeMeta));
    }
    if (data.containsKey('recurrence_interval')) {
      context.handle(
          _recurrenceIntervalMeta,
          recurrenceInterval.isAcceptableOrUnknown(
              data['recurrence_interval']!, _recurrenceIntervalMeta));
    }
    if (data.containsKey('is_paid')) {
      context.handle(_isPaidMeta,
          isPaid.isAcceptableOrUnknown(data['is_paid']!, _isPaidMeta));
    }
    if (data.containsKey('paid_transaction_id')) {
      context.handle(
          _paidTransactionIdMeta,
          paidTransactionId.isAcceptableOrUnknown(
              data['paid_transaction_id']!, _paidTransactionIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UpcomingExpensesTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UpcomingExpensesTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
      scheduledDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}scheduled_date'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      isRecurring: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_recurring'])!,
      recurrenceType: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}recurrence_type'])!,
      recurrenceInterval: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}recurrence_interval']),
      isPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_paid'])!,
      paidTransactionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}paid_transaction_id']),
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UpcomingExpensesTableTable createAlias(String alias) {
    return $UpcomingExpensesTableTable(attachedDatabase, alias);
  }
}

class UpcomingExpensesTableData extends DataClass
    implements Insertable<UpcomingExpensesTableData> {
  final int id;
  final String title;
  final int amount;
  final DateTime scheduledDate;
  final int? categoryId;
  final bool isRecurring;
  final String recurrenceType;
  final int? recurrenceInterval;
  final bool isPaid;
  final int? paidTransactionId;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UpcomingExpensesTableData(
      {required this.id,
      required this.title,
      required this.amount,
      required this.scheduledDate,
      this.categoryId,
      required this.isRecurring,
      required this.recurrenceType,
      this.recurrenceInterval,
      required this.isPaid,
      this.paidTransactionId,
      this.note,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<int>(amount);
    map['scheduled_date'] = Variable<DateTime>(scheduledDate);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    map['is_recurring'] = Variable<bool>(isRecurring);
    map['recurrence_type'] = Variable<String>(recurrenceType);
    if (!nullToAbsent || recurrenceInterval != null) {
      map['recurrence_interval'] = Variable<int>(recurrenceInterval);
    }
    map['is_paid'] = Variable<bool>(isPaid);
    if (!nullToAbsent || paidTransactionId != null) {
      map['paid_transaction_id'] = Variable<int>(paidTransactionId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UpcomingExpensesTableCompanion toCompanion(bool nullToAbsent) {
    return UpcomingExpensesTableCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      scheduledDate: Value(scheduledDate),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      isRecurring: Value(isRecurring),
      recurrenceType: Value(recurrenceType),
      recurrenceInterval: recurrenceInterval == null && nullToAbsent
          ? const Value.absent()
          : Value(recurrenceInterval),
      isPaid: Value(isPaid),
      paidTransactionId: paidTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(paidTransactionId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UpcomingExpensesTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UpcomingExpensesTableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<int>(json['amount']),
      scheduledDate: serializer.fromJson<DateTime>(json['scheduledDate']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      isRecurring: serializer.fromJson<bool>(json['isRecurring']),
      recurrenceType: serializer.fromJson<String>(json['recurrenceType']),
      recurrenceInterval: serializer.fromJson<int?>(json['recurrenceInterval']),
      isPaid: serializer.fromJson<bool>(json['isPaid']),
      paidTransactionId: serializer.fromJson<int?>(json['paidTransactionId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<int>(amount),
      'scheduledDate': serializer.toJson<DateTime>(scheduledDate),
      'categoryId': serializer.toJson<int?>(categoryId),
      'isRecurring': serializer.toJson<bool>(isRecurring),
      'recurrenceType': serializer.toJson<String>(recurrenceType),
      'recurrenceInterval': serializer.toJson<int?>(recurrenceInterval),
      'isPaid': serializer.toJson<bool>(isPaid),
      'paidTransactionId': serializer.toJson<int?>(paidTransactionId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UpcomingExpensesTableData copyWith(
          {int? id,
          String? title,
          int? amount,
          DateTime? scheduledDate,
          Value<int?> categoryId = const Value.absent(),
          bool? isRecurring,
          String? recurrenceType,
          Value<int?> recurrenceInterval = const Value.absent(),
          bool? isPaid,
          Value<int?> paidTransactionId = const Value.absent(),
          Value<String?> note = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      UpcomingExpensesTableData(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        scheduledDate: scheduledDate ?? this.scheduledDate,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        isRecurring: isRecurring ?? this.isRecurring,
        recurrenceType: recurrenceType ?? this.recurrenceType,
        recurrenceInterval: recurrenceInterval.present
            ? recurrenceInterval.value
            : this.recurrenceInterval,
        isPaid: isPaid ?? this.isPaid,
        paidTransactionId: paidTransactionId.present
            ? paidTransactionId.value
            : this.paidTransactionId,
        note: note.present ? note.value : this.note,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UpcomingExpensesTableData copyWithCompanion(
      UpcomingExpensesTableCompanion data) {
    return UpcomingExpensesTableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      scheduledDate: data.scheduledDate.present
          ? data.scheduledDate.value
          : this.scheduledDate,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      isRecurring:
          data.isRecurring.present ? data.isRecurring.value : this.isRecurring,
      recurrenceType: data.recurrenceType.present
          ? data.recurrenceType.value
          : this.recurrenceType,
      recurrenceInterval: data.recurrenceInterval.present
          ? data.recurrenceInterval.value
          : this.recurrenceInterval,
      isPaid: data.isPaid.present ? data.isPaid.value : this.isPaid,
      paidTransactionId: data.paidTransactionId.present
          ? data.paidTransactionId.value
          : this.paidTransactionId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UpcomingExpensesTableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceInterval: $recurrenceInterval, ')
          ..write('isPaid: $isPaid, ')
          ..write('paidTransactionId: $paidTransactionId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      amount,
      scheduledDate,
      categoryId,
      isRecurring,
      recurrenceType,
      recurrenceInterval,
      isPaid,
      paidTransactionId,
      note,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UpcomingExpensesTableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.scheduledDate == this.scheduledDate &&
          other.categoryId == this.categoryId &&
          other.isRecurring == this.isRecurring &&
          other.recurrenceType == this.recurrenceType &&
          other.recurrenceInterval == this.recurrenceInterval &&
          other.isPaid == this.isPaid &&
          other.paidTransactionId == this.paidTransactionId &&
          other.note == this.note &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UpcomingExpensesTableCompanion
    extends UpdateCompanion<UpcomingExpensesTableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> amount;
  final Value<DateTime> scheduledDate;
  final Value<int?> categoryId;
  final Value<bool> isRecurring;
  final Value<String> recurrenceType;
  final Value<int?> recurrenceInterval;
  final Value<bool> isPaid;
  final Value<int?> paidTransactionId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UpcomingExpensesTableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.scheduledDate = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceInterval = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.paidTransactionId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UpcomingExpensesTableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int amount,
    required DateTime scheduledDate,
    this.categoryId = const Value.absent(),
    this.isRecurring = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.recurrenceInterval = const Value.absent(),
    this.isPaid = const Value.absent(),
    this.paidTransactionId = const Value.absent(),
    this.note = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  })  : title = Value(title),
        amount = Value(amount),
        scheduledDate = Value(scheduledDate),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<UpcomingExpensesTableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? amount,
    Expression<DateTime>? scheduledDate,
    Expression<int>? categoryId,
    Expression<bool>? isRecurring,
    Expression<String>? recurrenceType,
    Expression<int>? recurrenceInterval,
    Expression<bool>? isPaid,
    Expression<int>? paidTransactionId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (scheduledDate != null) 'scheduled_date': scheduledDate,
      if (categoryId != null) 'category_id': categoryId,
      if (isRecurring != null) 'is_recurring': isRecurring,
      if (recurrenceType != null) 'recurrence_type': recurrenceType,
      if (recurrenceInterval != null) 'recurrence_interval': recurrenceInterval,
      if (isPaid != null) 'is_paid': isPaid,
      if (paidTransactionId != null) 'paid_transaction_id': paidTransactionId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UpcomingExpensesTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? amount,
      Value<DateTime>? scheduledDate,
      Value<int?>? categoryId,
      Value<bool>? isRecurring,
      Value<String>? recurrenceType,
      Value<int?>? recurrenceInterval,
      Value<bool>? isPaid,
      Value<int?>? paidTransactionId,
      Value<String?>? note,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return UpcomingExpensesTableCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      categoryId: categoryId ?? this.categoryId,
      isRecurring: isRecurring ?? this.isRecurring,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      recurrenceInterval: recurrenceInterval ?? this.recurrenceInterval,
      isPaid: isPaid ?? this.isPaid,
      paidTransactionId: paidTransactionId ?? this.paidTransactionId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (scheduledDate.present) {
      map['scheduled_date'] = Variable<DateTime>(scheduledDate.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (isRecurring.present) {
      map['is_recurring'] = Variable<bool>(isRecurring.value);
    }
    if (recurrenceType.present) {
      map['recurrence_type'] = Variable<String>(recurrenceType.value);
    }
    if (recurrenceInterval.present) {
      map['recurrence_interval'] = Variable<int>(recurrenceInterval.value);
    }
    if (isPaid.present) {
      map['is_paid'] = Variable<bool>(isPaid.value);
    }
    if (paidTransactionId.present) {
      map['paid_transaction_id'] = Variable<int>(paidTransactionId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UpcomingExpensesTableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('scheduledDate: $scheduledDate, ')
          ..write('categoryId: $categoryId, ')
          ..write('isRecurring: $isRecurring, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('recurrenceInterval: $recurrenceInterval, ')
          ..write('isPaid: $isPaid, ')
          ..write('paidTransactionId: $paidTransactionId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WishlistItemsTableTable extends WishlistItemsTable
    with TableInfo<$WishlistItemsTableTable, WishlistItemsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistItemsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<int> price = GeneratedColumn<int>(
      'price', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _memoMeta = const VerificationMeta('memo');
  @override
  late final GeneratedColumn<String> memo = GeneratedColumn<String>(
      'memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cooldownHoursMeta =
      const VerificationMeta('cooldownHours');
  @override
  late final GeneratedColumn<int> cooldownHours = GeneratedColumn<int>(
      'cooldown_hours', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(72));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _cooldownUntilMeta =
      const VerificationMeta('cooldownUntil');
  @override
  late final GeneratedColumn<DateTime> cooldownUntil =
      GeneratedColumn<DateTime>('cooldown_until', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _waitingUntilMeta =
      const VerificationMeta('waitingUntil');
  @override
  late final GeneratedColumn<DateTime> waitingUntil = GeneratedColumn<DateTime>(
      'waiting_until', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _purchasedAtMeta =
      const VerificationMeta('purchasedAt');
  @override
  late final GeneratedColumn<DateTime> purchasedAt = GeneratedColumn<DateTime>(
      'purchased_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _releasedAtMeta =
      const VerificationMeta('releasedAt');
  @override
  late final GeneratedColumn<DateTime> releasedAt = GeneratedColumn<DateTime>(
      'released_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _linkedTransactionIdMeta =
      const VerificationMeta('linkedTransactionId');
  @override
  late final GeneratedColumn<int> linkedTransactionId = GeneratedColumn<int>(
      'linked_transaction_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _createdDailySafeSnapshotMeta =
      const VerificationMeta('createdDailySafeSnapshot');
  @override
  late final GeneratedColumn<int> createdDailySafeSnapshot =
      GeneratedColumn<int>('created_daily_safe_snapshot', aliasedName, false,
          type: DriftSqlType.int,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        price,
        url,
        imagePath,
        memo,
        cooldownHours,
        createdAt,
        cooldownUntil,
        status,
        waitingUntil,
        purchasedAt,
        releasedAt,
        linkedTransactionId,
        createdDailySafeSnapshot,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_items_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<WishlistItemsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    if (data.containsKey('memo')) {
      context.handle(
          _memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('cooldown_hours')) {
      context.handle(
          _cooldownHoursMeta,
          cooldownHours.isAcceptableOrUnknown(
              data['cooldown_hours']!, _cooldownHoursMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('cooldown_until')) {
      context.handle(
          _cooldownUntilMeta,
          cooldownUntil.isAcceptableOrUnknown(
              data['cooldown_until']!, _cooldownUntilMeta));
    } else if (isInserting) {
      context.missing(_cooldownUntilMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('waiting_until')) {
      context.handle(
          _waitingUntilMeta,
          waitingUntil.isAcceptableOrUnknown(
              data['waiting_until']!, _waitingUntilMeta));
    }
    if (data.containsKey('purchased_at')) {
      context.handle(
          _purchasedAtMeta,
          purchasedAt.isAcceptableOrUnknown(
              data['purchased_at']!, _purchasedAtMeta));
    }
    if (data.containsKey('released_at')) {
      context.handle(
          _releasedAtMeta,
          releasedAt.isAcceptableOrUnknown(
              data['released_at']!, _releasedAtMeta));
    }
    if (data.containsKey('linked_transaction_id')) {
      context.handle(
          _linkedTransactionIdMeta,
          linkedTransactionId.isAcceptableOrUnknown(
              data['linked_transaction_id']!, _linkedTransactionIdMeta));
    }
    if (data.containsKey('created_daily_safe_snapshot')) {
      context.handle(
          _createdDailySafeSnapshotMeta,
          createdDailySafeSnapshot.isAcceptableOrUnknown(
              data['created_daily_safe_snapshot']!,
              _createdDailySafeSnapshotMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistItemsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistItemsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}price'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
      memo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}memo']),
      cooldownHours: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cooldown_hours'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      cooldownUntil: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}cooldown_until'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      waitingUntil: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}waiting_until']),
      purchasedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}purchased_at']),
      releasedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}released_at']),
      linkedTransactionId: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}linked_transaction_id']),
      createdDailySafeSnapshot: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}created_daily_safe_snapshot'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $WishlistItemsTableTable createAlias(String alias) {
    return $WishlistItemsTableTable(attachedDatabase, alias);
  }
}

class WishlistItemsTableData extends DataClass
    implements Insertable<WishlistItemsTableData> {
  final int id;
  final String name;
  final int price;
  final String? url;
  final String? imagePath;
  final String? memo;
  final int cooldownHours;
  final DateTime createdAt;
  final DateTime cooldownUntil;
  final String status;
  final DateTime? waitingUntil;
  final DateTime? purchasedAt;
  final DateTime? releasedAt;
  final int? linkedTransactionId;
  final int createdDailySafeSnapshot;
  final DateTime updatedAt;
  const WishlistItemsTableData(
      {required this.id,
      required this.name,
      required this.price,
      this.url,
      this.imagePath,
      this.memo,
      required this.cooldownHours,
      required this.createdAt,
      required this.cooldownUntil,
      required this.status,
      this.waitingUntil,
      this.purchasedAt,
      this.releasedAt,
      this.linkedTransactionId,
      required this.createdDailySafeSnapshot,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['price'] = Variable<int>(price);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['cooldown_hours'] = Variable<int>(cooldownHours);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['cooldown_until'] = Variable<DateTime>(cooldownUntil);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || waitingUntil != null) {
      map['waiting_until'] = Variable<DateTime>(waitingUntil);
    }
    if (!nullToAbsent || purchasedAt != null) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt);
    }
    if (!nullToAbsent || releasedAt != null) {
      map['released_at'] = Variable<DateTime>(releasedAt);
    }
    if (!nullToAbsent || linkedTransactionId != null) {
      map['linked_transaction_id'] = Variable<int>(linkedTransactionId);
    }
    map['created_daily_safe_snapshot'] =
        Variable<int>(createdDailySafeSnapshot);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WishlistItemsTableCompanion toCompanion(bool nullToAbsent) {
    return WishlistItemsTableCompanion(
      id: Value(id),
      name: Value(name),
      price: Value(price),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      cooldownHours: Value(cooldownHours),
      createdAt: Value(createdAt),
      cooldownUntil: Value(cooldownUntil),
      status: Value(status),
      waitingUntil: waitingUntil == null && nullToAbsent
          ? const Value.absent()
          : Value(waitingUntil),
      purchasedAt: purchasedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(purchasedAt),
      releasedAt: releasedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(releasedAt),
      linkedTransactionId: linkedTransactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedTransactionId),
      createdDailySafeSnapshot: Value(createdDailySafeSnapshot),
      updatedAt: Value(updatedAt),
    );
  }

  factory WishlistItemsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistItemsTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      price: serializer.fromJson<int>(json['price']),
      url: serializer.fromJson<String?>(json['url']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      memo: serializer.fromJson<String?>(json['memo']),
      cooldownHours: serializer.fromJson<int>(json['cooldownHours']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      cooldownUntil: serializer.fromJson<DateTime>(json['cooldownUntil']),
      status: serializer.fromJson<String>(json['status']),
      waitingUntil: serializer.fromJson<DateTime?>(json['waitingUntil']),
      purchasedAt: serializer.fromJson<DateTime?>(json['purchasedAt']),
      releasedAt: serializer.fromJson<DateTime?>(json['releasedAt']),
      linkedTransactionId:
          serializer.fromJson<int?>(json['linkedTransactionId']),
      createdDailySafeSnapshot:
          serializer.fromJson<int>(json['createdDailySafeSnapshot']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'price': serializer.toJson<int>(price),
      'url': serializer.toJson<String?>(url),
      'imagePath': serializer.toJson<String?>(imagePath),
      'memo': serializer.toJson<String?>(memo),
      'cooldownHours': serializer.toJson<int>(cooldownHours),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'cooldownUntil': serializer.toJson<DateTime>(cooldownUntil),
      'status': serializer.toJson<String>(status),
      'waitingUntil': serializer.toJson<DateTime?>(waitingUntil),
      'purchasedAt': serializer.toJson<DateTime?>(purchasedAt),
      'releasedAt': serializer.toJson<DateTime?>(releasedAt),
      'linkedTransactionId': serializer.toJson<int?>(linkedTransactionId),
      'createdDailySafeSnapshot':
          serializer.toJson<int>(createdDailySafeSnapshot),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WishlistItemsTableData copyWith(
          {int? id,
          String? name,
          int? price,
          Value<String?> url = const Value.absent(),
          Value<String?> imagePath = const Value.absent(),
          Value<String?> memo = const Value.absent(),
          int? cooldownHours,
          DateTime? createdAt,
          DateTime? cooldownUntil,
          String? status,
          Value<DateTime?> waitingUntil = const Value.absent(),
          Value<DateTime?> purchasedAt = const Value.absent(),
          Value<DateTime?> releasedAt = const Value.absent(),
          Value<int?> linkedTransactionId = const Value.absent(),
          int? createdDailySafeSnapshot,
          DateTime? updatedAt}) =>
      WishlistItemsTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        price: price ?? this.price,
        url: url.present ? url.value : this.url,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
        memo: memo.present ? memo.value : this.memo,
        cooldownHours: cooldownHours ?? this.cooldownHours,
        createdAt: createdAt ?? this.createdAt,
        cooldownUntil: cooldownUntil ?? this.cooldownUntil,
        status: status ?? this.status,
        waitingUntil:
            waitingUntil.present ? waitingUntil.value : this.waitingUntil,
        purchasedAt: purchasedAt.present ? purchasedAt.value : this.purchasedAt,
        releasedAt: releasedAt.present ? releasedAt.value : this.releasedAt,
        linkedTransactionId: linkedTransactionId.present
            ? linkedTransactionId.value
            : this.linkedTransactionId,
        createdDailySafeSnapshot:
            createdDailySafeSnapshot ?? this.createdDailySafeSnapshot,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  WishlistItemsTableData copyWithCompanion(WishlistItemsTableCompanion data) {
    return WishlistItemsTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      price: data.price.present ? data.price.value : this.price,
      url: data.url.present ? data.url.value : this.url,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      memo: data.memo.present ? data.memo.value : this.memo,
      cooldownHours: data.cooldownHours.present
          ? data.cooldownHours.value
          : this.cooldownHours,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      cooldownUntil: data.cooldownUntil.present
          ? data.cooldownUntil.value
          : this.cooldownUntil,
      status: data.status.present ? data.status.value : this.status,
      waitingUntil: data.waitingUntil.present
          ? data.waitingUntil.value
          : this.waitingUntil,
      purchasedAt:
          data.purchasedAt.present ? data.purchasedAt.value : this.purchasedAt,
      releasedAt:
          data.releasedAt.present ? data.releasedAt.value : this.releasedAt,
      linkedTransactionId: data.linkedTransactionId.present
          ? data.linkedTransactionId.value
          : this.linkedTransactionId,
      createdDailySafeSnapshot: data.createdDailySafeSnapshot.present
          ? data.createdDailySafeSnapshot.value
          : this.createdDailySafeSnapshot,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistItemsTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('url: $url, ')
          ..write('imagePath: $imagePath, ')
          ..write('memo: $memo, ')
          ..write('cooldownHours: $cooldownHours, ')
          ..write('createdAt: $createdAt, ')
          ..write('cooldownUntil: $cooldownUntil, ')
          ..write('status: $status, ')
          ..write('waitingUntil: $waitingUntil, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('releasedAt: $releasedAt, ')
          ..write('linkedTransactionId: $linkedTransactionId, ')
          ..write('createdDailySafeSnapshot: $createdDailySafeSnapshot, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      price,
      url,
      imagePath,
      memo,
      cooldownHours,
      createdAt,
      cooldownUntil,
      status,
      waitingUntil,
      purchasedAt,
      releasedAt,
      linkedTransactionId,
      createdDailySafeSnapshot,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistItemsTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.price == this.price &&
          other.url == this.url &&
          other.imagePath == this.imagePath &&
          other.memo == this.memo &&
          other.cooldownHours == this.cooldownHours &&
          other.createdAt == this.createdAt &&
          other.cooldownUntil == this.cooldownUntil &&
          other.status == this.status &&
          other.waitingUntil == this.waitingUntil &&
          other.purchasedAt == this.purchasedAt &&
          other.releasedAt == this.releasedAt &&
          other.linkedTransactionId == this.linkedTransactionId &&
          other.createdDailySafeSnapshot == this.createdDailySafeSnapshot &&
          other.updatedAt == this.updatedAt);
}

class WishlistItemsTableCompanion
    extends UpdateCompanion<WishlistItemsTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> price;
  final Value<String?> url;
  final Value<String?> imagePath;
  final Value<String?> memo;
  final Value<int> cooldownHours;
  final Value<DateTime> createdAt;
  final Value<DateTime> cooldownUntil;
  final Value<String> status;
  final Value<DateTime?> waitingUntil;
  final Value<DateTime?> purchasedAt;
  final Value<DateTime?> releasedAt;
  final Value<int?> linkedTransactionId;
  final Value<int> createdDailySafeSnapshot;
  final Value<DateTime> updatedAt;
  const WishlistItemsTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.price = const Value.absent(),
    this.url = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.memo = const Value.absent(),
    this.cooldownHours = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.cooldownUntil = const Value.absent(),
    this.status = const Value.absent(),
    this.waitingUntil = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.releasedAt = const Value.absent(),
    this.linkedTransactionId = const Value.absent(),
    this.createdDailySafeSnapshot = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WishlistItemsTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int price,
    this.url = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.memo = const Value.absent(),
    this.cooldownHours = const Value.absent(),
    required DateTime createdAt,
    required DateTime cooldownUntil,
    required String status,
    this.waitingUntil = const Value.absent(),
    this.purchasedAt = const Value.absent(),
    this.releasedAt = const Value.absent(),
    this.linkedTransactionId = const Value.absent(),
    this.createdDailySafeSnapshot = const Value.absent(),
    required DateTime updatedAt,
  })  : name = Value(name),
        price = Value(price),
        createdAt = Value(createdAt),
        cooldownUntil = Value(cooldownUntil),
        status = Value(status),
        updatedAt = Value(updatedAt);
  static Insertable<WishlistItemsTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? price,
    Expression<String>? url,
    Expression<String>? imagePath,
    Expression<String>? memo,
    Expression<int>? cooldownHours,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? cooldownUntil,
    Expression<String>? status,
    Expression<DateTime>? waitingUntil,
    Expression<DateTime>? purchasedAt,
    Expression<DateTime>? releasedAt,
    Expression<int>? linkedTransactionId,
    Expression<int>? createdDailySafeSnapshot,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (price != null) 'price': price,
      if (url != null) 'url': url,
      if (imagePath != null) 'image_path': imagePath,
      if (memo != null) 'memo': memo,
      if (cooldownHours != null) 'cooldown_hours': cooldownHours,
      if (createdAt != null) 'created_at': createdAt,
      if (cooldownUntil != null) 'cooldown_until': cooldownUntil,
      if (status != null) 'status': status,
      if (waitingUntil != null) 'waiting_until': waitingUntil,
      if (purchasedAt != null) 'purchased_at': purchasedAt,
      if (releasedAt != null) 'released_at': releasedAt,
      if (linkedTransactionId != null)
        'linked_transaction_id': linkedTransactionId,
      if (createdDailySafeSnapshot != null)
        'created_daily_safe_snapshot': createdDailySafeSnapshot,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WishlistItemsTableCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? price,
      Value<String?>? url,
      Value<String?>? imagePath,
      Value<String?>? memo,
      Value<int>? cooldownHours,
      Value<DateTime>? createdAt,
      Value<DateTime>? cooldownUntil,
      Value<String>? status,
      Value<DateTime?>? waitingUntil,
      Value<DateTime?>? purchasedAt,
      Value<DateTime?>? releasedAt,
      Value<int?>? linkedTransactionId,
      Value<int>? createdDailySafeSnapshot,
      Value<DateTime>? updatedAt}) {
    return WishlistItemsTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      url: url ?? this.url,
      imagePath: imagePath ?? this.imagePath,
      memo: memo ?? this.memo,
      cooldownHours: cooldownHours ?? this.cooldownHours,
      createdAt: createdAt ?? this.createdAt,
      cooldownUntil: cooldownUntil ?? this.cooldownUntil,
      status: status ?? this.status,
      waitingUntil: waitingUntil ?? this.waitingUntil,
      purchasedAt: purchasedAt ?? this.purchasedAt,
      releasedAt: releasedAt ?? this.releasedAt,
      linkedTransactionId: linkedTransactionId ?? this.linkedTransactionId,
      createdDailySafeSnapshot:
          createdDailySafeSnapshot ?? this.createdDailySafeSnapshot,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (price.present) {
      map['price'] = Variable<int>(price.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (cooldownHours.present) {
      map['cooldown_hours'] = Variable<int>(cooldownHours.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (cooldownUntil.present) {
      map['cooldown_until'] = Variable<DateTime>(cooldownUntil.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (waitingUntil.present) {
      map['waiting_until'] = Variable<DateTime>(waitingUntil.value);
    }
    if (purchasedAt.present) {
      map['purchased_at'] = Variable<DateTime>(purchasedAt.value);
    }
    if (releasedAt.present) {
      map['released_at'] = Variable<DateTime>(releasedAt.value);
    }
    if (linkedTransactionId.present) {
      map['linked_transaction_id'] = Variable<int>(linkedTransactionId.value);
    }
    if (createdDailySafeSnapshot.present) {
      map['created_daily_safe_snapshot'] =
          Variable<int>(createdDailySafeSnapshot.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistItemsTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('price: $price, ')
          ..write('url: $url, ')
          ..write('imagePath: $imagePath, ')
          ..write('memo: $memo, ')
          ..write('cooldownHours: $cooldownHours, ')
          ..write('createdAt: $createdAt, ')
          ..write('cooldownUntil: $cooldownUntil, ')
          ..write('status: $status, ')
          ..write('waitingUntil: $waitingUntil, ')
          ..write('purchasedAt: $purchasedAt, ')
          ..write('releasedAt: $releasedAt, ')
          ..write('linkedTransactionId: $linkedTransactionId, ')
          ..write('createdDailySafeSnapshot: $createdDailySafeSnapshot, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WishlistEventsTableTable extends WishlistEventsTable
    with TableInfo<$WishlistEventsTableTable, WishlistEventsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistEventsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _wishlistItemIdMeta =
      const VerificationMeta('wishlistItemId');
  @override
  late final GeneratedColumn<int> wishlistItemId = GeneratedColumn<int>(
      'wishlist_item_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES wishlist_items_table (id)'));
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
      'event_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _eventAtMeta =
      const VerificationMeta('eventAt');
  @override
  late final GeneratedColumn<DateTime> eventAt = GeneratedColumn<DateTime>(
      'event_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _payloadJsonMeta =
      const VerificationMeta('payloadJson');
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
      'payload_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, wishlistItemId, eventType, eventAt, payloadJson];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_events_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<WishlistEventsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('wishlist_item_id')) {
      context.handle(
          _wishlistItemIdMeta,
          wishlistItemId.isAcceptableOrUnknown(
              data['wishlist_item_id']!, _wishlistItemIdMeta));
    } else if (isInserting) {
      context.missing(_wishlistItemIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('event_at')) {
      context.handle(_eventAtMeta,
          eventAt.isAcceptableOrUnknown(data['event_at']!, _eventAtMeta));
    } else if (isInserting) {
      context.missing(_eventAtMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
          _payloadJsonMeta,
          payloadJson.isAcceptableOrUnknown(
              data['payload_json']!, _payloadJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistEventsTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistEventsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      wishlistItemId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}wishlist_item_id'])!,
      eventType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      eventAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}event_at'])!,
      payloadJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload_json']),
    );
  }

  @override
  $WishlistEventsTableTable createAlias(String alias) {
    return $WishlistEventsTableTable(attachedDatabase, alias);
  }
}

class WishlistEventsTableData extends DataClass
    implements Insertable<WishlistEventsTableData> {
  final int id;
  final int wishlistItemId;
  final String eventType;
  final DateTime eventAt;
  final String? payloadJson;
  const WishlistEventsTableData(
      {required this.id,
      required this.wishlistItemId,
      required this.eventType,
      required this.eventAt,
      this.payloadJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['wishlist_item_id'] = Variable<int>(wishlistItemId);
    map['event_type'] = Variable<String>(eventType);
    map['event_at'] = Variable<DateTime>(eventAt);
    if (!nullToAbsent || payloadJson != null) {
      map['payload_json'] = Variable<String>(payloadJson);
    }
    return map;
  }

  WishlistEventsTableCompanion toCompanion(bool nullToAbsent) {
    return WishlistEventsTableCompanion(
      id: Value(id),
      wishlistItemId: Value(wishlistItemId),
      eventType: Value(eventType),
      eventAt: Value(eventAt),
      payloadJson: payloadJson == null && nullToAbsent
          ? const Value.absent()
          : Value(payloadJson),
    );
  }

  factory WishlistEventsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistEventsTableData(
      id: serializer.fromJson<int>(json['id']),
      wishlistItemId: serializer.fromJson<int>(json['wishlistItemId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      eventAt: serializer.fromJson<DateTime>(json['eventAt']),
      payloadJson: serializer.fromJson<String?>(json['payloadJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'wishlistItemId': serializer.toJson<int>(wishlistItemId),
      'eventType': serializer.toJson<String>(eventType),
      'eventAt': serializer.toJson<DateTime>(eventAt),
      'payloadJson': serializer.toJson<String?>(payloadJson),
    };
  }

  WishlistEventsTableData copyWith(
          {int? id,
          int? wishlistItemId,
          String? eventType,
          DateTime? eventAt,
          Value<String?> payloadJson = const Value.absent()}) =>
      WishlistEventsTableData(
        id: id ?? this.id,
        wishlistItemId: wishlistItemId ?? this.wishlistItemId,
        eventType: eventType ?? this.eventType,
        eventAt: eventAt ?? this.eventAt,
        payloadJson: payloadJson.present ? payloadJson.value : this.payloadJson,
      );
  WishlistEventsTableData copyWithCompanion(WishlistEventsTableCompanion data) {
    return WishlistEventsTableData(
      id: data.id.present ? data.id.value : this.id,
      wishlistItemId: data.wishlistItemId.present
          ? data.wishlistItemId.value
          : this.wishlistItemId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      eventAt: data.eventAt.present ? data.eventAt.value : this.eventAt,
      payloadJson:
          data.payloadJson.present ? data.payloadJson.value : this.payloadJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistEventsTableData(')
          ..write('id: $id, ')
          ..write('wishlistItemId: $wishlistItemId, ')
          ..write('eventType: $eventType, ')
          ..write('eventAt: $eventAt, ')
          ..write('payloadJson: $payloadJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wishlistItemId, eventType, eventAt, payloadJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistEventsTableData &&
          other.id == this.id &&
          other.wishlistItemId == this.wishlistItemId &&
          other.eventType == this.eventType &&
          other.eventAt == this.eventAt &&
          other.payloadJson == this.payloadJson);
}

class WishlistEventsTableCompanion
    extends UpdateCompanion<WishlistEventsTableData> {
  final Value<int> id;
  final Value<int> wishlistItemId;
  final Value<String> eventType;
  final Value<DateTime> eventAt;
  final Value<String?> payloadJson;
  const WishlistEventsTableCompanion({
    this.id = const Value.absent(),
    this.wishlistItemId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.eventAt = const Value.absent(),
    this.payloadJson = const Value.absent(),
  });
  WishlistEventsTableCompanion.insert({
    this.id = const Value.absent(),
    required int wishlistItemId,
    required String eventType,
    required DateTime eventAt,
    this.payloadJson = const Value.absent(),
  })  : wishlistItemId = Value(wishlistItemId),
        eventType = Value(eventType),
        eventAt = Value(eventAt);
  static Insertable<WishlistEventsTableData> custom({
    Expression<int>? id,
    Expression<int>? wishlistItemId,
    Expression<String>? eventType,
    Expression<DateTime>? eventAt,
    Expression<String>? payloadJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wishlistItemId != null) 'wishlist_item_id': wishlistItemId,
      if (eventType != null) 'event_type': eventType,
      if (eventAt != null) 'event_at': eventAt,
      if (payloadJson != null) 'payload_json': payloadJson,
    });
  }

  WishlistEventsTableCompanion copyWith(
      {Value<int>? id,
      Value<int>? wishlistItemId,
      Value<String>? eventType,
      Value<DateTime>? eventAt,
      Value<String?>? payloadJson}) {
    return WishlistEventsTableCompanion(
      id: id ?? this.id,
      wishlistItemId: wishlistItemId ?? this.wishlistItemId,
      eventType: eventType ?? this.eventType,
      eventAt: eventAt ?? this.eventAt,
      payloadJson: payloadJson ?? this.payloadJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (wishlistItemId.present) {
      map['wishlist_item_id'] = Variable<int>(wishlistItemId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (eventAt.present) {
      map['event_at'] = Variable<DateTime>(eventAt.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistEventsTableCompanion(')
          ..write('id: $id, ')
          ..write('wishlistItemId: $wishlistItemId, ')
          ..write('eventType: $eventType, ')
          ..write('eventAt: $eventAt, ')
          ..write('payloadJson: $payloadJson')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $AppSettingsTableTable appSettingsTable =
      $AppSettingsTableTable(this);
  late final $AnnualSpecialBudgetsTableTable annualSpecialBudgetsTable =
      $AnnualSpecialBudgetsTableTable(this);
  late final $BudgetsTableTable budgetsTable = $BudgetsTableTable(this);
  late final $CategoriesTableTable categoriesTable =
      $CategoriesTableTable(this);
  late final $SavingPlansTableTable savingPlansTable =
      $SavingPlansTableTable(this);
  late final $CategoryBudgetAllocationsTableTable
      categoryBudgetAllocationsTable =
      $CategoryBudgetAllocationsTableTable(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $UpcomingExpensesTableTable upcomingExpensesTable =
      $UpcomingExpensesTableTable(this);
  late final $WishlistItemsTableTable wishlistItemsTable =
      $WishlistItemsTableTable(this);
  late final $WishlistEventsTableTable wishlistEventsTable =
      $WishlistEventsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        appSettingsTable,
        annualSpecialBudgetsTable,
        budgetsTable,
        categoriesTable,
        savingPlansTable,
        categoryBudgetAllocationsTable,
        transactionsTable,
        upcomingExpensesTable,
        wishlistItemsTable,
        wishlistEventsTable
      ];
}

typedef $$AppSettingsTableTableCreateCompanionBuilder
    = AppSettingsTableCompanion Function({
  required String key,
  required String value,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$AppSettingsTableTableUpdateCompanionBuilder
    = AppSettingsTableCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$AppSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AppSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
      column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AppSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTableTable> {
  $$AppSettingsTableTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AppSettingsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AppSettingsTableTable,
    AppSettingsTableData,
    $$AppSettingsTableTableFilterComposer,
    $$AppSettingsTableTableOrderingComposer,
    $$AppSettingsTableTableAnnotationComposer,
    $$AppSettingsTableTableCreateCompanionBuilder,
    $$AppSettingsTableTableUpdateCompanionBuilder,
    (
      AppSettingsTableData,
      BaseReferences<_$AppDatabase, $AppSettingsTableTable,
          AppSettingsTableData>
    ),
    AppSettingsTableData,
    PrefetchHooks Function()> {
  $$AppSettingsTableTableTableManager(
      _$AppDatabase db, $AppSettingsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsTableCompanion(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String key,
            required String value,
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              AppSettingsTableCompanion.insert(
            key: key,
            value: value,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AppSettingsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $AppSettingsTableTable,
    AppSettingsTableData,
    $$AppSettingsTableTableFilterComposer,
    $$AppSettingsTableTableOrderingComposer,
    $$AppSettingsTableTableAnnotationComposer,
    $$AppSettingsTableTableCreateCompanionBuilder,
    $$AppSettingsTableTableUpdateCompanionBuilder,
    (
      AppSettingsTableData,
      BaseReferences<_$AppDatabase, $AppSettingsTableTable,
          AppSettingsTableData>
    ),
    AppSettingsTableData,
    PrefetchHooks Function()>;
typedef $$AnnualSpecialBudgetsTableTableCreateCompanionBuilder
    = AnnualSpecialBudgetsTableCompanion Function({
  Value<int> id,
  required int year,
  required int budgetAmount,
  Value<String> currencyCode,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$AnnualSpecialBudgetsTableTableUpdateCompanionBuilder
    = AnnualSpecialBudgetsTableCompanion Function({
  Value<int> id,
  Value<int> year,
  Value<int> budgetAmount,
  Value<String> currencyCode,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$AnnualSpecialBudgetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AnnualSpecialBudgetsTableTable> {
  $$AnnualSpecialBudgetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AnnualSpecialBudgetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AnnualSpecialBudgetsTableTable> {
  $$AnnualSpecialBudgetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AnnualSpecialBudgetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnnualSpecialBudgetsTableTable> {
  $$AnnualSpecialBudgetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AnnualSpecialBudgetsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $AnnualSpecialBudgetsTableTable,
    AnnualSpecialBudgetsTableData,
    $$AnnualSpecialBudgetsTableTableFilterComposer,
    $$AnnualSpecialBudgetsTableTableOrderingComposer,
    $$AnnualSpecialBudgetsTableTableAnnotationComposer,
    $$AnnualSpecialBudgetsTableTableCreateCompanionBuilder,
    $$AnnualSpecialBudgetsTableTableUpdateCompanionBuilder,
    (
      AnnualSpecialBudgetsTableData,
      BaseReferences<_$AppDatabase, $AnnualSpecialBudgetsTableTable,
          AnnualSpecialBudgetsTableData>
    ),
    AnnualSpecialBudgetsTableData,
    PrefetchHooks Function()> {
  $$AnnualSpecialBudgetsTableTableTableManager(
      _$AppDatabase db, $AnnualSpecialBudgetsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnnualSpecialBudgetsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$AnnualSpecialBudgetsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnnualSpecialBudgetsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<int> budgetAmount = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AnnualSpecialBudgetsTableCompanion(
            id: id,
            year: year,
            budgetAmount: budgetAmount,
            currencyCode: currencyCode,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int year,
            required int budgetAmount,
            Value<String> currencyCode = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              AnnualSpecialBudgetsTableCompanion.insert(
            id: id,
            year: year,
            budgetAmount: budgetAmount,
            currencyCode: currencyCode,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AnnualSpecialBudgetsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $AnnualSpecialBudgetsTableTable,
        AnnualSpecialBudgetsTableData,
        $$AnnualSpecialBudgetsTableTableFilterComposer,
        $$AnnualSpecialBudgetsTableTableOrderingComposer,
        $$AnnualSpecialBudgetsTableTableAnnotationComposer,
        $$AnnualSpecialBudgetsTableTableCreateCompanionBuilder,
        $$AnnualSpecialBudgetsTableTableUpdateCompanionBuilder,
        (
          AnnualSpecialBudgetsTableData,
          BaseReferences<_$AppDatabase, $AnnualSpecialBudgetsTableTable,
              AnnualSpecialBudgetsTableData>
        ),
        AnnualSpecialBudgetsTableData,
        PrefetchHooks Function()>;
typedef $$BudgetsTableTableCreateCompanionBuilder = BudgetsTableCompanion
    Function({
  Value<int> id,
  required int monthlyBudget,
  Value<String> currencyCode,
  required String effectiveMonth,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$BudgetsTableTableUpdateCompanionBuilder = BudgetsTableCompanion
    Function({
  Value<int> id,
  Value<int> monthlyBudget,
  Value<String> currencyCode,
  Value<String> effectiveMonth,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$BudgetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get monthlyBudget => $composableBuilder(
      column: $table.monthlyBudget, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get effectiveMonth => $composableBuilder(
      column: $table.effectiveMonth,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$BudgetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get monthlyBudget => $composableBuilder(
      column: $table.monthlyBudget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get effectiveMonth => $composableBuilder(
      column: $table.effectiveMonth,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$BudgetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetsTableTable> {
  $$BudgetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get monthlyBudget => $composableBuilder(
      column: $table.monthlyBudget, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
      column: $table.currencyCode, builder: (column) => column);

  GeneratedColumn<String> get effectiveMonth => $composableBuilder(
      column: $table.effectiveMonth, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BudgetsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BudgetsTableTable,
    BudgetsTableData,
    $$BudgetsTableTableFilterComposer,
    $$BudgetsTableTableOrderingComposer,
    $$BudgetsTableTableAnnotationComposer,
    $$BudgetsTableTableCreateCompanionBuilder,
    $$BudgetsTableTableUpdateCompanionBuilder,
    (
      BudgetsTableData,
      BaseReferences<_$AppDatabase, $BudgetsTableTable, BudgetsTableData>
    ),
    BudgetsTableData,
    PrefetchHooks Function()> {
  $$BudgetsTableTableTableManager(_$AppDatabase db, $BudgetsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> monthlyBudget = const Value.absent(),
            Value<String> currencyCode = const Value.absent(),
            Value<String> effectiveMonth = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              BudgetsTableCompanion(
            id: id,
            monthlyBudget: monthlyBudget,
            currencyCode: currencyCode,
            effectiveMonth: effectiveMonth,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int monthlyBudget,
            Value<String> currencyCode = const Value.absent(),
            required String effectiveMonth,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              BudgetsTableCompanion.insert(
            id: id,
            monthlyBudget: monthlyBudget,
            currencyCode: currencyCode,
            effectiveMonth: effectiveMonth,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BudgetsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BudgetsTableTable,
    BudgetsTableData,
    $$BudgetsTableTableFilterComposer,
    $$BudgetsTableTableOrderingComposer,
    $$BudgetsTableTableAnnotationComposer,
    $$BudgetsTableTableCreateCompanionBuilder,
    $$BudgetsTableTableUpdateCompanionBuilder,
    (
      BudgetsTableData,
      BaseReferences<_$AppDatabase, $BudgetsTableTable, BudgetsTableData>
    ),
    BudgetsTableData,
    PrefetchHooks Function()>;
typedef $$CategoriesTableTableCreateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<int> id,
  required String name,
  Value<String> icon,
  Value<String?> description,
  Value<String?> colorToken,
  required int sortOrder,
  Value<bool> isActive,
  Value<bool> isDefault,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$CategoriesTableTableUpdateCompanionBuilder = CategoriesTableCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> icon,
  Value<String?> description,
  Value<String?> colorToken,
  Value<int> sortOrder,
  Value<bool> isActive,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$CategoriesTableTableReferences extends BaseReferences<
    _$AppDatabase, $CategoriesTableTable, CategoriesTableData> {
  $$CategoriesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CategoryBudgetAllocationsTableTable,
          List<CategoryBudgetAllocationsTableData>>
      _categoryBudgetAllocationsTableRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.categoryBudgetAllocationsTable,
              aliasName:
                  'categories_table__id__category_budget_allocations_table__category_id');

  $$CategoryBudgetAllocationsTableTableProcessedTableManager
      get categoryBudgetAllocationsTableRefs {
    final manager = $$CategoryBudgetAllocationsTableTableTableManager(
            $_db, $_db.categoryBudgetAllocationsTable)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_categoryBudgetAllocationsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$TransactionsTableTable,
      List<TransactionsTableData>> _transactionsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.transactionsTable,
          aliasName: 'categories_table__id__transactions_table__category_id');

  $$TransactionsTableTableProcessedTableManager get transactionsTableRefs {
    final manager =
        $$TransactionsTableTableTableManager($_db, $_db.transactionsTable)
            .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_transactionsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$UpcomingExpensesTableTable,
      List<UpcomingExpensesTableData>> _upcomingExpensesTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.upcomingExpensesTable,
          aliasName:
              'categories_table__id__upcoming_expenses_table__category_id');

  $$UpcomingExpensesTableTableProcessedTableManager
      get upcomingExpensesTableRefs {
    final manager = $$UpcomingExpensesTableTableTableManager(
            $_db, $_db.upcomingExpensesTable)
        .filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_upcomingExpensesTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CategoriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get colorToken => $composableBuilder(
      column: $table.colorToken, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> categoryBudgetAllocationsTableRefs(
      Expression<bool> Function(
              $$CategoryBudgetAllocationsTableTableFilterComposer f)
          f) {
    final $$CategoryBudgetAllocationsTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.categoryBudgetAllocationsTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CategoryBudgetAllocationsTableTableFilterComposer(
                  $db: $db,
                  $table: $db.categoryBudgetAllocationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> transactionsTableRefs(
      Expression<bool> Function($$TransactionsTableTableFilterComposer f) f) {
    final $$TransactionsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.transactionsTable,
        getReferencedColumn: (t) => t.categoryId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TransactionsTableTableFilterComposer(
              $db: $db,
              $table: $db.transactionsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> upcomingExpensesTableRefs(
      Expression<bool> Function($$UpcomingExpensesTableTableFilterComposer f)
          f) {
    final $$UpcomingExpensesTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.upcomingExpensesTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UpcomingExpensesTableTableFilterComposer(
                  $db: $db,
                  $table: $db.upcomingExpensesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get colorToken => $composableBuilder(
      column: $table.colorToken, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sortOrder => $composableBuilder(
      column: $table.sortOrder, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$CategoriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoriesTableTable> {
  $$CategoriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get colorToken => $composableBuilder(
      column: $table.colorToken, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> categoryBudgetAllocationsTableRefs<T extends Object>(
      Expression<T> Function(
              $$CategoryBudgetAllocationsTableTableAnnotationComposer a)
          f) {
    final $$CategoryBudgetAllocationsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.categoryBudgetAllocationsTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$CategoryBudgetAllocationsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.categoryBudgetAllocationsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> transactionsTableRefs<T extends Object>(
      Expression<T> Function($$TransactionsTableTableAnnotationComposer a) f) {
    final $$TransactionsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.transactionsTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$TransactionsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.transactionsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> upcomingExpensesTableRefs<T extends Object>(
      Expression<T> Function($$UpcomingExpensesTableTableAnnotationComposer a)
          f) {
    final $$UpcomingExpensesTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.upcomingExpensesTable,
            getReferencedColumn: (t) => t.categoryId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$UpcomingExpensesTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.upcomingExpensesTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$CategoriesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoriesTableData,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (CategoriesTableData, $$CategoriesTableTableReferences),
    CategoriesTableData,
    PrefetchHooks Function(
        {bool categoryBudgetAllocationsTableRefs,
        bool transactionsTableRefs,
        bool upcomingExpensesTableRefs})> {
  $$CategoriesTableTableTableManager(
      _$AppDatabase db, $CategoriesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> colorToken = const Value.absent(),
            Value<int> sortOrder = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CategoriesTableCompanion(
            id: id,
            name: name,
            icon: icon,
            description: description,
            colorToken: colorToken,
            sortOrder: sortOrder,
            isActive: isActive,
            isDefault: isDefault,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<String> icon = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> colorToken = const Value.absent(),
            required int sortOrder,
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              CategoriesTableCompanion.insert(
            id: id,
            name: name,
            icon: icon,
            description: description,
            colorToken: colorToken,
            sortOrder: sortOrder,
            isActive: isActive,
            isDefault: isDefault,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoriesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {categoryBudgetAllocationsTableRefs = false,
              transactionsTableRefs = false,
              upcomingExpensesTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (categoryBudgetAllocationsTableRefs)
                  db.categoryBudgetAllocationsTable,
                if (transactionsTableRefs) db.transactionsTable,
                if (upcomingExpensesTableRefs) db.upcomingExpensesTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (categoryBudgetAllocationsTableRefs)
                    await $_getPrefetchedData<
                            CategoriesTableData,
                            $CategoriesTableTable,
                            CategoryBudgetAllocationsTableData>(
                        currentTable: table,
                        referencedTable: $$CategoriesTableTableReferences
                            ._categoryBudgetAllocationsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableTableReferences(db, table, p0)
                                .categoryBudgetAllocationsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items),
                  if (transactionsTableRefs)
                    await $_getPrefetchedData<CategoriesTableData,
                            $CategoriesTableTable, TransactionsTableData>(
                        currentTable: table,
                        referencedTable: $$CategoriesTableTableReferences
                            ._transactionsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableTableReferences(db, table, p0)
                                .transactionsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items),
                  if (upcomingExpensesTableRefs)
                    await $_getPrefetchedData<CategoriesTableData,
                            $CategoriesTableTable, UpcomingExpensesTableData>(
                        currentTable: table,
                        referencedTable: $$CategoriesTableTableReferences
                            ._upcomingExpensesTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CategoriesTableTableReferences(db, table, p0)
                                .upcomingExpensesTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.categoryId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CategoriesTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CategoriesTableTable,
    CategoriesTableData,
    $$CategoriesTableTableFilterComposer,
    $$CategoriesTableTableOrderingComposer,
    $$CategoriesTableTableAnnotationComposer,
    $$CategoriesTableTableCreateCompanionBuilder,
    $$CategoriesTableTableUpdateCompanionBuilder,
    (CategoriesTableData, $$CategoriesTableTableReferences),
    CategoriesTableData,
    PrefetchHooks Function(
        {bool categoryBudgetAllocationsTableRefs,
        bool transactionsTableRefs,
        bool upcomingExpensesTableRefs})>;
typedef $$SavingPlansTableTableCreateCompanionBuilder
    = SavingPlansTableCompanion Function({
  Value<int> id,
  required String yearMonth,
  required int salaryAmount,
  Value<String> etfLabel,
  required int etfTarget,
  Value<String> annualSpecialLabel,
  required int annualSpecialTarget,
  Value<String> livingLabel,
  required int livingBudgetTarget,
  Value<String> housingLabel,
  required int housingTarget,
  Value<String> fixedCostLabel,
  required int fixedCostTarget,
  Value<DateTime?> etfDoneAt,
  Value<DateTime?> annualSpecialDoneAt,
  Value<DateTime?> livingDoneAt,
  Value<DateTime?> housingDoneAt,
  Value<DateTime?> fixedCostDoneAt,
  Value<int?> sweepAmount,
  Value<DateTime?> sweptAt,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$SavingPlansTableTableUpdateCompanionBuilder
    = SavingPlansTableCompanion Function({
  Value<int> id,
  Value<String> yearMonth,
  Value<int> salaryAmount,
  Value<String> etfLabel,
  Value<int> etfTarget,
  Value<String> annualSpecialLabel,
  Value<int> annualSpecialTarget,
  Value<String> livingLabel,
  Value<int> livingBudgetTarget,
  Value<String> housingLabel,
  Value<int> housingTarget,
  Value<String> fixedCostLabel,
  Value<int> fixedCostTarget,
  Value<DateTime?> etfDoneAt,
  Value<DateTime?> annualSpecialDoneAt,
  Value<DateTime?> livingDoneAt,
  Value<DateTime?> housingDoneAt,
  Value<DateTime?> fixedCostDoneAt,
  Value<int?> sweepAmount,
  Value<DateTime?> sweptAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$SavingPlansTableTableFilterComposer
    extends Composer<_$AppDatabase, $SavingPlansTableTable> {
  $$SavingPlansTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get yearMonth => $composableBuilder(
      column: $table.yearMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get salaryAmount => $composableBuilder(
      column: $table.salaryAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get etfLabel => $composableBuilder(
      column: $table.etfLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get etfTarget => $composableBuilder(
      column: $table.etfTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get annualSpecialLabel => $composableBuilder(
      column: $table.annualSpecialLabel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get annualSpecialTarget => $composableBuilder(
      column: $table.annualSpecialTarget,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get livingLabel => $composableBuilder(
      column: $table.livingLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get livingBudgetTarget => $composableBuilder(
      column: $table.livingBudgetTarget,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get housingLabel => $composableBuilder(
      column: $table.housingLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get housingTarget => $composableBuilder(
      column: $table.housingTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fixedCostLabel => $composableBuilder(
      column: $table.fixedCostLabel,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get fixedCostTarget => $composableBuilder(
      column: $table.fixedCostTarget,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get etfDoneAt => $composableBuilder(
      column: $table.etfDoneAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get annualSpecialDoneAt => $composableBuilder(
      column: $table.annualSpecialDoneAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get livingDoneAt => $composableBuilder(
      column: $table.livingDoneAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get housingDoneAt => $composableBuilder(
      column: $table.housingDoneAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fixedCostDoneAt => $composableBuilder(
      column: $table.fixedCostDoneAt,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sweepAmount => $composableBuilder(
      column: $table.sweepAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sweptAt => $composableBuilder(
      column: $table.sweptAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$SavingPlansTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SavingPlansTableTable> {
  $$SavingPlansTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get yearMonth => $composableBuilder(
      column: $table.yearMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get salaryAmount => $composableBuilder(
      column: $table.salaryAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get etfLabel => $composableBuilder(
      column: $table.etfLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get etfTarget => $composableBuilder(
      column: $table.etfTarget, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get annualSpecialLabel => $composableBuilder(
      column: $table.annualSpecialLabel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get annualSpecialTarget => $composableBuilder(
      column: $table.annualSpecialTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get livingLabel => $composableBuilder(
      column: $table.livingLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get livingBudgetTarget => $composableBuilder(
      column: $table.livingBudgetTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get housingLabel => $composableBuilder(
      column: $table.housingLabel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get housingTarget => $composableBuilder(
      column: $table.housingTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fixedCostLabel => $composableBuilder(
      column: $table.fixedCostLabel,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get fixedCostTarget => $composableBuilder(
      column: $table.fixedCostTarget,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get etfDoneAt => $composableBuilder(
      column: $table.etfDoneAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get annualSpecialDoneAt => $composableBuilder(
      column: $table.annualSpecialDoneAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get livingDoneAt => $composableBuilder(
      column: $table.livingDoneAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get housingDoneAt => $composableBuilder(
      column: $table.housingDoneAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fixedCostDoneAt => $composableBuilder(
      column: $table.fixedCostDoneAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sweepAmount => $composableBuilder(
      column: $table.sweepAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sweptAt => $composableBuilder(
      column: $table.sweptAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SavingPlansTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SavingPlansTableTable> {
  $$SavingPlansTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get yearMonth =>
      $composableBuilder(column: $table.yearMonth, builder: (column) => column);

  GeneratedColumn<int> get salaryAmount => $composableBuilder(
      column: $table.salaryAmount, builder: (column) => column);

  GeneratedColumn<String> get etfLabel =>
      $composableBuilder(column: $table.etfLabel, builder: (column) => column);

  GeneratedColumn<int> get etfTarget =>
      $composableBuilder(column: $table.etfTarget, builder: (column) => column);

  GeneratedColumn<String> get annualSpecialLabel => $composableBuilder(
      column: $table.annualSpecialLabel, builder: (column) => column);

  GeneratedColumn<int> get annualSpecialTarget => $composableBuilder(
      column: $table.annualSpecialTarget, builder: (column) => column);

  GeneratedColumn<String> get livingLabel => $composableBuilder(
      column: $table.livingLabel, builder: (column) => column);

  GeneratedColumn<int> get livingBudgetTarget => $composableBuilder(
      column: $table.livingBudgetTarget, builder: (column) => column);

  GeneratedColumn<String> get housingLabel => $composableBuilder(
      column: $table.housingLabel, builder: (column) => column);

  GeneratedColumn<int> get housingTarget => $composableBuilder(
      column: $table.housingTarget, builder: (column) => column);

  GeneratedColumn<String> get fixedCostLabel => $composableBuilder(
      column: $table.fixedCostLabel, builder: (column) => column);

  GeneratedColumn<int> get fixedCostTarget => $composableBuilder(
      column: $table.fixedCostTarget, builder: (column) => column);

  GeneratedColumn<DateTime> get etfDoneAt =>
      $composableBuilder(column: $table.etfDoneAt, builder: (column) => column);

  GeneratedColumn<DateTime> get annualSpecialDoneAt => $composableBuilder(
      column: $table.annualSpecialDoneAt, builder: (column) => column);

  GeneratedColumn<DateTime> get livingDoneAt => $composableBuilder(
      column: $table.livingDoneAt, builder: (column) => column);

  GeneratedColumn<DateTime> get housingDoneAt => $composableBuilder(
      column: $table.housingDoneAt, builder: (column) => column);

  GeneratedColumn<DateTime> get fixedCostDoneAt => $composableBuilder(
      column: $table.fixedCostDoneAt, builder: (column) => column);

  GeneratedColumn<int> get sweepAmount => $composableBuilder(
      column: $table.sweepAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get sweptAt =>
      $composableBuilder(column: $table.sweptAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SavingPlansTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SavingPlansTableTable,
    SavingPlansTableData,
    $$SavingPlansTableTableFilterComposer,
    $$SavingPlansTableTableOrderingComposer,
    $$SavingPlansTableTableAnnotationComposer,
    $$SavingPlansTableTableCreateCompanionBuilder,
    $$SavingPlansTableTableUpdateCompanionBuilder,
    (
      SavingPlansTableData,
      BaseReferences<_$AppDatabase, $SavingPlansTableTable,
          SavingPlansTableData>
    ),
    SavingPlansTableData,
    PrefetchHooks Function()> {
  $$SavingPlansTableTableTableManager(
      _$AppDatabase db, $SavingPlansTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SavingPlansTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SavingPlansTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SavingPlansTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> yearMonth = const Value.absent(),
            Value<int> salaryAmount = const Value.absent(),
            Value<String> etfLabel = const Value.absent(),
            Value<int> etfTarget = const Value.absent(),
            Value<String> annualSpecialLabel = const Value.absent(),
            Value<int> annualSpecialTarget = const Value.absent(),
            Value<String> livingLabel = const Value.absent(),
            Value<int> livingBudgetTarget = const Value.absent(),
            Value<String> housingLabel = const Value.absent(),
            Value<int> housingTarget = const Value.absent(),
            Value<String> fixedCostLabel = const Value.absent(),
            Value<int> fixedCostTarget = const Value.absent(),
            Value<DateTime?> etfDoneAt = const Value.absent(),
            Value<DateTime?> annualSpecialDoneAt = const Value.absent(),
            Value<DateTime?> livingDoneAt = const Value.absent(),
            Value<DateTime?> housingDoneAt = const Value.absent(),
            Value<DateTime?> fixedCostDoneAt = const Value.absent(),
            Value<int?> sweepAmount = const Value.absent(),
            Value<DateTime?> sweptAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              SavingPlansTableCompanion(
            id: id,
            yearMonth: yearMonth,
            salaryAmount: salaryAmount,
            etfLabel: etfLabel,
            etfTarget: etfTarget,
            annualSpecialLabel: annualSpecialLabel,
            annualSpecialTarget: annualSpecialTarget,
            livingLabel: livingLabel,
            livingBudgetTarget: livingBudgetTarget,
            housingLabel: housingLabel,
            housingTarget: housingTarget,
            fixedCostLabel: fixedCostLabel,
            fixedCostTarget: fixedCostTarget,
            etfDoneAt: etfDoneAt,
            annualSpecialDoneAt: annualSpecialDoneAt,
            livingDoneAt: livingDoneAt,
            housingDoneAt: housingDoneAt,
            fixedCostDoneAt: fixedCostDoneAt,
            sweepAmount: sweepAmount,
            sweptAt: sweptAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String yearMonth,
            required int salaryAmount,
            Value<String> etfLabel = const Value.absent(),
            required int etfTarget,
            Value<String> annualSpecialLabel = const Value.absent(),
            required int annualSpecialTarget,
            Value<String> livingLabel = const Value.absent(),
            required int livingBudgetTarget,
            Value<String> housingLabel = const Value.absent(),
            required int housingTarget,
            Value<String> fixedCostLabel = const Value.absent(),
            required int fixedCostTarget,
            Value<DateTime?> etfDoneAt = const Value.absent(),
            Value<DateTime?> annualSpecialDoneAt = const Value.absent(),
            Value<DateTime?> livingDoneAt = const Value.absent(),
            Value<DateTime?> housingDoneAt = const Value.absent(),
            Value<DateTime?> fixedCostDoneAt = const Value.absent(),
            Value<int?> sweepAmount = const Value.absent(),
            Value<DateTime?> sweptAt = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              SavingPlansTableCompanion.insert(
            id: id,
            yearMonth: yearMonth,
            salaryAmount: salaryAmount,
            etfLabel: etfLabel,
            etfTarget: etfTarget,
            annualSpecialLabel: annualSpecialLabel,
            annualSpecialTarget: annualSpecialTarget,
            livingLabel: livingLabel,
            livingBudgetTarget: livingBudgetTarget,
            housingLabel: housingLabel,
            housingTarget: housingTarget,
            fixedCostLabel: fixedCostLabel,
            fixedCostTarget: fixedCostTarget,
            etfDoneAt: etfDoneAt,
            annualSpecialDoneAt: annualSpecialDoneAt,
            livingDoneAt: livingDoneAt,
            housingDoneAt: housingDoneAt,
            fixedCostDoneAt: fixedCostDoneAt,
            sweepAmount: sweepAmount,
            sweptAt: sweptAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SavingPlansTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SavingPlansTableTable,
    SavingPlansTableData,
    $$SavingPlansTableTableFilterComposer,
    $$SavingPlansTableTableOrderingComposer,
    $$SavingPlansTableTableAnnotationComposer,
    $$SavingPlansTableTableCreateCompanionBuilder,
    $$SavingPlansTableTableUpdateCompanionBuilder,
    (
      SavingPlansTableData,
      BaseReferences<_$AppDatabase, $SavingPlansTableTable,
          SavingPlansTableData>
    ),
    SavingPlansTableData,
    PrefetchHooks Function()>;
typedef $$CategoryBudgetAllocationsTableTableCreateCompanionBuilder
    = CategoryBudgetAllocationsTableCompanion Function({
  Value<int> id,
  required int categoryId,
  required String yearMonth,
  required int budgetAmount,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$CategoryBudgetAllocationsTableTableUpdateCompanionBuilder
    = CategoryBudgetAllocationsTableCompanion Function({
  Value<int> id,
  Value<int> categoryId,
  Value<String> yearMonth,
  Value<int> budgetAmount,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$CategoryBudgetAllocationsTableTableReferences
    extends BaseReferences<_$AppDatabase, $CategoryBudgetAllocationsTableTable,
        CategoryBudgetAllocationsTableData> {
  $$CategoryBudgetAllocationsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
          'category_budget_allocations_table__category_id__categories_table__id');

  $$CategoriesTableTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager =
        $$CategoriesTableTableTableManager($_db, $_db.categoriesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CategoryBudgetAllocationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryBudgetAllocationsTableTable> {
  $$CategoryBudgetAllocationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get yearMonth => $composableBuilder(
      column: $table.yearMonth, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableFilterComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryBudgetAllocationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryBudgetAllocationsTableTable> {
  $$CategoryBudgetAllocationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get yearMonth => $composableBuilder(
      column: $table.yearMonth, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableOrderingComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryBudgetAllocationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryBudgetAllocationsTableTable> {
  $$CategoryBudgetAllocationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get yearMonth =>
      $composableBuilder(column: $table.yearMonth, builder: (column) => column);

  GeneratedColumn<int> get budgetAmount => $composableBuilder(
      column: $table.budgetAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$CategoryBudgetAllocationsTableTableTableManager
    extends RootTableManager<
        _$AppDatabase,
        $CategoryBudgetAllocationsTableTable,
        CategoryBudgetAllocationsTableData,
        $$CategoryBudgetAllocationsTableTableFilterComposer,
        $$CategoryBudgetAllocationsTableTableOrderingComposer,
        $$CategoryBudgetAllocationsTableTableAnnotationComposer,
        $$CategoryBudgetAllocationsTableTableCreateCompanionBuilder,
        $$CategoryBudgetAllocationsTableTableUpdateCompanionBuilder,
        (
          CategoryBudgetAllocationsTableData,
          $$CategoryBudgetAllocationsTableTableReferences
        ),
        CategoryBudgetAllocationsTableData,
        PrefetchHooks Function({bool categoryId})> {
  $$CategoryBudgetAllocationsTableTableTableManager(
      _$AppDatabase db, $CategoryBudgetAllocationsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryBudgetAllocationsTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryBudgetAllocationsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryBudgetAllocationsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> categoryId = const Value.absent(),
            Value<String> yearMonth = const Value.absent(),
            Value<int> budgetAmount = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              CategoryBudgetAllocationsTableCompanion(
            id: id,
            categoryId: categoryId,
            yearMonth: yearMonth,
            budgetAmount: budgetAmount,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int categoryId,
            required String yearMonth,
            required int budgetAmount,
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              CategoryBudgetAllocationsTableCompanion.insert(
            id: id,
            categoryId: categoryId,
            yearMonth: yearMonth,
            budgetAmount: budgetAmount,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CategoryBudgetAllocationsTableTableReferences(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$CategoryBudgetAllocationsTableTableReferences
                            ._categoryIdTable(db),
                    referencedColumn:
                        $$CategoryBudgetAllocationsTableTableReferences
                            ._categoryIdTable(db)
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
        ));
}

typedef $$CategoryBudgetAllocationsTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $CategoryBudgetAllocationsTableTable,
        CategoryBudgetAllocationsTableData,
        $$CategoryBudgetAllocationsTableTableFilterComposer,
        $$CategoryBudgetAllocationsTableTableOrderingComposer,
        $$CategoryBudgetAllocationsTableTableAnnotationComposer,
        $$CategoryBudgetAllocationsTableTableCreateCompanionBuilder,
        $$CategoryBudgetAllocationsTableTableUpdateCompanionBuilder,
        (
          CategoryBudgetAllocationsTableData,
          $$CategoryBudgetAllocationsTableTableReferences
        ),
        CategoryBudgetAllocationsTableData,
        PrefetchHooks Function({bool categoryId})>;
typedef $$TransactionsTableTableCreateCompanionBuilder
    = TransactionsTableCompanion Function({
  Value<int> id,
  required int amount,
  required String type,
  Value<String> budgetType,
  Value<String?> specialCategory,
  Value<String> paymentMethod,
  Value<DateTime?> prepaidAt,
  Value<int?> categoryId,
  required DateTime occurredAt,
  Value<String?> memo,
  Value<String> source,
  Value<int?> linkedUpcomingExpenseId,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> deletedAt,
});
typedef $$TransactionsTableTableUpdateCompanionBuilder
    = TransactionsTableCompanion Function({
  Value<int> id,
  Value<int> amount,
  Value<String> type,
  Value<String> budgetType,
  Value<String?> specialCategory,
  Value<String> paymentMethod,
  Value<DateTime?> prepaidAt,
  Value<int?> categoryId,
  Value<DateTime> occurredAt,
  Value<String?> memo,
  Value<String> source,
  Value<int?> linkedUpcomingExpenseId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
});

final class $$TransactionsTableTableReferences extends BaseReferences<
    _$AppDatabase, $TransactionsTableTable, TransactionsTableData> {
  $$TransactionsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable
          .createAlias('transactions_table__category_id__categories_table__id');

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager =
        $$CategoriesTableTableTableManager($_db, $_db.categoriesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get budgetType => $composableBuilder(
      column: $table.budgetType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialCategory => $composableBuilder(
      column: $table.specialCategory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get prepaidAt => $composableBuilder(
      column: $table.prepaidAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get linkedUpcomingExpenseId => $composableBuilder(
      column: $table.linkedUpcomingExpenseId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableFilterComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get budgetType => $composableBuilder(
      column: $table.budgetType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialCategory => $composableBuilder(
      column: $table.specialCategory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get prepaidAt => $composableBuilder(
      column: $table.prepaidAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get linkedUpcomingExpenseId => $composableBuilder(
      column: $table.linkedUpcomingExpenseId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableOrderingComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get budgetType => $composableBuilder(
      column: $table.budgetType, builder: (column) => column);

  GeneratedColumn<String> get specialCategory => $composableBuilder(
      column: $table.specialCategory, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<DateTime> get prepaidAt =>
      $composableBuilder(column: $table.prepaidAt, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get linkedUpcomingExpenseId => $composableBuilder(
      column: $table.linkedUpcomingExpenseId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TransactionsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTableTable,
    TransactionsTableData,
    $$TransactionsTableTableFilterComposer,
    $$TransactionsTableTableOrderingComposer,
    $$TransactionsTableTableAnnotationComposer,
    $$TransactionsTableTableCreateCompanionBuilder,
    $$TransactionsTableTableUpdateCompanionBuilder,
    (TransactionsTableData, $$TransactionsTableTableReferences),
    TransactionsTableData,
    PrefetchHooks Function({bool categoryId})> {
  $$TransactionsTableTableTableManager(
      _$AppDatabase db, $TransactionsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> budgetType = const Value.absent(),
            Value<String?> specialCategory = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<DateTime?> prepaidAt = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<int?> linkedUpcomingExpenseId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              TransactionsTableCompanion(
            id: id,
            amount: amount,
            type: type,
            budgetType: budgetType,
            specialCategory: specialCategory,
            paymentMethod: paymentMethod,
            prepaidAt: prepaidAt,
            categoryId: categoryId,
            occurredAt: occurredAt,
            memo: memo,
            source: source,
            linkedUpcomingExpenseId: linkedUpcomingExpenseId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int amount,
            required String type,
            Value<String> budgetType = const Value.absent(),
            Value<String?> specialCategory = const Value.absent(),
            Value<String> paymentMethod = const Value.absent(),
            Value<DateTime?> prepaidAt = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            required DateTime occurredAt,
            Value<String?> memo = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<int?> linkedUpcomingExpenseId = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
            Value<DateTime?> deletedAt = const Value.absent(),
          }) =>
              TransactionsTableCompanion.insert(
            id: id,
            amount: amount,
            type: type,
            budgetType: budgetType,
            specialCategory: specialCategory,
            paymentMethod: paymentMethod,
            prepaidAt: prepaidAt,
            categoryId: categoryId,
            occurredAt: occurredAt,
            memo: memo,
            source: source,
            linkedUpcomingExpenseId: linkedUpcomingExpenseId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$TransactionsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable:
                        $$TransactionsTableTableReferences._categoryIdTable(db),
                    referencedColumn: $$TransactionsTableTableReferences
                        ._categoryIdTable(db)
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
        ));
}

typedef $$TransactionsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTableTable,
    TransactionsTableData,
    $$TransactionsTableTableFilterComposer,
    $$TransactionsTableTableOrderingComposer,
    $$TransactionsTableTableAnnotationComposer,
    $$TransactionsTableTableCreateCompanionBuilder,
    $$TransactionsTableTableUpdateCompanionBuilder,
    (TransactionsTableData, $$TransactionsTableTableReferences),
    TransactionsTableData,
    PrefetchHooks Function({bool categoryId})>;
typedef $$UpcomingExpensesTableTableCreateCompanionBuilder
    = UpcomingExpensesTableCompanion Function({
  Value<int> id,
  required String title,
  required int amount,
  required DateTime scheduledDate,
  Value<int?> categoryId,
  Value<bool> isRecurring,
  Value<String> recurrenceType,
  Value<int?> recurrenceInterval,
  Value<bool> isPaid,
  Value<int?> paidTransactionId,
  Value<String?> note,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$UpcomingExpensesTableTableUpdateCompanionBuilder
    = UpcomingExpensesTableCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<int> amount,
  Value<DateTime> scheduledDate,
  Value<int?> categoryId,
  Value<bool> isRecurring,
  Value<String> recurrenceType,
  Value<int?> recurrenceInterval,
  Value<bool> isPaid,
  Value<int?> paidTransactionId,
  Value<String?> note,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$UpcomingExpensesTableTableReferences extends BaseReferences<
    _$AppDatabase, $UpcomingExpensesTableTable, UpcomingExpensesTableData> {
  $$UpcomingExpensesTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CategoriesTableTable _categoryIdTable(_$AppDatabase db) =>
      db.categoriesTable.createAlias(
          'upcoming_expenses_table__category_id__categories_table__id');

  $$CategoriesTableTableProcessedTableManager? get categoryId {
    final $_column = $_itemColumn<int>('category_id');
    if ($_column == null) return null;
    final manager =
        $$CategoriesTableTableTableManager($_db, $_db.categoriesTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$UpcomingExpensesTableTableFilterComposer
    extends Composer<_$AppDatabase, $UpcomingExpensesTableTable> {
  $$UpcomingExpensesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get recurrenceType => $composableBuilder(
      column: $table.recurrenceType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recurrenceInterval => $composableBuilder(
      column: $table.recurrenceInterval,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPaid => $composableBuilder(
      column: $table.isPaid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get paidTransactionId => $composableBuilder(
      column: $table.paidTransactionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$CategoriesTableTableFilterComposer get categoryId {
    final $$CategoriesTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableFilterComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UpcomingExpensesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $UpcomingExpensesTableTable> {
  $$UpcomingExpensesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurrenceType => $composableBuilder(
      column: $table.recurrenceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recurrenceInterval => $composableBuilder(
      column: $table.recurrenceInterval,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPaid => $composableBuilder(
      column: $table.isPaid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get paidTransactionId => $composableBuilder(
      column: $table.paidTransactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$CategoriesTableTableOrderingComposer get categoryId {
    final $$CategoriesTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableOrderingComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UpcomingExpensesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $UpcomingExpensesTableTable> {
  $$UpcomingExpensesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledDate => $composableBuilder(
      column: $table.scheduledDate, builder: (column) => column);

  GeneratedColumn<bool> get isRecurring => $composableBuilder(
      column: $table.isRecurring, builder: (column) => column);

  GeneratedColumn<String> get recurrenceType => $composableBuilder(
      column: $table.recurrenceType, builder: (column) => column);

  GeneratedColumn<int> get recurrenceInterval => $composableBuilder(
      column: $table.recurrenceInterval, builder: (column) => column);

  GeneratedColumn<bool> get isPaid =>
      $composableBuilder(column: $table.isPaid, builder: (column) => column);

  GeneratedColumn<int> get paidTransactionId => $composableBuilder(
      column: $table.paidTransactionId, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CategoriesTableTableAnnotationComposer get categoryId {
    final $$CategoriesTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.categoryId,
        referencedTable: $db.categoriesTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CategoriesTableTableAnnotationComposer(
              $db: $db,
              $table: $db.categoriesTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$UpcomingExpensesTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UpcomingExpensesTableTable,
    UpcomingExpensesTableData,
    $$UpcomingExpensesTableTableFilterComposer,
    $$UpcomingExpensesTableTableOrderingComposer,
    $$UpcomingExpensesTableTableAnnotationComposer,
    $$UpcomingExpensesTableTableCreateCompanionBuilder,
    $$UpcomingExpensesTableTableUpdateCompanionBuilder,
    (UpcomingExpensesTableData, $$UpcomingExpensesTableTableReferences),
    UpcomingExpensesTableData,
    PrefetchHooks Function({bool categoryId})> {
  $$UpcomingExpensesTableTableTableManager(
      _$AppDatabase db, $UpcomingExpensesTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UpcomingExpensesTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$UpcomingExpensesTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UpcomingExpensesTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> amount = const Value.absent(),
            Value<DateTime> scheduledDate = const Value.absent(),
            Value<int?> categoryId = const Value.absent(),
            Value<bool> isRecurring = const Value.absent(),
            Value<String> recurrenceType = const Value.absent(),
            Value<int?> recurrenceInterval = const Value.absent(),
            Value<bool> isPaid = const Value.absent(),
            Value<int?> paidTransactionId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              UpcomingExpensesTableCompanion(
            id: id,
            title: title,
            amount: amount,
            scheduledDate: scheduledDate,
            categoryId: categoryId,
            isRecurring: isRecurring,
            recurrenceType: recurrenceType,
            recurrenceInterval: recurrenceInterval,
            isPaid: isPaid,
            paidTransactionId: paidTransactionId,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required int amount,
            required DateTime scheduledDate,
            Value<int?> categoryId = const Value.absent(),
            Value<bool> isRecurring = const Value.absent(),
            Value<String> recurrenceType = const Value.absent(),
            Value<int?> recurrenceInterval = const Value.absent(),
            Value<bool> isPaid = const Value.absent(),
            Value<int?> paidTransactionId = const Value.absent(),
            Value<String?> note = const Value.absent(),
            required DateTime createdAt,
            required DateTime updatedAt,
          }) =>
              UpcomingExpensesTableCompanion.insert(
            id: id,
            title: title,
            amount: amount,
            scheduledDate: scheduledDate,
            categoryId: categoryId,
            isRecurring: isRecurring,
            recurrenceType: recurrenceType,
            recurrenceInterval: recurrenceInterval,
            isPaid: isPaid,
            paidTransactionId: paidTransactionId,
            note: note,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$UpcomingExpensesTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({categoryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (categoryId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.categoryId,
                    referencedTable: $$UpcomingExpensesTableTableReferences
                        ._categoryIdTable(db),
                    referencedColumn: $$UpcomingExpensesTableTableReferences
                        ._categoryIdTable(db)
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
        ));
}

typedef $$UpcomingExpensesTableTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $UpcomingExpensesTableTable,
        UpcomingExpensesTableData,
        $$UpcomingExpensesTableTableFilterComposer,
        $$UpcomingExpensesTableTableOrderingComposer,
        $$UpcomingExpensesTableTableAnnotationComposer,
        $$UpcomingExpensesTableTableCreateCompanionBuilder,
        $$UpcomingExpensesTableTableUpdateCompanionBuilder,
        (UpcomingExpensesTableData, $$UpcomingExpensesTableTableReferences),
        UpcomingExpensesTableData,
        PrefetchHooks Function({bool categoryId})>;
typedef $$WishlistItemsTableTableCreateCompanionBuilder
    = WishlistItemsTableCompanion Function({
  Value<int> id,
  required String name,
  required int price,
  Value<String?> url,
  Value<String?> imagePath,
  Value<String?> memo,
  Value<int> cooldownHours,
  required DateTime createdAt,
  required DateTime cooldownUntil,
  required String status,
  Value<DateTime?> waitingUntil,
  Value<DateTime?> purchasedAt,
  Value<DateTime?> releasedAt,
  Value<int?> linkedTransactionId,
  Value<int> createdDailySafeSnapshot,
  required DateTime updatedAt,
});
typedef $$WishlistItemsTableTableUpdateCompanionBuilder
    = WishlistItemsTableCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> price,
  Value<String?> url,
  Value<String?> imagePath,
  Value<String?> memo,
  Value<int> cooldownHours,
  Value<DateTime> createdAt,
  Value<DateTime> cooldownUntil,
  Value<String> status,
  Value<DateTime?> waitingUntil,
  Value<DateTime?> purchasedAt,
  Value<DateTime?> releasedAt,
  Value<int?> linkedTransactionId,
  Value<int> createdDailySafeSnapshot,
  Value<DateTime> updatedAt,
});

final class $$WishlistItemsTableTableReferences extends BaseReferences<
    _$AppDatabase, $WishlistItemsTableTable, WishlistItemsTableData> {
  $$WishlistItemsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WishlistEventsTableTable,
      List<WishlistEventsTableData>> _wishlistEventsTableRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.wishlistEventsTable,
          aliasName:
              'wishlist_items_table__id__wishlist_events_table__wishlist_item_id');

  $$WishlistEventsTableTableProcessedTableManager get wishlistEventsTableRefs {
    final manager = $$WishlistEventsTableTableTableManager(
            $_db, $_db.wishlistEventsTable)
        .filter((f) => f.wishlistItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_wishlistEventsTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WishlistItemsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WishlistItemsTableTable> {
  $$WishlistItemsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cooldownHours => $composableBuilder(
      column: $table.cooldownHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get cooldownUntil => $composableBuilder(
      column: $table.cooldownUntil, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get waitingUntil => $composableBuilder(
      column: $table.waitingUntil, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get purchasedAt => $composableBuilder(
      column: $table.purchasedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get releasedAt => $composableBuilder(
      column: $table.releasedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get linkedTransactionId => $composableBuilder(
      column: $table.linkedTransactionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdDailySafeSnapshot => $composableBuilder(
      column: $table.createdDailySafeSnapshot,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> wishlistEventsTableRefs(
      Expression<bool> Function($$WishlistEventsTableTableFilterComposer f) f) {
    final $$WishlistEventsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.wishlistEventsTable,
        getReferencedColumn: (t) => t.wishlistItemId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WishlistEventsTableTableFilterComposer(
              $db: $db,
              $table: $db.wishlistEventsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WishlistItemsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WishlistItemsTableTable> {
  $$WishlistItemsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get memo => $composableBuilder(
      column: $table.memo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cooldownHours => $composableBuilder(
      column: $table.cooldownHours,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get cooldownUntil => $composableBuilder(
      column: $table.cooldownUntil,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get waitingUntil => $composableBuilder(
      column: $table.waitingUntil,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get purchasedAt => $composableBuilder(
      column: $table.purchasedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get releasedAt => $composableBuilder(
      column: $table.releasedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get linkedTransactionId => $composableBuilder(
      column: $table.linkedTransactionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdDailySafeSnapshot => $composableBuilder(
      column: $table.createdDailySafeSnapshot,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$WishlistItemsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishlistItemsTableTable> {
  $$WishlistItemsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<String> get memo =>
      $composableBuilder(column: $table.memo, builder: (column) => column);

  GeneratedColumn<int> get cooldownHours => $composableBuilder(
      column: $table.cooldownHours, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cooldownUntil => $composableBuilder(
      column: $table.cooldownUntil, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get waitingUntil => $composableBuilder(
      column: $table.waitingUntil, builder: (column) => column);

  GeneratedColumn<DateTime> get purchasedAt => $composableBuilder(
      column: $table.purchasedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get releasedAt => $composableBuilder(
      column: $table.releasedAt, builder: (column) => column);

  GeneratedColumn<int> get linkedTransactionId => $composableBuilder(
      column: $table.linkedTransactionId, builder: (column) => column);

  GeneratedColumn<int> get createdDailySafeSnapshot => $composableBuilder(
      column: $table.createdDailySafeSnapshot, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> wishlistEventsTableRefs<T extends Object>(
      Expression<T> Function($$WishlistEventsTableTableAnnotationComposer a)
          f) {
    final $$WishlistEventsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.wishlistEventsTable,
            getReferencedColumn: (t) => t.wishlistItemId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WishlistEventsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.wishlistEventsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$WishlistItemsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WishlistItemsTableTable,
    WishlistItemsTableData,
    $$WishlistItemsTableTableFilterComposer,
    $$WishlistItemsTableTableOrderingComposer,
    $$WishlistItemsTableTableAnnotationComposer,
    $$WishlistItemsTableTableCreateCompanionBuilder,
    $$WishlistItemsTableTableUpdateCompanionBuilder,
    (WishlistItemsTableData, $$WishlistItemsTableTableReferences),
    WishlistItemsTableData,
    PrefetchHooks Function({bool wishlistEventsTableRefs})> {
  $$WishlistItemsTableTableTableManager(
      _$AppDatabase db, $WishlistItemsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistItemsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistItemsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistItemsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> price = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<int> cooldownHours = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> cooldownUntil = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime?> waitingUntil = const Value.absent(),
            Value<DateTime?> purchasedAt = const Value.absent(),
            Value<DateTime?> releasedAt = const Value.absent(),
            Value<int?> linkedTransactionId = const Value.absent(),
            Value<int> createdDailySafeSnapshot = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              WishlistItemsTableCompanion(
            id: id,
            name: name,
            price: price,
            url: url,
            imagePath: imagePath,
            memo: memo,
            cooldownHours: cooldownHours,
            createdAt: createdAt,
            cooldownUntil: cooldownUntil,
            status: status,
            waitingUntil: waitingUntil,
            purchasedAt: purchasedAt,
            releasedAt: releasedAt,
            linkedTransactionId: linkedTransactionId,
            createdDailySafeSnapshot: createdDailySafeSnapshot,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int price,
            Value<String?> url = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
            Value<String?> memo = const Value.absent(),
            Value<int> cooldownHours = const Value.absent(),
            required DateTime createdAt,
            required DateTime cooldownUntil,
            required String status,
            Value<DateTime?> waitingUntil = const Value.absent(),
            Value<DateTime?> purchasedAt = const Value.absent(),
            Value<DateTime?> releasedAt = const Value.absent(),
            Value<int?> linkedTransactionId = const Value.absent(),
            Value<int> createdDailySafeSnapshot = const Value.absent(),
            required DateTime updatedAt,
          }) =>
              WishlistItemsTableCompanion.insert(
            id: id,
            name: name,
            price: price,
            url: url,
            imagePath: imagePath,
            memo: memo,
            cooldownHours: cooldownHours,
            createdAt: createdAt,
            cooldownUntil: cooldownUntil,
            status: status,
            waitingUntil: waitingUntil,
            purchasedAt: purchasedAt,
            releasedAt: releasedAt,
            linkedTransactionId: linkedTransactionId,
            createdDailySafeSnapshot: createdDailySafeSnapshot,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WishlistItemsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wishlistEventsTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (wishlistEventsTableRefs) db.wishlistEventsTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (wishlistEventsTableRefs)
                    await $_getPrefetchedData<WishlistItemsTableData,
                            $WishlistItemsTableTable, WishlistEventsTableData>(
                        currentTable: table,
                        referencedTable: $$WishlistItemsTableTableReferences
                            ._wishlistEventsTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WishlistItemsTableTableReferences(db, table, p0)
                                .wishlistEventsTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.wishlistItemId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WishlistItemsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WishlistItemsTableTable,
    WishlistItemsTableData,
    $$WishlistItemsTableTableFilterComposer,
    $$WishlistItemsTableTableOrderingComposer,
    $$WishlistItemsTableTableAnnotationComposer,
    $$WishlistItemsTableTableCreateCompanionBuilder,
    $$WishlistItemsTableTableUpdateCompanionBuilder,
    (WishlistItemsTableData, $$WishlistItemsTableTableReferences),
    WishlistItemsTableData,
    PrefetchHooks Function({bool wishlistEventsTableRefs})>;
typedef $$WishlistEventsTableTableCreateCompanionBuilder
    = WishlistEventsTableCompanion Function({
  Value<int> id,
  required int wishlistItemId,
  required String eventType,
  required DateTime eventAt,
  Value<String?> payloadJson,
});
typedef $$WishlistEventsTableTableUpdateCompanionBuilder
    = WishlistEventsTableCompanion Function({
  Value<int> id,
  Value<int> wishlistItemId,
  Value<String> eventType,
  Value<DateTime> eventAt,
  Value<String?> payloadJson,
});

final class $$WishlistEventsTableTableReferences extends BaseReferences<
    _$AppDatabase, $WishlistEventsTableTable, WishlistEventsTableData> {
  $$WishlistEventsTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WishlistItemsTableTable _wishlistItemIdTable(_$AppDatabase db) =>
      db.wishlistItemsTable.createAlias(
          'wishlist_events_table__wishlist_item_id__wishlist_items_table__id');

  $$WishlistItemsTableTableProcessedTableManager get wishlistItemId {
    final $_column = $_itemColumn<int>('wishlist_item_id')!;

    final manager =
        $$WishlistItemsTableTableTableManager($_db, $_db.wishlistItemsTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wishlistItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WishlistEventsTableTableFilterComposer
    extends Composer<_$AppDatabase, $WishlistEventsTableTable> {
  $$WishlistEventsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get eventAt => $composableBuilder(
      column: $table.eventAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnFilters(column));

  $$WishlistItemsTableTableFilterComposer get wishlistItemId {
    final $$WishlistItemsTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wishlistItemId,
        referencedTable: $db.wishlistItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WishlistItemsTableTableFilterComposer(
              $db: $db,
              $table: $db.wishlistItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WishlistEventsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WishlistEventsTableTable> {
  $$WishlistEventsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get eventAt => $composableBuilder(
      column: $table.eventAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => ColumnOrderings(column));

  $$WishlistItemsTableTableOrderingComposer get wishlistItemId {
    final $$WishlistItemsTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.wishlistItemId,
        referencedTable: $db.wishlistItemsTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WishlistItemsTableTableOrderingComposer(
              $db: $db,
              $table: $db.wishlistItemsTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WishlistEventsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishlistEventsTableTable> {
  $$WishlistEventsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<DateTime> get eventAt =>
      $composableBuilder(column: $table.eventAt, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
      column: $table.payloadJson, builder: (column) => column);

  $$WishlistItemsTableTableAnnotationComposer get wishlistItemId {
    final $$WishlistItemsTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.wishlistItemId,
            referencedTable: $db.wishlistItemsTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$WishlistItemsTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.wishlistItemsTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$WishlistEventsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WishlistEventsTableTable,
    WishlistEventsTableData,
    $$WishlistEventsTableTableFilterComposer,
    $$WishlistEventsTableTableOrderingComposer,
    $$WishlistEventsTableTableAnnotationComposer,
    $$WishlistEventsTableTableCreateCompanionBuilder,
    $$WishlistEventsTableTableUpdateCompanionBuilder,
    (WishlistEventsTableData, $$WishlistEventsTableTableReferences),
    WishlistEventsTableData,
    PrefetchHooks Function({bool wishlistItemId})> {
  $$WishlistEventsTableTableTableManager(
      _$AppDatabase db, $WishlistEventsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistEventsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistEventsTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistEventsTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> wishlistItemId = const Value.absent(),
            Value<String> eventType = const Value.absent(),
            Value<DateTime> eventAt = const Value.absent(),
            Value<String?> payloadJson = const Value.absent(),
          }) =>
              WishlistEventsTableCompanion(
            id: id,
            wishlistItemId: wishlistItemId,
            eventType: eventType,
            eventAt: eventAt,
            payloadJson: payloadJson,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int wishlistItemId,
            required String eventType,
            required DateTime eventAt,
            Value<String?> payloadJson = const Value.absent(),
          }) =>
              WishlistEventsTableCompanion.insert(
            id: id,
            wishlistItemId: wishlistItemId,
            eventType: eventType,
            eventAt: eventAt,
            payloadJson: payloadJson,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WishlistEventsTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({wishlistItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (wishlistItemId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.wishlistItemId,
                    referencedTable: $$WishlistEventsTableTableReferences
                        ._wishlistItemIdTable(db),
                    referencedColumn: $$WishlistEventsTableTableReferences
                        ._wishlistItemIdTable(db)
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
        ));
}

typedef $$WishlistEventsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WishlistEventsTableTable,
    WishlistEventsTableData,
    $$WishlistEventsTableTableFilterComposer,
    $$WishlistEventsTableTableOrderingComposer,
    $$WishlistEventsTableTableAnnotationComposer,
    $$WishlistEventsTableTableCreateCompanionBuilder,
    $$WishlistEventsTableTableUpdateCompanionBuilder,
    (WishlistEventsTableData, $$WishlistEventsTableTableReferences),
    WishlistEventsTableData,
    PrefetchHooks Function({bool wishlistItemId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$AppSettingsTableTableTableManager get appSettingsTable =>
      $$AppSettingsTableTableTableManager(_db, _db.appSettingsTable);
  $$AnnualSpecialBudgetsTableTableTableManager get annualSpecialBudgetsTable =>
      $$AnnualSpecialBudgetsTableTableTableManager(
          _db, _db.annualSpecialBudgetsTable);
  $$BudgetsTableTableTableManager get budgetsTable =>
      $$BudgetsTableTableTableManager(_db, _db.budgetsTable);
  $$CategoriesTableTableTableManager get categoriesTable =>
      $$CategoriesTableTableTableManager(_db, _db.categoriesTable);
  $$SavingPlansTableTableTableManager get savingPlansTable =>
      $$SavingPlansTableTableTableManager(_db, _db.savingPlansTable);
  $$CategoryBudgetAllocationsTableTableTableManager
      get categoryBudgetAllocationsTable =>
          $$CategoryBudgetAllocationsTableTableTableManager(
              _db, _db.categoryBudgetAllocationsTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
  $$UpcomingExpensesTableTableTableManager get upcomingExpensesTable =>
      $$UpcomingExpensesTableTableTableManager(_db, _db.upcomingExpensesTable);
  $$WishlistItemsTableTableTableManager get wishlistItemsTable =>
      $$WishlistItemsTableTableTableManager(_db, _db.wishlistItemsTable);
  $$WishlistEventsTableTableTableManager get wishlistEventsTable =>
      $$WishlistEventsTableTableTableManager(_db, _db.wishlistEventsTable);
}
