import 'package:flutter/material.dart';

class ClassScheduleScreen extends StatelessWidget {
  final List<Map<String, String>> schedule = [
    {
      'time': '08:00 AM - 09:30 AM',
      'subject': 'Mathematics',
      'faculty': 'Dr. John Doe',
      'room': 'Room 101'
    },
    {
      'time': '10:00 AM - 11:30 AM',
      'subject': 'Physics',
      'faculty': 'Dr. Jane Smith',
      'room': 'Room 202'
    },
    {
      'time': '01:00 PM - 02:30 PM',
      'subject': 'Computer Science',
      'faculty': 'Prof. Mark Wilson',
      'room': 'Lab 3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Schedules & Faculty Contacts'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: schedule.length,
        itemBuilder: (context, index) {
          final classInfo = schedule[index];
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              title: Text(
                classInfo['subject']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time: ${classInfo['time']}'),
                  Text('Faculty: ${classInfo['faculty']}'),
                  Text('Room: ${classInfo['room']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}