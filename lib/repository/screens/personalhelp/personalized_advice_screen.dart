import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class PersonalizedAdviceScreen extends StatefulWidget {
  const PersonalizedAdviceScreen({super.key});

  @override
  _PersonalizedAdviceScreenState createState() =>
      _PersonalizedAdviceScreenState();
}

class _PersonalizedAdviceScreenState extends State<PersonalizedAdviceScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _advice = '';
  bool _isLoading = false;

  Future<void> _getAdvice() async {
    final input = _inputController.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _isLoading = true;
      _advice = ''; // Clear previous advice
    });

    try {
      // Custom prompt template for personalized advice
      final customPrompt = '''
You are a helpful and friendly assistant. Provide personalized advice based on the following input:
- User Input: "$input"

Guidelines for your response:
1. Be concise and clear.
2. Provide actionable steps or suggestions.
3. Use a friendly and supportive tone.
4. If the input is unclear, ask for clarification.
5. Tailor the advice to the user's specific needs.

Now, provide your advice:
''';

      // Use Gemini to generate personalized advice
<<<<<<< HEAD
      await Gemini.instance
          .prompt(
            parts: [
              Part.text(input), // Send the user's input as a text part
            ],
          )
          .then((value) {
            setState(() {
              _advice = value?.output ?? 'No advice available.';
            });
          })
          .catchError((e) {
            setState(() {
              _advice = 'Error: $e';
            });
          });
=======
      await Gemini.instance.prompt(parts: [
        Part.text(customPrompt), // Send the custom prompt
      ]).then((value) {
        setState(() {
          _advice = value?.output ?? 'No advice available.';
        });
      }).catchError((e) {
        setState(() {
          _advice = 'Error: $e';
        });
      });
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
    } catch (e) {
      setState(() {
        _advice = 'Error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personalized Advice'),
        foregroundColor: Colors.white,

        backgroundColor: Appcolors.AppBaseColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
<<<<<<< HEAD

              decoration: InputDecoration(
                labelText: 'Enter your query or preference',
                labelStyle: TextStyle(color: Appcolors.AppBaseColor),

                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.AppBaseColor),
                ),

                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Appcolors.AppBaseColor),
                ),
              ),

              maxLines: 3,
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: _isLoading ? null : _getAdvice,

=======
              decoration: InputDecoration(
                labelText: 'Enter your query or preference',
                labelStyle: TextStyle(
                  color: Appcolors.AppBaseColor,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Appcolors.AppBaseColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Appcolors.AppBaseColor,
                  ),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _getAdvice,
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.AppBaseColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
<<<<<<< HEAD

              child:
                  _isLoading
                      ? CircularProgressIndicator(color: Appcolors.AppBaseColor)
                      : Text(
                        'Get Advice',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
            ),

            SizedBox(height: 16),

=======
              child: _isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Get Advice',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
            ),
            SizedBox(height: 16),
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
            if (_advice.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _advice,
<<<<<<< HEAD
                  style: TextStyle(color: Appcolors.AppBaseColor, fontSize: 16),
=======
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
                ),
              ),
          ],
        ),
      ),
    );
  }
}
