import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_model.dart';

class TasksEntry extends StatefulWidget {
  final Task? task;

  const TasksEntry({super.key, this.task});

  @override
  _TasksEntryState createState() => _TasksEntryState();
}

class _TasksEntryState extends State<TasksEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _dueDate;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _title = widget.task?.title ?? '';
    _description = widget.task?.description ?? '';
    _dueDate = widget.task?.dueDate ?? DateTime.now().toIso8601String();
    _isCompleted = widget.task?.isCompleted ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              TextFormField(
                initialValue: _dueDate,
                decoration: InputDecoration(labelText: 'Due Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a due date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _dueDate = value!;
                },
              ),
              CheckboxListTile(
                title: Text("Completed"),
                value: _isCompleted,
                onChanged: (bool? value) {
                  setState(() {
                    _isCompleted = value ?? false;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final task = Task(
                      id: widget.task?.id,
                      title: _title,
                      description: _description,
                      dueDate: _dueDate,
                      isCompleted: _isCompleted,
                    );

                    if (widget.task == null) {
                      Provider.of<TasksModel>(context, listen: false).addTask(task);
                    } else {
                      Provider.of<TasksModel>(context, listen: false).updateTask(task);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.task == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
