import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO list'),
        actions: [
          TextButton(
            onPressed: () => _showAddTextDialog(),
            child: const Text('Add todo'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoProvider.allTodos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: InkWell(
              onTap: () =>
                  todoProvider.toggleTodo(todoProvider.allTodos[index]),
              child: Text(
                todoProvider.allTodos[index].title,
                style: todoProvider.allTodos[index].isCompleted
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                todoProvider.deleteTodo(todoProvider.allTodos[index]);
              },
              icon: const Icon(Icons.delete),
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
