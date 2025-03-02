import 'package:flutter/material.dart';

class BusScheduleScreen extends StatelessWidget {
  final List<Map<String, String>> busSchedules = [
    {'route': 'Route A', 'time': '08:00 AM - 10:00 PM'},
    {'route': 'Route B', 'time': '07:30 AM - 09:30 PM'},
    {'route': 'Route C', 'time': '09:00 AM - 11:00 PM'},
    {'route': 'Route D', 'time': '06:45 AM - 08:45 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Routes & Schedules', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: busSchedules.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.directions_bus, color: Colors.blueAccent, size: 30),
                title: Text(busSchedules[index]['route']!,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text('Timing: ${busSchedules[index]['time']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
                onTap: () {
                  // Add navigation or details action
                },
              ),
            );
          },
        ),
      ),
    );
  }
}