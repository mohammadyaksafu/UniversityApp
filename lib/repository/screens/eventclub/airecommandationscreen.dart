import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AIRecommendationPage extends StatefulWidget {
  @override
  _AIRecommendationPageState createState() => _AIRecommendationPageState();
}

class _AIRecommendationPageState extends State<AIRecommendationPage> {
  List<String> recommendations = [];
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchRecommendations() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      recommendations.clear();
    });

    try {
      // Create a prompt for event recommendations
      final prompt = 'Generate 5 unique event recommendations.'
                     'from fetching data this bangladeshi university';

      // Use Gemini to generate recommendations
      await Gemini.instance.prompt(
        parts: [Part.text(prompt)],
      ).then((value) {
        // Process the response
        final responseText = value?.output ?? '';
        
        // Split the response into individual recommendations
        final List<String> fetchedRecommendations = responseText
            .split('\n')
            .where((recommendation) => 
              recommendation.trim().isNotEmpty && 
              !recommendation.toLowerCase().contains('here are'))
            .toList();

        setState(() {
          recommendations = fetchedRecommendations;
        });
      }).catchError((e) {
        setState(() {
          errorMessage = 'Error fetching recommendations: $e';
        });
      });
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
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Get AI Event Recommendations'),
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (errorMessage.isNotEmpty)
              Center(child: Text(
                errorMessage, 
                style: TextStyle(color: Colors.red)
              ))
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