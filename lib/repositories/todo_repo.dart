import 'package:simple_todo_app/db/database.dart';
import 'package:simple_todo_app/entities/todo.dart';

class TodoRepo {
  Future<TodoEntity> createOne(TodoEntity todo) async {
    final _db = await AppDatabase.instance;
    final newTodo = todo.copyWith(createdAt: DateTime.now(), updatedAt: DateTime.now());
    final id = await _db.insert('todos', newTodo.toMap());
    return newTodo.copyWith(id: id);
  }

  Future<List<TodoEntity>> findMany() async {
    final _db = await AppDatabase.instance;
    final result = await _db.rawQuery('SELECT * FROM `todos` ORDER BY `priority` DESC ');

    return result.map<TodoEntity>((e) => TodoEntity.fromMap(e)).toList();
  }

  Future<TodoEntity> updateOne(TodoEntity todo) async {
    final _db = await AppDatabase.instance;
    final updatedTodo = todo.copyWith(updatedAt: DateTime.now());
    await _db.update(
      'todos',
      updatedTodo.toMap(),
      where: 'id = ? ',
      whereArgs: [updatedTodo.id],
    );
    return updatedTodo;
  }

  Future<void> deleteOne(TodoEntity todo) async {
    final _db = await AppDatabase.instance;
    await _db.delete('todos', where: 'id = ?', whereArgs: [todo.id]);
  }
}
