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
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),

                child: Padding(
                  padding: EdgeInsets.all(16.0),

                  child: TextField(
                    controller: _controller,

                    decoration: InputDecoration(
                      labelText: 'Enter your question',
                      labelStyle: TextStyle(color: Colors.black),

                      border: InputBorder.none,

                      icon: Icon(
                        Icons.question_answer,
                        color: Appcolors.AppBaseColor,
                      ),
                      hintText: 'Type your question here...',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    maxLines: 3,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),

              SizedBox(height: 20),

              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: _isLoading ? 60 : 150,
                height: 50,

                decoration: BoxDecoration(
                  color: Appcolors.AppBaseColor,
                  borderRadius: BorderRadius.circular(_isLoading ? 20 : 10),
                ),

                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendQuestion,

                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(_isLoading ? 30 : 10),
                    ),
                  ),

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
                          ),
                ),
              ),

              SizedBox(height: 20),

              if (_response.isNotEmpty)
                Expanded(
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

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
