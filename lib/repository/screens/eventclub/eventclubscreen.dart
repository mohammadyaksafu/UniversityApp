import 'dart:convert';
import 'package:all_in_all_university_app/repository/screens/eventclub/eventandclubpage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:all_in_all_university_app/repository/screens/eventclub/airecommandationscreen.dart';

class EventClubScreen extends StatefulWidget {
  @override
  _EventClubScreenState createState() => _EventClubScreenState();
}

class _EventClubScreenState extends State<EventClubScreen> {
  List<Map<String, dynamic>> events = [];
  List<Map<String, dynamic>> clubs = [];
  bool isLoggedIn = true; // Simulate user login state

  @override
  void initState() {
    super.initState();
    fetchEvents();
    fetchClubs();
  }

  Future<void> fetchEvents() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/events'));
    if (response.statusCode == 200) {
      setState(() {
        events = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    }
  }

  Future<void> fetchClubs() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/clubs'));
    if (response.statusCode == 200) {
      setState(() {
        clubs = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    }
  }

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
                final isEventOpen = event['isOpen'];

                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      event['title'],
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
                    trailing: GuardButton(
                      condition: isEventOpen,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('RSVP confirmed for ${event['title']}')),
                        );
                      },
                      child: Icon(Icons.event_available, color: Colors.green),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 20, thickness: 2),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Student Clubs & Organizations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: clubs.length,
              itemBuilder: (context, index) {
                final club = clubs[index];
                final isMember = club['isMember'];

                return Card(
                  margin: EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(10),
                    title: Text(
                      club['name'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(club['description']),
                    trailing: GuardButton(
                      condition: !isMember,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Joined ${club['name']}')),
                        );
                      },
                      child: Text('Join', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                );
              },
            ),
          ),
          GuardButton(
            condition: isLoggedIn,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AIRecommendationPage()),
              );
            },
            child: Text('Get AI Event Recommendations'),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
