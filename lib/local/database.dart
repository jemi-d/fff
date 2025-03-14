
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get username => text().withLength(min: 3, max: 50)();
  TextColumn get password => text()(); // Store encrypted password in production
}

class Repos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get owner => text()();
  TextColumn get language => text().nullable()();
  IntColumn get stars => integer().withDefault(const Constant(0))();
  TextColumn get url => text()();
}

// Database Class
@DriftDatabase(tables: [Users,Repos])
class AppDatabase extends _$AppDatabase {

  // Singleton instance
  static AppDatabase? _instance;
  AppDatabase._internal() : super(_openConnection());

  // Singleton getter
  static AppDatabase getInstance() {
    _instance ??= AppDatabase._internal();
    return _instance!;
  }

  @override
  int get schemaVersion => 1;

  // Repos table Operations
  Future<int> insertRepo(ReposCompanion repo) async{
    return await into(repos).insert(repo);
  }
  Future<List<Repo>> getAllRepos() async{
    return await select(repos).get();
  }
  Future<Repo?> fetchRepoById(int id) async{
    return await(select(repos)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
  Future<bool> updateRepo(Repo repo) async {
    return await update(repos).replace(repo);
  }
  Future<int> deleteRepoById(int id) async {
    return await (delete(repos)..where((r) => r.id.equals(id))).go();
  }
  Future<void> clearRepos() async{
    await delete(repos).go();
  }

  // Users table Operations
  Future<int> insertUser(UsersCompanion user) async {
    return await into(users).insert(user);
  }
  Future<User?> getUser(String username, String password) async {
    return await (select(users)
      ..where((tbl) => tbl.username.equals(username) & tbl.password.equals(password)))
        .getSingleOrNull();
  }
  Future<void> clearUsers() async {
    await delete(users).go();
  }
  Future<User?> getUserByEmail(String email) async {
    final query = await (select(users)
      ..where((u) => u.username.equals(email)))
        .getSingleOrNull();
    return query;
  }
}

// Database Connection
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}