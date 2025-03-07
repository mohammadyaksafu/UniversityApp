import 'package:all_in_all_university_app/repository/screens/teacher/teacherhomescreen.dart';
import 'package:flutter/material.dart';
import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/homepage/homepage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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

    // Simulate a network call delay
    await Future.delayed(Duration(seconds: 2));

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    // Find the user in the static list
    final user = staticUsers.firstWhere(
      (user) => user.email == email && user.password == password && user.userType == _selectedUserType,
      orElse: () => StaticUser(email: '', password: '', userType: ''),
    );

    setState(() {
      _isLoading = false;
    });

    if (user.email.isNotEmpty) {
      // Navigate to the appropriate dashboard
      _navigateToDashboard(user);
    } else {
      setState(() {
        _errorMessage = 'Invalid email, password, or user type';
      });
    }
  }

  void _navigateToDashboard(StaticUser user) {
    switch (user.userType) {
      case 'Student':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => UniversityHome(
              userRole: user.userType,
              enrolledCourses: [], // You can add static data here if needed
            ),
          ),
        );
        break;
      // Implement other cases as needed
      case 'Teacher':
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => TeacherDashboardApp(), 
          ),
        );
        // Navigate to Teacher Dashboard
        break;
      case 'Cafeteria Manager':
        // Navigate to Cafeteria Manager Dashboard
        break;
      case 'Club Manager':
        // Navigate to Club Manager Dashboard
        break;
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
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
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.AppBaseColor,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: _selectedUserType,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline,
                      color: Appcolors.AppBaseColor),
                      labelText: 'User Type',
                      labelStyle: TextStyle(
                        color: Appcolors.AppBaseColor
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:Appcolors.AppBaseColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Appcolors.AppBaseColor),
                      ),
                    ),
                    items: userTypes.map((String type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type, 
                        style: TextStyle(
                        color: Appcolors.AppBaseColor)),
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
                      prefixIcon: Icon(
                      Icons.email_outlined, 
                      color: Appcolors.AppBaseColor),
                      labelText: 'Email',
                      labelStyle: TextStyle(
                      color: Appcolors.AppBaseColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                        color:Appcolors.AppBaseColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                        color: Appcolors.AppBaseColor
                        ),
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
                      prefixIcon: Icon(Icons.lock_outline, 
                      color:Appcolors.AppBaseColor),
                      labelText: 'Password',
                      labelStyle: TextStyle(
                        color: Appcolors.AppBaseColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:Appcolors.AppBaseColor
                          ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: 
                        Appcolors.AppBaseColor),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Appcolors.AppBaseColor,
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
                      backgroundColor:Appcolors.AppBaseColor,
                      elevation: 5,
                      shadowColor: Appcolors.AppBaseColor.withOpacity(0.3),
                    ),
                    child: _isLoading
                        ? CircularProgressIndicator(
                          color: Colors.white)
                        : Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Implement forgot password functionality
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Appcolors.AppBaseColor, fontFamily: 'Poppins'),
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

class StaticUser {
  final String email;
  final String password;
  final String userType;

  StaticUser({
    required this.email,
    required this.password,
    required this.userType,
  });
}

final List<StaticUser> staticUsers = [
  StaticUser(email: 'student@gmail.com', password: 'student123', userType: 'Student'),
  StaticUser(email: 'teacher@gmail.com', password: 'teacher123', userType: 'Teacher'),
  StaticUser(email: 'cafeteria@gmail.com', password: 'cafeteria123', userType: 'Cafeteria Manager'),
  StaticUser(email: 'club@gmail.com', password: 'club123', userType: 'Club Manager'),
];