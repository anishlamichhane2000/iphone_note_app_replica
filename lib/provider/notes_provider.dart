import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

import '../model/note.dart'; // Import the math library to use the max function

class NotesProvider with ChangeNotifier {
  final List<Note> _notes = [];
  int _counter = 1; // Initialize a counter to assign sequential IDs

  List<Note> get notes => _notes;

  // Initialize SharedPreferences and load notes data
  Future<void> initSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? notesData = prefs.getStringList('notes_data');
    if (notesData != null) {
      _notes.clear();
      int maxId = 0; // Initialize maxId to 0
      for (String noteJson in notesData) {
        final decodedData = json.decode(noteJson);
        if (decodedData != null) {
          final note = Note.fromJson(decodedData);
          _notes.add(note);
          // Update maxId if a note with a higher ID is found
          maxId = max(maxId, int.parse(note.id));
        }
      }
      _counter = maxId + 1; // Set _counter to one greater than the maximum ID
    }
  }

  void addNote(Note note) {
    note.id = _counter.toString();
    _counter++;
    _notes.add(note);
    _saveNotesToSharedPreferences();
    notifyListeners();
  }

  void updateNote(int index, Note updatedNote) {
    if (index >= 0 && index < _notes.length) {
      _notes[index] = updatedNote;
      _saveNotesToSharedPreferences();
      notifyListeners();
    }
  }

  void deleteNote(int index) {
    if (index >= 0 && index < _notes.length) {
      _notes.removeAt(index);
      _saveNotesToSharedPreferences();
      notifyListeners();
    }
  }

  // Save notes to SharedPreferences
  Future<void> _saveNotesToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notesData =
        _notes.map((note) => json.encode(note.toJson())).toList();
    prefs.setStringList('notes_data', notesData);
  }
}
