import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AIRecommendationPage extends StatefulWidget {
  @override
  _AIRecommendationPageState createState() => _AIRecommendationPageState();
}

class _AIRecommendationPageState extends State<AIRecommendationPage> {
  final String apiUrl = 'http://127.0.0.1:5000/recommend/12345'; // Update with Flask API URL
  List<String> recommendations = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchRecommendations() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          recommendations = List<String>.from(data['recommendations']);
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load recommendations: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Event Recommendations'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: fetchRecommendations,
              child: Text('Get AI Event Recommendations'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (errorMessage.isNotEmpty)
              Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
            else if (recommendations.isEmpty)
              Center(child: Text('No recommendations available'))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: recommendations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: Icon(Icons.event, color: Colors.blue),
                        title: Text(recommendations[index]),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
