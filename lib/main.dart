import 'package:all_in_all_university_app/repository/screens/homepage/homepage.dart';
import 'package:all_in_all_university_app/repository/screens/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

void main() {
 WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'AIzaSyAhzZgGcf9dst7xlz5MGWyNcXV1BCO3VOA');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LoginScreen() ,
    );
  }
}

  








