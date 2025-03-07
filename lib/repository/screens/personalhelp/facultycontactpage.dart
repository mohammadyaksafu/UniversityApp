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
      'name': 'Dr. John Doe',
      'department': 'Computer Science',
      'email': 'john.doe@university.edu',
      'phone': '+1234567890',
      'whatsapp': '+1234567890',
      'office': 'Building A, Room 101',
      'image':
          'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', // Real online image
    },
    {
      'name': 'Dr. Jane Smith',
      'department': 'Mathematics',
      'email': 'jane.smith@university.edu',
      'phone': '+0987654321',
      'whatsapp': '+0987654321',
      'office': 'Building B, Room 202',
      'image':
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', // Real online image
    },
    {
      'name': 'Dr. Emily Johnson',
      'department': 'Physics',
      'email': 'emily.johnson@university.edu',
      'phone': '+1122334455',
      'whatsapp': '+1122334455',
      'office': 'Building C, Room 303',
      'image':
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', // Real online image
    },
    {
      'name': 'Dr. Emily Johnson',
      'department': 'Physics',
      'email': 'emily.johnson@university.edu',
      'phone': '+1122334455',
      'whatsapp': '+1122334455',
      'office': 'Building C, Room 303',
      'image':
          'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80', // Real online image
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
        title: Text(
          'Faculty Contacts',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Appcolors.AppBaseColor,
      ),
      body: facultyList.isEmpty
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
                                    Icon(Icons.email, size: 16, color: Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      faculty['email'],
                                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                // Phone
                                Row(
                                  children: [
                                    Icon(Icons.phone, size: 16, color: Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      faculty['phone'],
                                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                // WhatsApp
                                Row(
                                  children: [
                                    Icon(Icons.chat, size: 16, color: Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      faculty['whatsapp'],
                                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8),
                                // Office
                                Row(
                                  children: [
                                    Icon(Icons.place, size: 16, color: Colors.grey),
                                    SizedBox(width: 8),
                                    Text(
                                      faculty['office'],
                                      style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
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