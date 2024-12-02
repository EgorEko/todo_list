import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/todo_item.dart';
import '../services/todo_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _todoController = TextEditingController();
  String newTask = '';

  @override
  void initState() {
    super.initState();
    _todoController.addListener(() {
      newTask = _todoController.text;
    });
  }

  @override
  void dispose() {
    _todoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    final tasks = Provider.of<List<TodoItem>>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO list'),
        actions: [
          TextButton(
            onPressed: () => _showAddTextDialog(),
            child: const Text('Add task'),
          ),
        ],
      ),
      body: tasks.isEmpty
          ? const Center(
              child: Text('No tasks found'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: InkWell(
                    onTap: () => todoProvider.toggleTodo(tasks[index]),
                    child: Text(
                      tasks[index].title,
                      style: tasks[index].isCompleted
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            )
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      print(tasks[index].id);
                      todoProvider.deleteTodo(tasks[index]);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: tasks[index].isCompleted
                          ? Colors.redAccent
                          : Colors.black,
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future<void> _showAddTextDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add a new Task'),
          content: TextField(
            autofocus: true,
            controller: _todoController,
            decoration: const InputDecoration(hintText: 'Add New Task'),
            onSubmitted: (_) => _submit(),
          ),
          actions: [
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(minimumSize: const Size(120, 40)),
              child: const Text('Submit'),
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  void _submit() {
    Provider.of<TodoProvider>(context, listen: false).addTodo(newTask, false);
    Navigator.pop(context);
    _todoController.clear();
  }
}
