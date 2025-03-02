import 'package:flutter/material.dart';

class CafeteriaMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cafeteria Menu')),
      body: Center(
        child: Text('Display Cafeteria Menu & Meal Schedules here.'),
      ),
    );
  }
}