import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'contacts_model.dart';
import 'contacts_entry.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactsEntry()),
              );
            },
          ),
        ],
      ),
      body: Consumer<ContactsModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.contacts.length,
            itemBuilder: (context, index) {
              final contact = model.contacts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: contact.avatar.isNotEmpty
                      ? FileImage(File(contact.avatar))
                      : null,
                  child: contact.avatar.isEmpty ? Icon(Icons.person) : null,
                ),
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactsEntry(contact: contact),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    model.deleteContact(contact.id!);
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
