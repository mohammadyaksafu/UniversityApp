import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/busSchedule/busScheduleScreen.dart';
import 'package:all_in_all_university_app/repository/screens/cafeteria/cafeteriamenuScreen.dart';
import 'package:all_in_all_university_app/repository/screens/campusNavigation/campusNavigationscreen.dart';
import 'package:all_in_all_university_app/repository/screens/classShedule/classSheduleScreen.dart';
import 'package:all_in_all_university_app/repository/screens/eventclub/eventclubscreen.dart';
import 'package:all_in_all_university_app/repository/screens/personalhelp/personalhelpAi.dart';
import 'package:all_in_all_university_app/repository/widgets/FeatureTile.dart';

class UniversityHome extends StatelessWidget {
  final String userRole;
  final List<String> enrolledCourses;
  const UniversityHome({
    super.key,
    required this.userRole,
    required this.enrolledCourses,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MIST'),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Appcolors.AppBaseColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(8),
              child: Image.asset(
                'images/mistlog.png',
                height: 80,
                width: 80,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount:2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 10,
                childAspectRatio: 1.8,
                children: [
                  FeatureTile.buildFeatureTile(
                    context,
                    Icons.restaurant_menu,
                    'Cafeteria Menu',
                    CafeteriaMenuScreen(),
                  ),
                  FeatureTile.buildFeatureTile(
                    context,
                    Icons.directions_bus,
                    'Bus Schedules',
                    BusScheduleScreen(),
                  ),
                  FeatureTile.buildFeatureTile(
                    context,
                    Icons.schedule,
                    'Class Schedules',
                    ClassScheduleScreen(
                      userRole: userRole,
                      enrolledCourses: enrolledCourses,
                    ),
                  ),
                  FeatureTile.buildFeatureTile(
                    context,
                    Icons.groups,
                    'Event & Club',
                    EventClubScreen(),
                  ),
                  FeatureTile.buildFeatureTile(
                    context,
                    Icons.map,
                    'Campus Navigation',
                    CampusNavigationScreen(),
                  ),
                  FeatureTile.buildFeatureTile(
                    context,
                    Icons.help_center,
                    'Help Page',
                    PersonalHelpAI(),
                  ),
                  FeatureTile.buildFeatureTile(
                    context,
                    Icons.announcement,
                    'Updates & Alerts',
                    UpdatesAndAlertsScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdatesAndAlertsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates & Alerts'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No messages yet.'));
          }

          // Wrap the ListView.builder in a RefreshIndicator
          return RefreshIndicator(
            onRefresh: () async {
              // Force a refresh of the stream
              // This is optional and works well with Firestore's real-time updates
              await FirebaseFirestore.instance
                  .collection('messages')
                  .get();
            },
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var message = snapshot.data!.docs[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    title: Text(
                      message['type'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(message['message']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}