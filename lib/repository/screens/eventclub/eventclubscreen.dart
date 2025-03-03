import 'package:flutter/material.dart';

class EventClubScreen extends StatelessWidget {
  final List<Map<String, String>> events = [
    {
      'title': 'Tech Talk: AI Innovations',
      'date': 'March 10, 2025',
      'time': '4:00 PM - 6:00 PM',
      'location': 'Auditorium',
      'organizer': 'Tech Club'
    },
    {
      'title': 'Music Fest 2025',
      'date': 'March 15, 2025',
      'time': '7:00 PM - 10:00 PM',
      'location': 'Open Grounds',
      'organizer': 'Music Club'
    },
    {
      'title': 'Robotics Workshop',
      'date': 'March 20, 2025',
      'time': '10:00 AM - 1:00 PM',
      'location': 'Lab 5',
      'organizer': 'Robotics Club'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event & Club Management'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      event['title']!,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: ${event['date']}'),
                        Text('Time: ${event['time']}'),
                        Text('Location: ${event['location']}'),
                        Text('Organizer: ${event['organizer']}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.event_available, color: Colors.green),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('RSVP confirmed for ${event['title']}')),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('AI-based event recommendations coming soon!')),
              );
            },
            child: Text('Get AI Event Recommendations'),
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
