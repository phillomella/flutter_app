import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'notes_model.dart';
import 'notes_entry.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotesEntry()),
              );
            },
          ),
        ],
      ),
      body: Consumer<NotesModel>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.notes.length,
            itemBuilder: (context, index) {
              final note = model.notes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.date),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotesEntry(note: note),
                    ),
                  );
                },
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    model.deleteNote(note.id!);
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
