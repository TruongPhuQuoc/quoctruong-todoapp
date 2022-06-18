import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quoctruong_todoapp/model/task_model.dart';
import 'package:quoctruong_todoapp/screen/home_screen/enum_task_status.dart';
import 'package:sqflite/sqflite.dart';

class LocalDbHelper {
  Database? _db;
  final String idColumn = 'id';
  final String descriptionColumn = 'description';
  final String isCompletedColumn = 'isCompleted';
  final String taskTableName = 'tbl_task';
  final String databaseName = 'dbTodoApp2.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    //init db
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    var db = await openDatabase(path, version: 2, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $taskTableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $descriptionColumn TEXT NOT NULL, $isCompletedColumn INTEGER NOT NULL)");
  }

  Future<dynamic> addTask(TaskModel task) async {
    var dbClient = await db;
    try {
      return await dbClient.insert(taskTableName, task.toMap());
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<List<TaskModel>> getTaskList(TaskStatus taskStatus) async {
    var dbClient = await db;
    String query = "SELECT * FROM $taskTableName ";
    switch (taskStatus) {
      case TaskStatus.completed:
        query += "WHERE $isCompletedColumn = 1";
        break;
      case TaskStatus.incompleted:
        query += "WHERE $isCompletedColumn = 0";
        break;
      default:
    }
    query += " ORDER BY $idColumn DESC";
    print("SQL query: $query");
    List<Map<String, dynamic>> maps = await dbClient.rawQuery(query);
    List<TaskModel> taskList = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        taskList.add(TaskModel.fromMap(maps[i]));
      }
    }
    return taskList;
  }

  Future<dynamic> updateTask(
      {required int taskId, required bool newTaskStatus}) async {
    var dbClient = await db;
    Map<String, dynamic> mapNewValue = {};
    mapNewValue[isCompletedColumn] = newTaskStatus;

    try {
      return await dbClient.update(taskTableName, mapNewValue,
          where: '$idColumn = ?', whereArgs: [taskId]);
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
