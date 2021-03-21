import 'package:simple_todo_app/entities/todo.dart';
import 'package:simple_todo_app/repositories/todo_repo.dart';

class TodoService {
  Future<TodoEntity> createOne(TodoEntity todo) {
    return TodoRepo().createOne(todo);
  }

  Future<List<TodoEntity>> findMany() {
    return TodoRepo().findMany();
  }

  Future<TodoEntity> updateOne(TodoEntity todo) {
    return TodoRepo().updateOne(todo);
  }

  Future<void> deleteOne(TodoEntity todo) {
    return TodoRepo().deleteOne(todo);
  }
}
