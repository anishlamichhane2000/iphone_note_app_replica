import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/note.dart';
import '../provider/notes_provider.dart';

class NoteViewScreen extends StatefulWidget {
  final int index;

  const NoteViewScreen({Key? key, required this.index}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State<NoteViewScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool _isEditMode = false;

  @override
  void initState() {
    super.initState();
    final note =
        Provider.of<NotesProvider>(context, listen: false).notes[widget.index];
    _titleController = TextEditingController(text: note.title);
    _descriptionController = TextEditingController(text: note.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _toggleEditMode() {
    setState(() {
      _isEditMode = !_isEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    final note = notesProvider.notes[widget.index];

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Note' : 'Note Details'),
        actions: [
          if (!_isEditMode)
            IconButton(
              onPressed: _toggleEditMode,
              icon: const Icon(Icons.edit),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${note.id}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Divider(thickness: 2, color: Colors.grey[300]),
                const SizedBox(height: 12),
                if (_isEditMode)
                  TextField(
                    controller: _titleController,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      hintText: 'Enter title',
                      border: InputBorder.none,
                    ),
                  ),
                if (!_isEditMode)
                  Text(
                    'Title: ${note.title}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 12),
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (_isEditMode)
                  TextField(
                    controller: _descriptionController,
                    maxLines: 10,
                    decoration: const InputDecoration(
                      hintText: 'Enter Description',
                      border: InputBorder.none,
                    ),
                  ),
                if (!_isEditMode)
                  Text(
                    note.description,
                    style: const TextStyle(fontSize: 18),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _isEditMode
          ? FloatingActionButton(
              onPressed: () {
                notesProvider.updateNote(
                  widget.index,
                  Note(
                    id: note.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    createdAt: note.createdAt,
                  ),
                );
                _toggleEditMode();
              },
              child: const Icon(Icons.check),
            )
          : null,
    );
  }
}
