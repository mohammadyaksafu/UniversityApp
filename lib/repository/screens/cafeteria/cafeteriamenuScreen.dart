import 'package:flutter/material.dart';

class CafeteriaMenuScreen extends StatelessWidget {
  final List<Map<String, String>> menuItems = [
    {
      'name': 'Pasta Carbonara',
      'description': 'Creamy pasta with bacon and parmesan cheese.',
      'price': '\$8.99',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Grilled Chicken Salad',
      'description': 'Fresh greens with grilled chicken and vinaigrette.',
      'price': '\$7.49',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Vegetable Soup',
      'description': 'Healthy soup with fresh vegetables and herbs.',
      'price': '\$5.99',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cafeteria Menu'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
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
              leading: Image.network(item['image']!, width: 60, height: 60, fit: BoxFit.cover),
              title: Text(
                item['name']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['description']!),
                  SizedBox(height: 5),
                  Text(item['price']!, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}