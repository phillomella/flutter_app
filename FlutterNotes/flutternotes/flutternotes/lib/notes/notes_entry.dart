import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_model.dart';

class NotesEntry extends StatefulWidget {
  final Note? note;

  const NotesEntry({super.key, this.note});

  @override
  _NotesEntryState createState() => _NotesEntryState();
}

class _NotesEntryState extends State<NotesEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
  late String _date;

  @override
  void initState() {
    super.initState();
    _title = widget.note?.title ?? '';
    _content = widget.note?.content ?? '';
    _date = widget.note?.date ?? DateTime.now().toIso8601String();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Add Note' : 'Edit Note'),
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
                initialValue: _content,
                decoration: InputDecoration(labelText: 'Content'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
                onSaved: (value) {
                  _content = value!;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    final note = Note(
                      id: widget.note?.id,
                      title: _title,
                      content: _content,
                      date: _date,
                    );

                    if (widget.note == null) {
                      Provider.of<NotesModel>(context, listen: false).addNote(note);
                    } else {
                      Provider.of<NotesModel>(context, listen: false).updateNote(note);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.note == null ? 'Add' : 'Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
