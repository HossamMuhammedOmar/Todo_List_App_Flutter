import 'dart:io';
import 'package:Todo_List_App_Flutter/models/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();
  String taskTable = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

  // Task Table
  // id | Title | Date | Priority | Status
  // 0  |   ''  |  ''  |    ''    |  0
  // 1  |   ''  |  ''  |    ''    |  0
  // 2  |   ''  |  ''  |    ''    |  1

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';
    final todoListDb =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $taskTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)',
    );
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(taskTable);
    return result;
  }

  Future<List<TaskModel>> getTaskList() async {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<TaskModel> taskList = [];
    taskMapList.forEach((taskMap) {
      taskList.add(TaskModel.forMap(taskMap));
    });
    return taskList;
  }

  Future<int> insertTask(TaskModel task) async {
    Database db = await this.db;
    final int result = await db.insert(taskTable, task.toMap());
    return result;
  }

  Future<int> updateTask(TaskModel task) async {
    Database db = await this.db;
    final int result = await db.update(taskTable, task.toMap(),
        where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }

  Future<int> deleteTask(TaskModel task) async {
    Database db = await this.db;
    final int result =
        await db.delete(taskTable, where: '$colId = ?', whereArgs: [task.id]);
    return result;
  }
}
