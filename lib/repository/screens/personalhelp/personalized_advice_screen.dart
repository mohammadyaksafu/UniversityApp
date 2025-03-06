import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class PersonalizedAdviceScreen extends StatefulWidget {
  const PersonalizedAdviceScreen({super.key});

  @override
  _PersonalizedAdviceScreenState createState() => _PersonalizedAdviceScreenState();
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
      // Use Gemini to generate personalized advice
      await Gemini.instance.prompt(parts: [
        Part.text(input), // Send the user's input as a text part
      ]).then((value) {
        setState(() {
          _advice = value?.output ?? 'No advice available.';
        });
      }).catchError((e) {
        setState(() {
          _advice = 'Error: $e';
        });
      });
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
        backgroundColor: Appcolors.AppBaseColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        // Wrap the Column in a SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              
              controller: _inputController,
              
              decoration: InputDecoration(
                labelText: 'Enter your query or preference',
                labelStyle: TextStyle(
                  color: Appcolors.AppBaseColor
                  ),
               
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Appcolors.AppBaseColor
                    ),
                ),
               
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Appcolors.AppBaseColor
                    ),
                ),
              ),
              
              maxLines: 3,
            ),
          
            SizedBox(height: 16),
            
            ElevatedButton(
              onPressed: _isLoading ? null : _getAdvice,
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolors.AppBaseColor,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              child: _isLoading
                  ? CircularProgressIndicator(
                    color: Appcolors.AppBaseColor
                    )
                  : Text(
                      'Get Advice',
                      style: TextStyle(fontSize: 16,
                       color: Colors.black
                       ),
                    ),
            ),
            
            SizedBox(height: 16),
            
            if (_advice.isNotEmpty)
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Appcolors.AppBaseColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _advice,
                  style: TextStyle(
                    color: Appcolors.AppBaseColor,
                    fontSize: 16,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}