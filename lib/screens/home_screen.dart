import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/note.dart';
import '../provider/notes_provider.dart';
import '../widget/dialog.dart';

import '../widget/notedialog.dart';
import 'note_view_screen.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the NotesProvider and load the notes data from SharedPreferences
    Provider.of<NotesProvider>(context, listen: false).initSharedPreferences();
  }

  void _viewNoteDetails(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteViewScreen(index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: Container(
        color: Colors.lightBlue,
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: notesProvider.notes.length,
          itemBuilder: (context, index) {
            final Note note = notesProvider.notes[index];
            return Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                tileColor: Colors.white,
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      note.id,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                title: Text(
                  note.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Created on: ${note.createdAt.toLocal()}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        NoteDialogHelper.showAddEditNoteDialog(
                          context,
                          note,
                          (updatedNote) {
                            Provider.of<NotesProvider>(context, listen: false)
                                .updateNote(index, updatedNote);
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        DialogHelper.showDeleteConfirmationDialog(
                          context,
                          () {
                            Provider.of<NotesProvider>(context, listen: false)
                                .deleteNote(index);
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
                onTap: () {
                  _viewNoteDetails(context, index);
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          NoteDialogHelper.showAddEditNoteDialog(
            context,
            null,
            (newNote) {
              Provider.of<NotesProvider>(context, listen: false)
                  .addNote(newNote);
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
