import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/notes_provider.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeNotesProvider();
  }

  void _initializeNotesProvider() async {
    // Initialize the NotesProvider and load the notes data from SharedPreferences
    await Provider.of<NotesProvider>(context, listen: false)
        .initSharedPreferences();

    // Add a delay to simulate a splash screen effect
    Future.delayed(const Duration(seconds: 4), () {
      _navigateToNoteListScreen();
    });
  }

  void _navigateToNoteListScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NoteListScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "assests/img/1.jpg",
                fit: BoxFit.fill, // Replace with your image file path
                width: 800,
                height: 1000,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(5),
                color: Colors.transparent,
                child: const Text(
                  'Note App Loading .....',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
