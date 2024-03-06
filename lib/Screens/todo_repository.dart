// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// import 'Model/todoModel.dart';

// class TodoRepository {
//   late Database _database;

//   Future<void> initializeDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'todo_database.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE todos(id INTEGER PRIMARY KEY, task TEXT, completed BOOLEAN)',
//         );
//       },
//       version: 1,
//     );
//   }

//   Future<List<Todo>> getTodos() async {
//     final List<Map<String, dynamic>> maps = await _database.query('todos');
//     return List.generate(maps.length, (i) {
//       return Todo(
//         id: maps[i]['id'],
//         title: maps[i]['task'],
//         isCompleted: maps[i]['completed'] == 1,
//       );
//     });
//   }

//   Future<void> addTodo(Todo todo) async {
//     await _database.insert(
//       'todos',
//       todo.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<void> updateTodo(Todo todo) async {
//     await _database.update(
//       'todos',
//       todo.toMap(),
//       where: 'id = ?',
//       whereArgs: [todo.id],
//     );
//   }

//   Future<void> deleteTodo(Todo todo) async {
//     await _database.delete(
//       'todos',
//       where: 'id = ?',
//       whereArgs: [todo.id],
//     );
//   }
// }
