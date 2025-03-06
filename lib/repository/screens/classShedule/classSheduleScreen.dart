import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';

class ClassScheduleScreen extends StatefulWidget {
  final String userRole;
  final List<String> enrolledCourses;

  const ClassScheduleScreen({super.key, required this.userRole, required this.enrolledCourses});

  @override
  _ClassScheduleScreenState createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  List<Map<String, dynamic>> schedule = [];

  @override
  void initState() {
    super.initState();
    // Initialize the schedule with static data
    initializeStaticSchedule();
  }

  void initializeStaticSchedule() {
    final List<Map<String, dynamic>> staticSchedule = [
      {
        'subject': 'Mathematics',
        'time': '10:00 AM - 11:30 AM',
        'faculty': 'Dr. John Doe',
        'room': 'Room 101'
      },
      {
        'subject': 'Physics',
        'time': '12:00 PM - 1:30 PM',
        'faculty': 'Dr. Jane Smith',
        'room': 'Room 202'
      },
      {
        'subject': 'Chemistry',
        'time': '2:00 PM - 3:30 PM',
        'faculty': 'Dr. Alice Johnson',
        'room': 'Room 303'
      },
      // Add more static data as needed
    ];

    setState(() {
      if (widget.userRole == 'student') {
        // Filter the schedule based on enrolled courses
        schedule = staticSchedule
            .where((classInfo) => widget.enrolledCourses.contains(classInfo['subject']))
            .toList();
      } else {
        // If the user is not a student, show all courses
        schedule = staticSchedule;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Schedules'),
        centerTitle: true,
        backgroundColor: Appcolors.AppBaseColor,
      ),
      body: schedule.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                final classInfo = schedule[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade50, Colors.white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      )
                    ],
                  ),
                  child: Card(
                    elevation: 0, // Remove default card shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.zero, // Remove card margin
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            classInfo['subject'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade900,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.access_time, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'Time: ${classInfo['time']}',
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.person, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'Faculty: ${classInfo['faculty']}',
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.room, size: 16, color: Colors.grey),
                              SizedBox(width: 8),
                              Text(
                                'Room: ${classInfo['room']}',
                                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}