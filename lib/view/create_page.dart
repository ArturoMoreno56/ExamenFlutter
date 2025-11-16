import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider.dart';
import 'package:go_router/go_router.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Tarea")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: "Título"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final title = controller.text;

                if (title.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ingrse el titulo de la tarea"), backgroundColor: Colors.blue),
                  );
                  return;
                }

                await context.read<TodoProvider>().addNewTodo(title);
                context.pop();
              },
              child: const Text("Guardar"),
            )
          ],
        ),
      ),
    );
  }
}
