import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todo_provider.dart';
import '../model/todo.dart';
import 'package:go_router/go_router.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final bgColor = const Color(0xFFEAF9FF);
    final cardColor = const Color(0xFFF5FDFF);
    final provider = context.watch<TodoProvider>();
    
    final todo = provider.todos.firstWhere(
      (t) => t.id == id,
      orElse: () => Todo(id: 0, todo: 'No encontrada', completed: false, userId: 0),
    );

    if (todo.id == 0) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalle')),
        body: const Center(child: Text('Tarea no encontrada')),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Detalle de Tarea'),
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: cardColor,
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Hero(
                          tag: 'todo-avatar-${todo.id}',
                          child: CircleAvatar(
                            radius: 28,
                            backgroundColor: todo.completed ? Colors.green.shade400 : Colors.red.shade400,
                            child: Icon(
                              todo.completed ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Hero(
                            tag: 'todo-title-${todo.id}',
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                todo.todo,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: todo.completed ? Colors.green.shade700 : Colors.red.shade700,
                                  decoration: todo.completed ? TextDecoration.lineThrough : TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 16),
                    Text(
                      'Estado: ${todo.completed ? "Completada" : " Pendiente"}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: todo.completed ? Colors.green.shade700 : Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('ID de Tarea: ${todo.id}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text('Usuario: ${todo.userId}', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              tileColor: cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              title: const Text('¿Marcar como completada?'),
              value: todo.completed,
              onChanged: (value) async {
                await provider.updateTodoStatus(todo.id, value);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(value ? "Tarea completada" : "Tarea pendiente")),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final confirm = await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text("¿Eliminar tarea?"),
              content: const Text("Esta acción no se puede deshacer."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx, false),
                  child: const Text("Cancelar"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(ctx, true),
                  child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
          if (confirm == true) {
            if (context.mounted) {
           //   await provider.deleteTodo(todo.id);
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Tarea eliminada")),
              );
            }
          }
        },
        backgroundColor: Colors.red.shade600,
        child: const Icon(Icons.delete),
      ),
    );
  }
}

