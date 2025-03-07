
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdatesAndAlertsScreen extends StatefulWidget {
  @override
  _UpdatesAndAlertsScreenState createState() => _UpdatesAndAlertsScreenState();
}

class _UpdatesAndAlertsScreenState extends State<UpdatesAndAlertsScreen> {
  List<Map<String, String>> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messageList = prefs.getStringList('messages');
    if (messageList != null) {
      setState(() {
        messages = messageList.map((message) {
          var parts = message.split('|');
          return {'type': parts[0], 'message': parts[1]};
        }).toList();
      });
    }
  }

  Future<void> _refreshMessages() async {
    await _loadMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Updates & Alerts'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMessages,
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            var message = messages[index];
            return Card(
              margin: EdgeInsets.only(bottom: 16),
              child: ListTile(
                title: Text(
                  message['type']!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(message['message']!),
              ),
            );
          },
        ),
      ),
    );
  }
}