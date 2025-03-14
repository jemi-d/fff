// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, username, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      password:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}password'],
          )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String password;
  const User({
    required this.id,
    required this.username,
    required this.password,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
    };
  }

  User copyWith({int? id, String? username, String? password}) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    password: password ?? this.password,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
  }) : username = Value(username),
       password = Value(password);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (password != null) 'password': password,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? password,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $ReposTable extends Repos with TableInfo<$ReposTable, Repo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReposTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
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
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ownerMeta = const VerificationMeta('owner');
  @override
  late final GeneratedColumn<String> owner = GeneratedColumn<String>(
    'owner',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _starsMeta = const VerificationMeta('stars');
  @override
  late final GeneratedColumn<int> stars = GeneratedColumn<int>(
    'stars',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
    'url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    description,
    owner,
    language,
    stars,
    url,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Repo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('owner')) {
      context.handle(
        _ownerMeta,
        owner.isAcceptableOrUnknown(data['owner']!, _ownerMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('stars')) {
      context.handle(
        _starsMeta,
        stars.isAcceptableOrUnknown(data['stars']!, _starsMeta),
      );
    }
    if (data.containsKey('url')) {
      context.handle(
        _urlMeta,
        url.isAcceptableOrUnknown(data['url']!, _urlMeta),
      );
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repo(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      owner:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}owner'],
          )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      ),
      stars:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}stars'],
          )!,
      url:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}url'],
          )!,
    );
  }

  @override
  $ReposTable createAlias(String alias) {
    return $ReposTable(attachedDatabase, alias);
  }
}

class Repo extends DataClass implements Insertable<Repo> {
  final int id;
  final String name;
  final String? description;
  final String owner;
  final String? language;
  final int stars;
  final String url;
  const Repo({
    required this.id,
    required this.name,
    this.description,
    required this.owner,
    this.language,
    required this.stars,
    required this.url,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['owner'] = Variable<String>(owner);
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    map['stars'] = Variable<int>(stars);
    map['url'] = Variable<String>(url);
    return map;
  }

  ReposCompanion toCompanion(bool nullToAbsent) {
    return ReposCompanion(
      id: Value(id),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      owner: Value(owner),
      language:
          language == null && nullToAbsent
              ? const Value.absent()
              : Value(language),
      stars: Value(stars),
      url: Value(url),
    );
  }

  factory Repo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repo(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      owner: serializer.fromJson<String>(json['owner']),
      language: serializer.fromJson<String?>(json['language']),
      stars: serializer.fromJson<int>(json['stars']),
      url: serializer.fromJson<String>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'owner': serializer.toJson<String>(owner),
      'language': serializer.toJson<String?>(language),
      'stars': serializer.toJson<int>(stars),
      'url': serializer.toJson<String>(url),
    };
  }

  Repo copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    String? owner,
    Value<String?> language = const Value.absent(),
    int? stars,
    String? url,
  }) => Repo(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    owner: owner ?? this.owner,
    language: language.present ? language.value : this.language,
    stars: stars ?? this.stars,
    url: url ?? this.url,
  );
  Repo copyWithCompanion(ReposCompanion data) {
    return Repo(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      owner: data.owner.present ? data.owner.value : this.owner,
      language: data.language.present ? data.language.value : this.language,
      stars: data.stars.present ? data.stars.value : this.stars,
      url: data.url.present ? data.url.value : this.url,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repo(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('owner: $owner, ')
          ..write('language: $language, ')
          ..write('stars: $stars, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, owner, language, stars, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repo &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.owner == this.owner &&
          other.language == this.language &&
          other.stars == this.stars &&
          other.url == this.url);
}

class ReposCompanion extends UpdateCompanion<Repo> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> owner;
  final Value<String?> language;
  final Value<int> stars;
  final Value<String> url;
  const ReposCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.owner = const Value.absent(),
    this.language = const Value.absent(),
    this.stars = const Value.absent(),
    this.url = const Value.absent(),
  });
  ReposCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required String owner,
    this.language = const Value.absent(),
    this.stars = const Value.absent(),
    required String url,
  }) : name = Value(name),
       owner = Value(owner),
       url = Value(url);
  static Insertable<Repo> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? owner,
    Expression<String>? language,
    Expression<int>? stars,
    Expression<String>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (owner != null) 'owner': owner,
      if (language != null) 'language': language,
      if (stars != null) 'stars': stars,
      if (url != null) 'url': url,
    });
  }

  ReposCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? owner,
    Value<String?>? language,
    Value<int>? stars,
    Value<String>? url,
  }) {
    return ReposCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      language: language ?? this.language,
      stars: stars ?? this.stars,
      url: url ?? this.url,
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (stars.present) {
      map['stars'] = Variable<int>(stars.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReposCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('owner: $owner, ')
          ..write('language: $language, ')
          ..write('stars: $stars, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ReposTable repos = $ReposTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [users, repos];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String username,
      required String password,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<String> password,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> password = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                password: password,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String password,
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                password: password,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$ReposTableCreateCompanionBuilder =
    ReposCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required String owner,
      Value<String?> language,
      Value<int> stars,
      required String url,
    });
typedef $$ReposTableUpdateCompanionBuilder =
    ReposCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<String> owner,
      Value<String?> language,
      Value<int> stars,
      Value<String> url,
    });

class $$ReposTableFilterComposer extends Composer<_$AppDatabase, $ReposTable> {
  $$ReposTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReposTableOrderingComposer
    extends Composer<_$AppDatabase, $ReposTable> {
  $$ReposTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get owner => $composableBuilder(
    column: $table.owner,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stars => $composableBuilder(
    column: $table.stars,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get url => $composableBuilder(
    column: $table.url,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReposTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReposTable> {
  $$ReposTableAnnotationComposer({
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

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get owner =>
      $composableBuilder(column: $table.owner, builder: (column) => column);

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<int> get stars =>
      $composableBuilder(column: $table.stars, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);
}

class $$ReposTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReposTable,
          Repo,
          $$ReposTableFilterComposer,
          $$ReposTableOrderingComposer,
          $$ReposTableAnnotationComposer,
          $$ReposTableCreateCompanionBuilder,
          $$ReposTableUpdateCompanionBuilder,
          (Repo, BaseReferences<_$AppDatabase, $ReposTable, Repo>),
          Repo,
          PrefetchHooks Function()
        > {
  $$ReposTableTableManager(_$AppDatabase db, $ReposTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ReposTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$ReposTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$ReposTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> owner = const Value.absent(),
                Value<String?> language = const Value.absent(),
                Value<int> stars = const Value.absent(),
                Value<String> url = const Value.absent(),
              }) => ReposCompanion(
                id: id,
                name: name,
                description: description,
                owner: owner,
                language: language,
                stars: stars,
                url: url,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required String owner,
                Value<String?> language = const Value.absent(),
                Value<int> stars = const Value.absent(),
                required String url,
              }) => ReposCompanion.insert(
                id: id,
                name: name,
                description: description,
                owner: owner,
                language: language,
                stars: stars,
                url: url,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReposTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReposTable,
      Repo,
      $$ReposTableFilterComposer,
      $$ReposTableOrderingComposer,
      $$ReposTableAnnotationComposer,
      $$ReposTableCreateCompanionBuilder,
      $$ReposTableUpdateCompanionBuilder,
      (Repo, BaseReferences<_$AppDatabase, $ReposTable, Repo>),
      Repo,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ReposTableTableManager get repos =>
      $$ReposTableTableManager(_db, _db.repos);
}
