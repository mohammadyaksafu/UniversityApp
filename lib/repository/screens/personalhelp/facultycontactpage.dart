import 'package:flutter/material.dart';
import 'package:all_in_all_university_app/domain/constant/appColors.dart';

class FacultyContactScreen extends StatefulWidget {
  const FacultyContactScreen({super.key});

  @override
  _FacultyContactScreenState createState() => _FacultyContactScreenState();
}

class _FacultyContactScreenState extends State<FacultyContactScreen> {
  // Local faculty data with real online image URLs
  final List<Map<String, dynamic>> facultyList = [
    {
      'name': 'Brig Gen Md Mahfuzul Karim Majumder, ndc, psc, te',
      'department': 'Computer Science & Engineering (CSE)',
      'email': 'head@cse.mist.ac.bd',
      'phone': '01734567890',
      'whatsapp': '01734567890',
      'office':
          '3rd Floor, Faculty of Electrical & Computer Engineering (FECE), Tower – 3 ',
      'image':
          'https://plus.unsplash.com/premium_vector-1728560971513-32c0ac5e2c30?q=80&w=3560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Real online image
    },
    {
      'name': 'Dr. Md. Mahbubur Rahman',
      'department':
          'Professor, Department of Computer Science & Engineering (CSE)',
      'email': 'mahbub@cse.mist.ac.bd',
      'phone': '+0987654321',
      'whatsapp': '+0987654321',
      'office':
          '3rd Floor, Faculty of Electrical & Computer Engineering (FECE), Tower – 3 ',
      'image':
          'https://plus.unsplash.com/premium_vector-1728560971513-32c0ac5e2c30?q=80&w=3560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Real online image
    },
    {
      'name': 'Dr. Fernaz Narin Nur',
      'department':
          'Professor, Department of Computer Science & Engineering (CSE)',
      'email': 'fernaz@cse.mist.ac.bd',
      'phone': '+1122334455',
      'whatsapp': '+1122334455',
      'office':
          '3rd Floor, Faculty of Electrical & Computer Engineering (FECE), Tower – 3 ',
      'image':
          'https://plus.unsplash.com/premium_vector-1728560971513-32c0ac5e2c30?q=80&w=3560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Real online image
    },
    {
      'name': 'Md. Abdus Sattar',
      'department':
          'Associate Professor, Department of Computer Science & Engineering (CSE)',
      'email': ' masattar@cse.mist.ac.bd',
      'phone': '+1122334455',
      'whatsapp': '+1122334455',
      'office':
          '3rd Floor, Faculty of Electrical & Computer Engineering (FECE), Tower – 3 ',
      'image':
          'https://plus.unsplash.com/premium_vector-1728560971513-32c0ac5e2c30?q=80&w=3560&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', // Real online image
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Contacts', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        foregroundColor: Colors.white,

        backgroundColor: Appcolors.AppBaseColor,
      ),
      body:
          facultyList.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: facultyList.length,
                itemBuilder: (context, index) {
                  final faculty = facultyList[index];

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue.shade50, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0, // Remove default card shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.zero, // Remove card margin
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Faculty Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                faculty['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 16),
                            // Faculty Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Name
                                  Text(
                                    faculty['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Appcolors.AppBaseColor,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // Department
                                  Text(
                                    faculty['department'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  // Email
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        faculty['email'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  // Phone
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        faculty['phone'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  // WhatsApp
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.chat,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        faculty['whatsapp'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  // Office
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.place,
                                        size: 16,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        faculty['office'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
