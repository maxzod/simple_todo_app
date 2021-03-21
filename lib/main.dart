import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_todo_app/modules/home/page.dart';
import 'package:simple_todo_app/cubits/cubit/todos_cubit.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();

  runApp(
    BlocProvider(
      create: (_) => TodosCubit(),
      child: MaterialApp(
        title: 'todos',
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
