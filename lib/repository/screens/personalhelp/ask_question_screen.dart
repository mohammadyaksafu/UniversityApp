import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AskQuestionScreen extends StatefulWidget {
  const AskQuestionScreen({super.key});

  @override
  _AskQuestionScreenState createState() => _AskQuestionScreenState();
}

class _AskQuestionScreenState extends State<AskQuestionScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  bool _isLoading = false;

  Future<void> _sendQuestion() async {
    final question = _controller.text.trim();
    if (question.isEmpty) return;

    setState(() {
      _isLoading = true;
<<<<<<< HEAD
      _response = '';
    });

    try {
      await Gemini.instance
          .prompt(parts: [Part.text(question)])
          .then((value) {
            setState(() {
              _response = value?.output ?? 'No response from Gemini';
            });
          })
          .catchError((e) {
            setState(() {
              _response = 'Error: $e';
            });
          });
=======
      _response = ''; // Clear previous response
    });

    try {
      // Custom prompt to restrict responses to university-related topics
      final customPrompt = '''
You are a helpful assistant for university-related queries. 
If the question is related to university topics (e.g., academics, courses, exams, campus life, etc.), provide a detailed and accurate answer.
If the question is unrelated to university topics, respond with: "Sorry, I am unable to assist with that."

Question: "$question"

Answer:
''';

      // Use Gemini to generate a response
      await Gemini.instance.prompt(parts: [
        Part.text(customPrompt), // Send the custom prompt
      ]).then((value) {
        setState(() {
          _response = value?.output ?? 'No response from Gemini';
        });
      }).catchError((e) {
        setState(() {
          _response = 'Error: $e';
        });
      });
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
    } catch (e) {
      setState(() {
        _response = 'Error: $e';
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
        title: Text(
          'Ask a Question',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,

        backgroundColor: Appcolors.AppBaseColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: Appcolors.AppBaseColor),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Input Card
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
<<<<<<< HEAD

                child: Padding(
                  padding: EdgeInsets.all(16.0),

                  child: TextField(
                    controller: _controller,

                    decoration: InputDecoration(
                      labelText: 'Enter your question',
                      labelStyle: TextStyle(color: Colors.black),

                      border: InputBorder.none,

=======
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter your question',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
                      icon: Icon(
                        Icons.question_answer,
                        color: Appcolors.AppBaseColor,
                      ),
                      hintText: 'Type your question here...',
<<<<<<< HEAD
                      hintStyle: TextStyle(color: Colors.grey),
=======
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
                    ),
                    maxLines: 3,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
<<<<<<< HEAD

              SizedBox(height: 20),

=======
              SizedBox(height: 20),
              // Ask Button
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _isLoading ? 60 : 150,
                height: 50,
<<<<<<< HEAD

                decoration: BoxDecoration(
                  color: Appcolors.AppBaseColor,
                  borderRadius: BorderRadius.circular(_isLoading ? 20 : 10),
                ),

                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendQuestion,

=======
                decoration: BoxDecoration(
                  color: Appcolors.AppBaseColor,
                  borderRadius: BorderRadius.circular(
                    _isLoading ? 20 : 10),
                ),
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendQuestion,
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_isLoading ? 30 : 10),
                    ),
                  ),
<<<<<<< HEAD

                  child:
                      _isLoading
                          ? CircularProgressIndicator(
                            color: Appcolors.AppBaseColor,
                          )
                          : Text(
                            'Ask',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
=======
                  child: _isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          'Ask',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
                          ),
                ),
              ),
<<<<<<< HEAD

              SizedBox(height: 20),

=======
              SizedBox(height: 20),
              // Response Card
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
              if (_response.isNotEmpty)
                Expanded(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
<<<<<<< HEAD

=======
>>>>>>> 16e7463995442355ccf2de6481b659adcf2baaa8
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SingleChildScrollView(
                        child: Text(
                          _response,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueGrey[800],
                          ),
                        ),
                      ),
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
