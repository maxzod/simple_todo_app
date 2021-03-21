import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:simple_todo_app/entities/todo.dart';
import 'package:simple_todo_app/services/todo.dart';

part 'todos_state.dart';

class TodosCubit extends Cubit<TodosState> {
  final _todosService = TodoService();
  TodosCubit() : super(TodosLoading()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    emit(TodosLoading());
    // await Future.delayed(Duration(seconds: 1));
    try {
      final result = await _todosService.findMany();
      if (result.isEmpty) {
        emit(TodosEmpty());
      } else {
        emit(TodosLoaded(result));
      }
    } catch (e) {
      emit(TodosError(e.toString()));
    }
  }

  Future<void> createOne(TodoEntity todo) async {
    await _todosService.createOne(todo);
    await loadTodos();
  }

  Future<void> updateOne(TodoEntity todo) async {
    await _todosService.updateOne(todo);
    await loadTodos();
  }

  Future<void> deleteOne(TodoEntity todo) async {
    await _todosService.deleteOne(todo);
    await loadTodos();
  }
}
