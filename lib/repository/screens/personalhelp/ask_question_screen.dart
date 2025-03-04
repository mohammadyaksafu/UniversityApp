import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AskQuestionScreen extends StatefulWidget {
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
      _response = ''; // Clear previous response
    });

    try {
      // Use the `prompt` method to send the question
      await Gemini.instance.prompt(parts: [
        Part.text(question), // Send the user's question as a text part
      ]).then((value) {
        setState(() {
          _response = value?.output ?? 'No response from Gemini';
        });
      }).catchError((e) {
        setState(() {
          _response = 'Error: $e';
        });
      });
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
        title: Text('Ask a Question'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your question',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, // Allow multiple lines for longer questions
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendQuestion, // Disable button while loading
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white) // Show loading indicator
                  : Text('Ask'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _response,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}