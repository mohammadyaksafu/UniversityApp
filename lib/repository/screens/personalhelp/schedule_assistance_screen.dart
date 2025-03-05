import 'package:flutter/material.dart';

class ScheduleAssistanceScreen extends StatefulWidget {
  @override
  _ScheduleAssistanceScreenState createState() => _ScheduleAssistanceScreenState();
}

class _ScheduleAssistanceScreenState extends State<ScheduleAssistanceScreen> {
  List<Map<String, dynamic>> _scheduleItems = [];

  void _addScheduleItem() {
    showDialog(
      context: context,
      builder: (context) {
        String title = '';
        String description = '';
        TimeOfDay time = TimeOfDay.now();

        return AlertDialog(
          title: Text('Add Schedule Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {
                  description = value;
                },
              ),
              ListTile(
                title: Text('Time'),
                subtitle: Text('${time.format(context)}'),
                onTap: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: time,
                  );
                  if (picked != null && picked != time) {
                    setState(() {
                      time = picked;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _scheduleItems.add({
                    'title': title,
                    'description': description,
                    'time': time,
                  });
                });
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Assistance'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addScheduleItem,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _scheduleItems.length,
        itemBuilder: (context, index) {
          final item = _scheduleItems[index];
          return ListTile(
            title: Text(item['title']),
            subtitle: Text('${item['description']} at ${item['time'].format(context)}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  _scheduleItems.removeAt(index);
                });
              },
            ),
          );
        },
      ),
    );
  }
}
