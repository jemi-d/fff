import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../local/database.dart';

class AuthService {
  final AppDatabase db;
  AuthService(this.db);

  Future<void> insertUser(String email, String password) async {
    try {
      final userExists = await getUserByEmail(email);

      if (userExists == null) {
        final user = UsersCompanion(
          username: Value(email),
          password: Value(password),
        );
        await db.into(db.users).insert(user);
      } else {
        debugPrint("User already exists: ${userExists.username}");
      }
    } catch (e) {
      debugPrint("Error inserting user: $e");
    }
  }

  // Login User
  Future<bool> login(String username, String password) async {
    final user = await db.getUser(username, password);
    if (user != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
      return true;
    } else {
      await insertUser(username, password);
      final newUser = await db.getUser(username, password);
      if (newUser != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('username', username);
        return true;
      }
    }
    return false;
  }

  // Logout User
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username');
    await db.clearUsers();
  }

  // Check if User is Logged In
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  // Get user by email
  Future<User?> getUserByEmail(String email) async {
    return await db.getUserByEmail(email);
  }
}