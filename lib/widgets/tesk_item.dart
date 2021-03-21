import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/entities/todo.dart';
import 'package:simple_todo_app/modules/edit_todo_dialog/dialog.dart';
import 'package:simple_todo_app/cubits/cubit/todos_cubit.dart';

class TodoItem extends StatelessWidget {
  final TodoEntity todoEntity;
  TodoItem(this.todoEntity);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(context: context, builder: (_) => EditTodoDialog(todoEntity)),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: todoEntity.isDone ? Colors.green : Colors.blueAccent,
                radius: 20.0,
                child: todoEntity.isDone
                    ? Icon(Icons.check)
                    : Text(
                        todoEntity.priority.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                todoEntity.text,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    decoration: todoEntity.isDone ? TextDecoration.lineThrough : null),
              ),
              Spacer(),
              InkWell(
                onTap: () => BlocProvider.of<TodosCubit>(context).updateOne(todoEntity.copyWith(isDone: !todoEntity.isDone)),
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.blue,
                  child: Center(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
