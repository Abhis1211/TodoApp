import 'dart:async';
import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Screens/Model/todoModel.dart';

class TodoDatabase {
  Database? _database;

  Future open() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE todos(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, isCompleted INTEGER)',
        );
      },
      version: 1,
    );
  }

  // Future<List<Todo>> getTodos() async {
  //   await open();
  //   final List<Map<String, dynamic>> maps = await _database.query('todos');
  //   return List.generate(maps.length, (i) {
  //     return Todo.fromMap(maps[i]);
  //   });
  // }

  Future<List<Todo>> getTodos() async {
    await open();
    final List<Map<String, dynamic>> maps = await _database!.query('todos');
    return List.generate(maps.length, (i) {
      return Todo(
        id: maps[i]['id'],
        title: maps[i]['title'],
        isCompleted: maps[i]['isCompleted'],
      );
    });
  }

  Future<void> addTodo(Todo todo) async {
    await open();
    try {
      var data = {
        'title': todo.title,
        'isCompleted': todo.isCompleted,
      };

      await _database!.insert('todos', data);
    } catch (e) {
      log("Add Error==>" + e.toString());
    }
  }

  Future<void> updateTodo(Todo todo) async {
    await open();
    await _database!
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  Future<void> deleteTodo(Todo todo) async {
    await open();
    await _database!.delete('todos', where: 'id = ?', whereArgs: [todo.id]);
  }
}
