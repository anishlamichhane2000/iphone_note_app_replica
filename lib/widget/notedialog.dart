import 'package:flutter/material.dart';
import '../model/note.dart';

class NoteDialogHelper {
  static void showAddEditNoteDialog(
      BuildContext context, Note? note, Function onSave) {
    final titleController = TextEditingController(text: note?.title);
    final contentController = TextEditingController(text: note?.description);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'Add Note' : 'Edit Note'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final updatedNote = Note(
                id: note?.id ?? DateTime.now().toString(),
                title: titleController.text,
                description: contentController.text,
                createdAt: note?.createdAt ?? DateTime.now(),
              );
              onSave(updatedNote);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
