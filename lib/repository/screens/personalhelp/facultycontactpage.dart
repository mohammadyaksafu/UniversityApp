import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FacultyContactScreen extends StatefulWidget {
  const FacultyContactScreen({super.key});

  @override
  _FacultyContactScreenState createState() => _FacultyContactScreenState();
}

class _FacultyContactScreenState extends State<FacultyContactScreen> {
  List<Map<String, dynamic>> facultyList = [];

  @override
  void initState() {
    super.initState();
    fetchFacultyContacts();
  }

  Future<void> fetchFacultyContacts() async {
    final response = await http.get(Uri.parse('http://localhost:5000/facultycontact'));
    if (response.statusCode == 200) {
      setState(() {
        facultyList = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Contacts'
        ,style:TextStyle(
          color: Colors.white,
        ),),
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