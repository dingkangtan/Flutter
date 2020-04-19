import 'dart:async';
import 'dart:io';

import 'package:flutterapp/models/User.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseLogin {
  // Singleton DatabaseHelper
  static DatabaseLogin databaseHelper;

  // Singleton Database
  static Database db;

  String userTable = "user_table";
  String colId = "id";
  String colUsername = "username";
  String colPassword = "password";

  DatabaseLogin.createInstance();

  factory DatabaseLogin() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseLogin.createInstance();
    }
    return databaseHelper;
  }

  Future<Database> get database async {
    if (db != null) {
      return db;
    }
    db = await initializeDatabase();
    return db;
  }

  Future<Database> initializeDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var loginDb = await openDatabase(path, version: 1, onCreate: createDb);
    return loginDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $userTable($colId INTEGER PRIMARY KEY, $colUsername TEXT, $colPassword TEXT)");
    print("TABLE IS CREATED");
  }

  Future<int> saveUser(User user) async {
    Database db = await this.database;
    return await db.insert("user_table", user.toMap());
  }

  Future<int> deleteUser(User user) async {
    Database db = await this.database;
    return await db.delete("user_table");
  }
}
