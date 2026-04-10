import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app_pertemuan7/models/todo.dart';

class TodoController {
  static final TodoController _instance = TodoController._internal();
  factory TodoController() => _instance; // Singleton
  TodoController._internal();

  ValueListenable<Box<Todo>> get todos => Hive.box<Todo>('todos').listenable();

  Future<void> addTodo(Todo todo) async {
    final Box<Todo> box = Hive.box<Todo>('todos');
    await box.add(todo);
  }

  Future<void> updateTodo(int index, Todo todo) async {
    final Box<Todo> box = Hive.box<Todo>('todos');
    await box.putAt(index, todo);
  }

  Future<void> deleteTodo(int index) async {
    final Box<Todo> box = Hive.box<Todo>('todos');
    await box.deleteAt(index);
  }
}