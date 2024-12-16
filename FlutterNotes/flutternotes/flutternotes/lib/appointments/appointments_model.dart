import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Appointment {
  int? id;
  String title;
  String description;
  String date;
  String time;

  Appointment({this.id, required this.title, required this.description, required this.date, required this.time});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      time: map['time'],
    );
  }
}

class AppointmentsModel extends ChangeNotifier {
  List<Appointment> _appointments = [];

  List<Appointment> get appointments => _appointments;

  Future<void> loadAppointments() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('appointments');

    _appointments = List.generate(maps.length, (i) {
      return Appointment.fromMap(maps[i]);
    });

    notifyListeners();
  }

  Future<void> addAppointment(Appointment appointment) async {
    final db = await DBHelper().database;
    await db.insert(
      'appointments',
      appointment.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    loadAppointments();
  }

  Future<void> updateAppointment(Appointment appointment) async {
    final db = await DBHelper().database;
    await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
    loadAppointments();
  }

  Future<void> deleteAppointment(int id) async {
    final db = await DBHelper().database;
    await db.delete(
      'appointments',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadAppointments();
  }
}
