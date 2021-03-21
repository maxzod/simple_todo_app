part of 'todos_cubit.dart';

@immutable
abstract class TodosState {}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  final List<TodoEntity> todos;

  TodosLoaded(this.todos);
}

class TodosEmpty extends TodosState {}

class TodosError extends TodosState {
  final String errorMsg;

  TodosError(this.errorMsg);
}
