import 'dart:convert';

import 'package:all_in_all_university_app/repository/screens/cafeteria/orderScreen.dart';
import 'package:all_in_all_university_app/repository/screens/cafeteria/preoder.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CafeteriaMenuScreen extends StatefulWidget {
  @override
  _CafeteriaMenuScreenState createState() => _CafeteriaMenuScreenState();
}

class _CafeteriaMenuScreenState extends State<CafeteriaMenuScreen> {
  List<Map<String, String>> menuItems = [];
  bool isLoading = true;
  String errorMessage = '';
  PreOrder preOrder = PreOrder(); // Instance of PreOrder class

  @override
  void initState() {
    super.initState();
    fetchMenu();
  }

  // Fetch menu items from the API
  Future<void> fetchMenu() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:5000/menu'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          menuItems = data.map((item) {
            return {
              'name': item['name'] as String,
              'description': item['description'] as String,
              'price': item['price'] as String,
              'image': item['image'] as String,
            };
          }).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load menu. Please try again later.';
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafeteria Menu'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the OrderScreen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(preOrder: preOrder),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            ) // Show loading spinner
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage, style: TextStyle(color: Colors.red)),
                )
              : ListView.builder(
                  itemCount: menuItems.length,
                  itemBuilder: (context, index) {
                    final item = menuItems[index];
                    return Card(
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Image.network(
                          item['image']!,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          item['name']!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['description']!),
                            SizedBox(height: 5),
                            Text(
                              '\$${item['price']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            setState(() {
                              preOrder.addItem(item);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item['name']} added to order!'),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}