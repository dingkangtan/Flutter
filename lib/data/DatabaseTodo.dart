import 'dart:async';
import 'dart:io';

import 'package:flutterapp/models/Task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseToDoHelper {
  // Singleton DatabaseHelper
  static DatabaseToDoHelper databaseHelper;

  // Singleton Database
  static Database db;

  String taskTable = "task_table";
  String colId = "id";
  String colTask = "task";
  String colDate = "date";
  String colTime = "time";
  String colStatus = "status";

  DatabaseToDoHelper.createInstance();

  factory DatabaseToDoHelper() {
    if (databaseHelper == null) {
      databaseHelper = DatabaseToDoHelper.createInstance();
    }
    return databaseHelper;
  }

  Future<Database> get database async {
    if (db == null) {
      db = await initializeDatabase();
    }
    return db;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + "task.db";
    var taskDb = await openDatabase(path, version: 1, onCreate: createDb);
    return taskDb;
  }

  void createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $taskTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTask TEXT, $colDate TEXT, $colTime TEXT, $colStatus TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.database;
    var result =
        db.rawQuery('SELECT * FROM $taskTable order by $colDate, $colTime ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getInCompleteTaskMapList() async {
    Database db = await this.database;
    var result = db.rawQuery(
        'SELECT * FROM $taskTable where $colStatus = "" order by $colDate, $colTime ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getCompleteTaskMapList() async {
    Database db = await this.database;
    var result = db.rawQuery(
        'SELECT * FROM $taskTable where $colStatus = "Task Completed" order by $colDate, $colTime ASC');
    return result;
  }

  Future<int> insertTask(Task task) async {
    Database db = await this.database;
    var result = await db.insert(taskTable, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async {
    var db = await this.database;
    var result = await db.update(taskTable, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $taskTable WHERE $colId=$id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $taskTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Task>> getTaskList() async {
    var taskMapList = await getTaskMapList();
    return getTasks(taskMapList);
  }

  Future<List<Task>> getInCompleteTaskList() async {
    var taskMapList = await getInCompleteTaskMapList();
    return getTasks(taskMapList);
  }

  Future<List<Task>> getCompleteTaskList() async {
    var taskMapList = await getCompleteTaskMapList();
    return getTasks(taskMapList);
  }

  Future<List<Task>> getTasks(var taskMapList) async {
    List<Task> taskList = List<Task>();
    for (int i = 0; i < taskMapList.length; i++) {
      taskList.add(Task.fromMapObject(taskMapList[i]));
    }
    return taskList;
  }
}
