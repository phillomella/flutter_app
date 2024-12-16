import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_model.dart';
import 'tasks_entry.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TasksEntry()),
              );
            },
          ),
        ],
      ),
      body: Consumer<TasksModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.tasks.length,
            itemBuilder: (context, index) {
              final task = model.tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.dueDate),
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    model.updateTask(Task(
                      id: task.id,
                      title: task.title,
                      description: task.description,
                      dueDate: task.dueDate,
                      isCompleted: value ?? false,
                    ));
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TasksEntry(task: task),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    model.deleteTask(task.id!);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
