import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/personalhelp/facultycontactpage.dart';
import 'package:all_in_all_university_app/repository/screens/personalhelp/personalized_advice_screen.dart';
import 'package:all_in_all_university_app/repository/screens/personalhelp/schedule_assistance_screen.dart';
import 'package:flutter/material.dart';
import 'ask_question_screen.dart'; // Import the new screen

class PersonalHelpAI extends StatelessWidget {
  const PersonalHelpAI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Help AI',
          style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                ),
                textAlign: TextAlign.center,
        ),
        backgroundColor: Appcolors.AppBaseColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
                  'How can I assist you today?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            SizedBox(height: 20),
            
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.2,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  IconData icon;
                  Color color;
                  String title;
                  String subtitle;

                  switch (index) {
                    case 0:
                      icon = Icons.question_answer;
                      color = Colors.blue;
                      title = 'Ask a Question';
                      subtitle = 'Get answers to your queries instantly';
                      break;
                    case 1:
                      icon = Icons.schedule;
                      color = Colors.green;
                      title = 'Schedule Assistance';
                      subtitle = 'Manage your daily schedule efficiently';
                      break;
                    case 2:
                      icon = Icons.person;
                      color = Colors.orange;
                      title = 'Personalized Advice';
                      subtitle = 'Get AI-driven personal recommendations';
                      break;
                    case 3:
                      icon = Icons.contact_mail;
                      color = Colors.red;
                      title = 'Faculty Contact';
                      subtitle = 'Find and contact faculty members';
                      break;
                    default:
                      icon = Icons.help;
                      color = Colors.grey;
                      title = '';
                      subtitle = '';
                  }

                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AskQuestionScreen(),
                          ),
                        );
                      }else if (index == 1) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ScheduleAssistanceScreen(),
                          ),
                        );
                      }
                      else if (index == 2) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PersonalizedAdviceScreen(),
                          ),
                        );
                      }

                       else if (index == 3) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FacultyContactScreen(),
                          ),
                        );
                      } 
                    },
                    
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      
                      
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon, color: color, size: 40),
                          
                          SizedBox(height: 10),
                          
                          
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
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
