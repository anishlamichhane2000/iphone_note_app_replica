import 'package:flutter/material.dart';
import 'package:iphone_note_app_replica/provider/notes_provider.dart';
import 'package:provider/provider.dart';

import 'screens/splash_screen_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        home: const SplashScreen(),
      ),
    );
  }
}
