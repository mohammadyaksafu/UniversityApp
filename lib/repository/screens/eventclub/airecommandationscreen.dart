import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AIRecommendationPage extends StatefulWidget {
  const AIRecommendationPage({super.key});

  @override
  _AIRecommendationPageState createState() => _AIRecommendationPageState();
}

class _AIRecommendationPageState extends State<AIRecommendationPage> {
  final TextEditingController _interestController = TextEditingController();
  List<String> recommendations = [];
  bool isLoading = false;
  String errorMessage = '';

  // Static club information
  final List<Map<String, dynamic>> clubs = [
    {
      'name': 'Photography Club',
      'description': 'Capture the world through your lens.',
    },
    {
      'name': 'Drama Club',
      'description': 'Express yourself on stage.',
    },
    {
      'name': 'Robotics Club',
      'description': 'Build, code, and innovate.',
    },
    {
      'name': 'Music Club',
      'description': 'Explore your musical talents.',
    },
    {
      'name': 'Debate Club',
      'description': 'Sharpen your public speaking skills.',
    },
  ];

  Future<void> fetchRecommendations() async {
    final userInterest = _interestController.text.trim();
    if (userInterest.isEmpty) {
      setState(() {
        errorMessage = 'Please enter your interests.';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
      recommendations.clear();
    });

    try {
      // Create a prompt for event recommendations based on user interest and static club data
      final prompt = '''
        Based on the user's interest: "$userInterest", recommend suitable clubs from the following list:
        ${clubs.map((club) => "- ${club['name']}: ${club['description']}").join('\n')}
        
        Provide a brief explanation for each recommendation.
      ''';

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
            TextField(
              controller: _interestController,
              decoration: InputDecoration(
                labelText: 'Enter your interests',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: fetchRecommendations,
                ),
              ),
              onSubmitted: (value) => fetchRecommendations(),
            ),
            SizedBox(height: 20),
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (errorMessage.isNotEmpty)
              Center(
                child: Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                ),
              )
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