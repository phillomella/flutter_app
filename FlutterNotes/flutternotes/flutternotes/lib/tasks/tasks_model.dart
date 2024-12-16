import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Task {
  int? id;
  String title;
  String description;
  String dueDate;
  bool isCompleted;

  Task({this.id, required this.title, required this.description, required this.dueDate, this.isCompleted = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dueDate': dueDate,
      'isCompleted': isCompleted ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dueDate: map['dueDate'],
      isCompleted: map['isCompleted'] == 1,
    );
  }
}

class TasksModel extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    _tasks = List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });

    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final db = await DBHelper().database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    final db = await DBHelper().database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    loadTasks();
  }

  Future<void> deleteTask(int id) async {
    final db = await DBHelper().database;
    await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadTasks();
  }
}
