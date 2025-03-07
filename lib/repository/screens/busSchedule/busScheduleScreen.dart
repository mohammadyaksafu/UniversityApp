import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'notification_service.dart'; // Import the notification service

class BusScheduleScreen extends StatelessWidget {
  final List<Map<String, String>> busSchedules = [
    {'route': 'MIST -Dhaka Medical', 'time': '08:00 AM - 10:00 PM'},
    {'route': 'MIST - ECB', 'time': '07:30 AM - 09:30 PM'},
    {'route': 'MIST - Tongi', 'time': '09:00 AM - 11:00 PM'},
  ];

  final NotificationService notificationService = NotificationService();

  BusScheduleScreen({super.key}) {
    notificationService.init(); // Initialize notifications
  }

  // Helper function to parse time string (e.g., "08:00 AM") into DateTime
  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final timeParts = time.split(' ');
    final hourMinute = timeParts[0].split(':');
    int hour = int.parse(hourMinute[0]);
    final minute = int.parse(hourMinute[1]);

    if (timeParts[1] == 'PM' && hour != 12) {
      hour += 12;
    }

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bus Routes & Schedules',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Appcolors.AppBaseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: busSchedules.length,
          itemBuilder: (context, index) {
            final schedule = busSchedules[index];
            final route = schedule['route']!;
            final time = schedule['time']!;

            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.directions_bus,
                  color: Appcolors.AppBaseColor,
                  size: 30,
                ),
                title: Text(
                  route,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Timing: $time',
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Appcolors.AppBaseColor,
                  ),
                  onPressed: () async {
                    // Schedule a notification 10 minutes before the bus departure time
                    final departureTime = _parseTime(time.split(' - ')[0]);
                    final notificationTime = departureTime.subtract(
                      const Duration(minutes: 10),
                    );

                    await notificationService.scheduleNotification(
                      id: index,
                      title: 'Bus Reminder: $route',
                      body: 'Your bus ($route) is departing soon at $time.',
                      scheduledTime: notificationTime,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Notification scheduled successfully!'),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
