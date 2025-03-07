import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/login/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherDashboardApp extends StatelessWidget {
  const TeacherDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teacher Dashboard',
      debugShowCheckedModeBanner: false,
      color: Appcolors.AppBaseColor,
      home: TeacherDashboardPage(),
    );
  }
}

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  _TeacherDashboardPageState createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  // Controller for the custom message input
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  
  // Function to send a message
  void _sendMessage(String type, String message) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messageList = prefs.getStringList('messages') ?? [];
    messageList.add('$type|$message');
    await prefs.setStringList('messages', messageList);
    
    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Message sent to students'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Function to handle custom message sending
  void _sendCustomMessage() {
    if (_titleController.text.isNotEmpty && _messageController.text.isNotEmpty) {
      _sendMessage(_titleController.text, _messageController.text);
      // Clear text fields after sending
      _titleController.clear();
      _messageController.clear();
    } else {
      // Show error if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill both title and message'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // Function to handle logout
  void _logout(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  void dispose() {
   
    _messageController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Dashboard'),
        centerTitle: true,
        actions: [
          // Logout button
          IconButton(
            icon: Icon(Icons.logout, color: Colors.white),
            onPressed: () => _logout(context),
          ),
        ],
        backgroundColor: Appcolors.AppBaseColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Quick Action Buttons
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Appcolors.AppBaseColor,
              ),
            ),
            SizedBox(height: 12),
            // Class Update Button
            _buildActionButton(
              context,
              'Class Update',
              'The next class will be on Friday at 10 AM.',
              Colors.blue,
              Icons.schedule,
            ),
            SizedBox(height: 16),
            // Make Announcement Button
            _buildActionButton(
              context,
              'Make Announcement',
              'The mid-term exams will start next week.',
              Colors.green,
              Icons.announcement,
            ),
            SizedBox(height: 16),
            // Emergency Alert Button
            _buildActionButton(
              context,
              'Emergency Alert',
              'School will be closed tomorrow due to heavy rain.',
              Colors.red,
              Icons.warning,
            ),
            SizedBox(height: 24),
            
            // Custom Message Section
            Text(
              'Send Custom Message',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Appcolors.AppBaseColor,
              ),
            ),
            SizedBox(height: 12),
            // Custom message input box
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title Input
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Message Title',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.title),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Message Input
                    TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: 'Message Content',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.message),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16),
                    // Send Button
                    ElevatedButton.icon(
                      icon: Icon(Icons.send),
                      label: Text('Send Message'),
                      onPressed: _sendCustomMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.AppBaseColor,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to build action buttons
  Widget _buildActionButton(
    BuildContext context,
    String title,
    String message,
    Color color,
    IconData icon,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          _sendMessage(title, message);
          // Show confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title sent to students'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 30),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}