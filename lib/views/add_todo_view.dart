import 'package:flutter/material.dart';
import 'package:todo_app_pertemuan7/controllers/todo_controller.dart';
import 'package:todo_app_pertemuan7/models/todo.dart';

class AddTodoView extends StatefulWidget {
  final int? index;
  final Todo? todo;
  const AddTodoView({super.key, this.index, this.todo});

  @override
  State<AddTodoView> createState() => _AddTodoViewState();
}

class _AddTodoViewState extends State<AddTodoView> {
  final _controller = TodoController();
  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  bool _isEditMode = false;

  @override
  void initState() {
    _isEditMode = widget.index == null && widget.todo == null ? false : true;
    super.initState();
    if(_isEditMode){
      _titleController.text = widget.todo!.title;
      _subtitleController.text = widget.todo!.subtitle;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditMode ? "Edit Todo" : "Add Todo")),

      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: ListView(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 8,),
            TextField(
              controller: _subtitleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Subtitle',
              ),
            ),

            SizedBox(height: 6,),
            ElevatedButton(
              onPressed: () async {
                final newTodo = Todo(title: _titleController.text, subtitle: _subtitleController.text);
                if(_isEditMode){
                  await _controller.updateTodo(widget.index!, newTodo);
                } else {
                  await _controller.addTodo(newTodo);
                }

                if(context.mounted) Navigator.pop(context);
              },
              child: Text(_isEditMode ? "Edit Todo" : "Add Todo")
            )
          ],
        ),
      ),
    );
  }
}
