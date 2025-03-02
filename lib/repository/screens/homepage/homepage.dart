import 'package:all_in_all_university_app/repository/screens/busSchedule/busScheduleScreen.dart';
import 'package:all_in_all_university_app/repository/screens/cafeteria/cafeteriamenuScreen.dart';
import 'package:all_in_all_university_app/repository/screens/campusNavigation/campusNavigationscreen.dart';
import 'package:all_in_all_university_app/repository/screens/classShedule/classSheduleScreen.dart';
import 'package:all_in_all_university_app/repository/screens/eventclub/eventclubscreen.dart';
import 'package:all_in_all_university_app/repository/widgets/FeatureTile.dart';
import 'package:flutter/material.dart';

class UniversityHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyUniversity App'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            FetureTile.buildFeatureTile(
              context,
              Icons.restaurant_menu,
              'Cafeteria Menu',
              CafeteriaMenuScreen(),
            ),
            FetureTile.buildFeatureTile(
              context,
              Icons.directions_bus,
              'Bus Schedules',
              BusScheduleScreen(),
            ),
            FetureTile.buildFeatureTile(
              context,
              Icons.schedule,
              'Class Schedules',
              ClassScheduleScreen(),
            ),
            FetureTile.buildFeatureTile(
              context,
              Icons.groups,
              'Event & Club Management',
              EventClubScreen(),
            ),
            FetureTile.buildFeatureTile(
              context,
              Icons.map,
              'Campus Navigation',
              CampusNavigationScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
