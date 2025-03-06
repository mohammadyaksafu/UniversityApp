import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/busSchedule/busScheduleScreen.dart';
import 'package:all_in_all_university_app/repository/screens/cafeteria/cafeteriamenuScreen.dart';
import 'package:all_in_all_university_app/repository/screens/campusNavigation/campusNavigationscreen.dart';
import 'package:all_in_all_university_app/repository/screens/classShedule/classSheduleScreen.dart';
import 'package:all_in_all_university_app/repository/screens/eventclub/eventclubscreen.dart';
import 'package:all_in_all_university_app/repository/screens/personalhelp/personalhelpAi.dart';
import 'package:all_in_all_university_app/repository/widgets/FeatureTile.dart';
import 'package:flutter/material.dart';

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
                crossAxisCount: 2, 
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio:1.6,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
