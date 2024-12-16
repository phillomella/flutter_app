import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../db_helper.dart';

class Contact {
  int? id;
  String name;
  String phone;
  String email;
  String avatar;

  Contact({this.id, required this.name, required this.phone, required this.email, required this.avatar});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'avatar': avatar,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      email: map['email'],
      avatar: map['avatar'],
    );
  }
}

class ContactsModel extends ChangeNotifier {
  List<Contact> _contacts = [];

  List<Contact> get contacts => _contacts;

  Future<void> loadContacts() async {
    final db = await DBHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('contacts');

    _contacts = List.generate(maps.length, (i) {
      return Contact.fromMap(maps[i]);
    });

    notifyListeners();
  }

  Future<void> addContact(Contact contact) async {
    final db = await DBHelper().database;
    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    loadContacts();
  }

  Future<void> updateContact(Contact contact) async {
    final db = await DBHelper().database;
    await db.update(
      'contacts',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
    loadContacts();
  }

  Future<void> deleteContact(int id) async {
    final db = await DBHelper().database;
    await db.delete(
      'contacts',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadContacts();
  }
}
