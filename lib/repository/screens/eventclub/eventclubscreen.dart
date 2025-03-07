import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:all_in_all_university_app/repository/screens/eventclub/airecommandationscreen.dart';

class EventClubScreen extends StatefulWidget {
  const EventClubScreen({super.key});

  @override
  _EventClubScreenState createState() => _EventClubScreenState();
}

class _EventClubScreenState extends State<EventClubScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event & Club Management',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Appcolors.AppBaseColor,
        elevation: 10,
        shadowColor: Appcolors.AppBaseColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.event), text: 'Events'),
            Tab(icon: Icon(Icons.group), text: 'Clubs'),
            Tab(icon: Icon(Icons.auto_awesome), text: 'Recommendations'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [EventsTab(), ClubsTab(), AIRecommendationPage()],
      ),
    );
  }
}

class EventsTab extends StatelessWidget {
  // Static data for events
  final List<Map<String, dynamic>> events = [
    {
      'title': 'Tech Conference 2025',
      'date': '2025-03-24',
      'time': '10:00 AM',
      'location': 'University Auditorium',
      'organizer': 'Computer Science Club',
      'isOpen': true,
    },
    {
      'title': 'Cultural Fest',
      'date': '2025-04-12',
      'time': '5:00 PM',
      'location': 'Main Ground',
      'organizer': 'Cultural Society',
      'isOpen': false,
    },
    {
      'title': 'Startup Pitch Competition',
      'date': '2025-4-20',
      'time': '2:00 PM',
      'location': 'Business School',
      'organizer': 'Entrepreneurship Club',
      'isOpen': true,
    },
  ];

  EventsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final isEventOpen = event['isOpen'];

        return Card(
          margin: EdgeInsets.all(10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              // Handle event tap
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '📅 ${event['date']} | ⏰ ${event['time']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '📍 ${event['location']}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Organized by: ${event['organizer']}',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GuardButton(
                      condition: isEventOpen,
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'RSVP confirmed for ${event['title']}',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Appcolors.AppBaseColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'RSVP',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ClubsTab extends StatelessWidget {
  // Static data for clubs
  final List<Map<String, dynamic>> clubs = [
    {
      'name': 'Photography Club',
      'description': 'Capture the world through your lens.',
      'isMember': false,
    },
    {
      'name': 'Drama Club',
      'description': 'Express yourself on stage.',
      'isMember': true,
    },
    {
      'name': 'Robotics Club',
      'description': 'Build, code, and innovate.',
      'isMember': false,
    },
  ];

 ClubsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clubs.length,
      itemBuilder: (context, index) {
        final club = clubs[index];
        final isMember = club['isMember'];

        return Card(
          margin: EdgeInsets.all(10),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () {
              // Handle club tap
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.group, color: Appcolors.AppBaseColor, size: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          club['name'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          club['description'],
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  GuardButton(
                    condition: !isMember,
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Joined ${club['name']}')),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Appcolors.AppBaseColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Join',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class GuardButton extends StatelessWidget {
  final bool condition;
  final VoidCallback onPressed;
  final Widget child;

  const GuardButton({super.key, 
    required this.condition,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return condition
        ? InkWell(onTap: onPressed, child: child)
        : SizedBox.shrink();
  }
}
