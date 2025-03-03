import 'package:flutter/material.dart';

class PersonalHelpAI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Help AI'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can I assist you today?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.question_answer, color: Colors.blue),
                    title: Text('Ask a Question'),
                    subtitle: Text('Get answers to your queries instantly'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Feature coming soon!')),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.schedule, color: Colors.green),
                    title: Text('Schedule Assistance'),
                    subtitle: Text('Manage your daily schedule efficiently'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Feature coming soon!')),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.orange),
                    title: Text('Personalized Advice'),
                    subtitle: Text('Get AI-driven personal recommendations'),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Feature coming soon!')),
                      );
                    },
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
