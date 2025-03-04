import 'dart:convert';

import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  String _errorMessage = '';

  List<String> userTypes = ['Student', 'Teacher', 'Cafeteria Manager', 'Club Manager'];
  String _selectedUserType = 'Student';

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      String userTypeEndpoint = _selectedUserType.toLowerCase().replaceAll(' ', '').replaceAll('manager', 'manager');

      final response = await http.post(
        Uri.parse('http://localhost:5000/api/$userTypeEndpoint/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        _navigateToDashboard(responseData);
      } else {
        final errorData = json.decode(response.body);
        setState(() {
          _errorMessage = errorData['message'] ?? 'Login failed';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Network error. Please try again.';
      });
    }
  }

  void _navigateToDashboard(Map<String, dynamic> userData) {
    switch (_selectedUserType) {
      case 'Student':
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => StudentDashboard(userData: userData))
        );
        break;
      // case 'Teacher':
      //   Navigator.pushReplacement(
      //     context, 
      //     MaterialPageRoute(builder: (context) => TeacherDashboard(userData: userData))
      //   );
      //   break;
      // case 'Cafeteria Manager':
      //   Navigator.pushReplacement(
      //     context, 
      //     MaterialPageRoute(builder: (context) => CafeteriaManagerDashboard(userData: userData))
      //   );
      //   break;
      // case 'Club Manager':
      //   Navigator.pushReplacement(
      //     context, 
      //     MaterialPageRoute(builder: (context) => ClubManagerDashboard(userData: userData))
      //   );
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50),
                      Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      padding: EdgeInsets.all(8),

                      child: Image.asset(
                        'images/mistlog.png',
                        height: 110,
                        width: 110,
                        fit: BoxFit.contain,
                      ),

                    ),
                  SizedBox(height: 30),
                  Text(
                    'University Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.AppBaseColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedUserType,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      labelText: 'User Type',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: userTypes.map((String type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedUserType = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock_outline),
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  if (_errorMessage.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement forgot password functionality
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudentDashboard extends StatelessWidget {
  final Map<String, dynamic> userData;
  
  const StudentDashboard({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${userData['user']['name']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Email: ${userData['user']['email']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Courses Enrolled:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...userData['courses'].map<Widget>((course) {
              return ListTile(
                title: Text(course['name']),
                subtitle: Text('Grade: ${course['grade']}'),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}