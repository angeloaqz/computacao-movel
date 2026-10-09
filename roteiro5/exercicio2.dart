
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MaterialApp(home: TaskScreen()));
}

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController controller = TextEditingController();
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
  }

  Future<void> addTask() async {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      tasks.add(controller.text.trim());
      controller.clear();
    });

    await saveTasks();
  }

  Future<void> removeTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });

    await saveTasks();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tarefas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Nova tarefa',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addTask,
              child: const Text('Adicionar'),
            ),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(
                      child: Text('Nenhuma tarefa cadastrada'),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(tasks[index]),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => removeTask(index),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
