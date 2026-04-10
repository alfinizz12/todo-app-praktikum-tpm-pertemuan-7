import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_pertemuan7/controllers/todo_controller.dart';
import 'package:todo_app_pertemuan7/models/todo.dart';
import 'package:todo_app_pertemuan7/views/add_todo_view.dart';
import 'package:todo_app_pertemuan7/views/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = TodoController();
  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("isLogin");

    if(mounted){
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (_) => LoginView()), 
        (route) => false
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            onPressed: _logout, 
            icon: Icon(Icons.logout)
          )
        ],
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(14),
        child: ValueListenableBuilder(
          valueListenable: _controller.todos, 
          builder: (context, Box value, child){
            return value.isEmpty ? Center(child: Text("Todo masih kosong!"),) : ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                final Todo todo = value.getAt(index);
                return Card(
                  elevation: 4,
                  child: ListTile(
                    onLongPress: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => AddTodoView(index: index, todo: todo,))
                    ),
                    title: Text(todo.title),
                    subtitle: Text(todo.subtitle),
                    trailing: IconButton(
                      onPressed: () async {
                        await _controller.deleteTodo(index);
                      }, 
                      icon: Icon(Icons.delete)
                    ),
                  ),
                );
              }
            );
          }
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTodoView()));
        }
      ),
    );
  }
}