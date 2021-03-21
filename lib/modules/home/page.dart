import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/modules/add_todo_dialog/dialog.dart';
import 'package:simple_todo_app/cubits/cubit/todos_cubit.dart';
import 'package:simple_todo_app/widgets/tesk_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TODOS'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(context: context, builder: (_) => CreateTodoDilaog()),
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<TodosCubit, TodosState>(
        builder: (BuildContext ctx, TodosState state) {
          if (state is TodosLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TodosError) {
            return Center(child: Text(state.errorMsg));
          } else if (state is TodosLoaded) {
            return ListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (_, int index) {
                  final currentTodo = state.todos[index];
                  return TodoItem(currentTodo);
                });
          } else if (state is TodosEmpty) {
            return Center(child: Text('Empty !'));
          }
          return Center(child: Text('unknown state'));
        },
      ),
    );
  }
}
