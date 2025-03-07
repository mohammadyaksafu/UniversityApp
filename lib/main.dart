import 'package:all_in_all_university_app/repository/screens/eventclub/eventclubscreen.dart';
import 'package:all_in_all_university_app/repository/screens/homepage/homepage.dart';
import 'package:all_in_all_university_app/repository/screens/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Gemini (AI service)
  Gemini.init(apiKey: 'AIzaSyAhzZgGcf9dst7xlz5MGWyNcXV1BCO3VOA');

  // Run the app
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
