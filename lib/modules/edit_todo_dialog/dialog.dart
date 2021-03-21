import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:simple_todo_app/entities/todo.dart';
import 'package:simple_todo_app/cubits/cubit/todos_cubit.dart';

class EditTodoDialog extends StatefulWidget {
  final TodoEntity todoEntity;
  EditTodoDialog(this.todoEntity);
  @override
  _EditTodoDialogState createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  final _formKey = GlobalKey<FormState>();

  final textController = TextEditingController();

  var priority = 5.0;

  @override
  void initState() {
    textController.text = widget.todoEntity.text;
    priority = widget.todoEntity.priority.toDouble();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: () {
                BlocProvider.of<TodosCubit>(context).deleteOne(widget.todoEntity);
                Navigator.pop(context);
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.all(8),
                color: Color(0xffE02E4D),
                child: Center(
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                maxLines: 1,
                controller: textController,
                decoration: InputDecoration(hintText: 'Enter Task Title..'),
                validator: qValidator([IsRequired()]),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'priority  : ' + priority.round().toString(),
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Slider(
              value: priority,
              onChanged: (v) => setState(() => priority = v),
              min: 1,
              max: 10,
              divisions: 10,
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              color: Colors.blue,
              height: 40.0,
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    BlocProvider.of<TodosCubit>(context).updateOne(
                      widget.todoEntity.copyWith(
                        text: textController.text.trim(),
                        priority: priority.round(),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'UPDATE TODO',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
