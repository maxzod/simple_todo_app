import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queen_validators/queen_validators.dart';
import 'package:simple_todo_app/entities/todo.dart';
import 'package:simple_todo_app/cubits/cubit/todos_cubit.dart';

class CreateTodoDilaog extends StatefulWidget {
  @override
  _CreateTodoDilaogState createState() => _CreateTodoDilaogState();
}

class _CreateTodoDilaogState extends State<CreateTodoDilaog> {
  final _formKey = GlobalKey<FormState>();
  final textController = TextEditingController();
  var priority = 5.0;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: textController,
                decoration: InputDecoration(hintText: 'Enter Task Title..'),
                validator: qValidator([IsRequired()]),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'priority  : ' + priority.round().toString(),
              style: Theme.of(context).textTheme.headline5,
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
                    BlocProvider.of<TodosCubit>(context).createOne(TodoEntity(text: textController.text.trim(), priority: priority.round()));
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'ADD NEW TASK',
                  style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
