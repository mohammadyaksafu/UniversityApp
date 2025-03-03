import 'package:flutter/material.dart';

class CampusNavigationScreen extends StatelessWidget {
  final List<Map<String, String>> locations = [
    {'name': 'Main Library', 'description': 'Open 8 AM - 10 PM', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Engineering Building', 'description': 'Houses CS, EE, and ME departments', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Faculty Offices', 'description': 'Meet your professors here', 'image': 'https://via.placeholder.com/150'},
    {'name': 'Student Center', 'description': 'Cafeteria, lounge, and club rooms', 'image': 'https://via.placeholder.com/150'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Navigation & AR Map'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: locations.length,
              itemBuilder: (context, index) {
                final location = locations[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    leading: Image.network(location['image']!, width: 60, height: 60, fit: BoxFit.cover),
                    title: Text(
                      location['name']!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(location['description']!),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Navigate to AR Map Feature (to be implemented)
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Launching AR Wayfinding...')),
              );
            },
            child: Text('Use AR Navigation'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textStyle: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}