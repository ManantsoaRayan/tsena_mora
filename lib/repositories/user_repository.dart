import 'package:sqflite/sqflite.dart';
import 'package:tsena_mora/database_helper.dart';

import '../model/user_model.dart';

class UserRepository {
  final DatabaseHelper _dbhelper = DatabaseHelper();

  // insert user
  Future<int> insertUser(User user) async {
    final db = await _dbhelper.database;

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all the user
  Future<List<User>> getAllUsers() async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> users = await db.query("users");

    return List.generate(users.length, (i) {
      return User.fromMap(users[i]);
    });
  }

  // Get user by id
  Future<User?> getUserById(int id) async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (users.isEmpty) return null;

    return User.fromMap(users.first);
  }

  // update user
  Future<int> updateUser(User user) async {
    final db = await _dbhelper.database;

    return await db.update(
      'users',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id]
    );
  }

  // delete user
  Future<int> deleteUser(User user) async {
    final db = await _dbhelper.database;

    return await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [user.id]
    );
  }


  // check if username already exists
  Future<bool> usernameExists(String username) async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> results = await db.query("users", where: "username = ?", whereArgs: [username]);

    return results.isNotEmpty;
  }

  Future<User?> searchByUsername(String username) async {
    final db = await _dbhelper.database;
    final List<Map<String, dynamic>> user = await db.query("users", where: "username = ?", whereArgs: [username]);

    if (user.isEmpty) return null;

    return User.fromMap(user.first);
  }


}
