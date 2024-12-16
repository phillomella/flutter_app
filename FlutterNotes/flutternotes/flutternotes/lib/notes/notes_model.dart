import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Note {
  int? id;
  String title;
  String content;
  String date;

  Note({this.id, required this.title, required this.content, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}

class NotesModel extends ChangeNotifier {
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('notes');

    _notes = List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });

    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    final db = await DBHelper().database;
    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    loadNotes();
  }

  Future<void> updateNote(Note note) async {
    final db = await DBHelper().database;
    await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    loadNotes();
  }

  Future<void> deleteNote(int id) async {
    final db = await DBHelper().database;
    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadNotes();
  }
}
