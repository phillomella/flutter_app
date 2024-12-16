import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'contacts_model.dart';

class ContactsEntry extends StatefulWidget {
  final Contact? contact;

  const ContactsEntry({super.key, this.contact});

  @override
  _ContactsEntryState createState() => _ContactsEntryState();
}

class _ContactsEntryState extends State<ContactsEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _phone;
  late String _email;
  late String _avatar;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _name = widget.contact?.name ?? '';
    _phone = widget.contact?.phone ?? '';
    _email = widget.contact?.email ?? '';
    _avatar = widget.contact?.avatar ?? '';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatar = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact == null ? 'Add Contact' : 'Edit Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: _avatar.isNotEmpty ? FileImage(File(_avatar)) : null,
                radius: 50,
                child: _avatar.isEmpty ? Icon(Icons.person, size: 50) : null,
              ),
              TextButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _phone,
                decoration: InputDecoration(labelText: 'Phone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
                onSaved: (value) {
                  _phone = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final contact = Contact(
                      id: widget.contact?.id,
                      name: _name,
                      phone: _phone,
                      email: _email,
                      avatar: _avatar,
                    );

                    if (widget.contact == null) {
                      Provider.of<ContactsModel>(context, listen: false).addContact(contact);
                    } else {
                      Provider.of<ContactsModel>(context, listen: false).updateContact(contact);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.contact == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
