import 'package:flutter/material.dart';
import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/cafeteria/orderScreen.dart';
import 'package:all_in_all_university_app/repository/screens/cafeteria/preoder.dart';

class CafeteriaMenuScreen extends StatefulWidget {
  const CafeteriaMenuScreen({super.key});

  @override
  _CafeteriaMenuScreenState createState() => _CafeteriaMenuScreenState();
}

class _CafeteriaMenuScreenState extends State<CafeteriaMenuScreen> {
  // Static data for the cafeteria menu
  final List<Map<String, String>> menuItems = [
    {
      'name': 'Cheeseburger',
      'description': 'Juicy beef patty with melted cheese, lettuce, and tomato.',
      'price': '8.99',
      'image': 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hlZXNlYnVyZ2VyfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    },
    {
      'name': 'Margherita Pizza',
      'description': 'Classic pizza with fresh mozzarella, tomatoes, and basil.',
      'price': '12.99',
      'image': 'https://images.unsplash.com/photo-1595854341625-f33ee10dbf94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bWFyZ2hlcml0YSUyMHBpenphfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    },
    {
      'name': 'Caesar Salad',
      'description': 'Crisp romaine lettuce with croutons, parmesan, and Caesar dressing.',
      'price': '6.99',
      'image': 'https://images.unsplash.com/photo-1607532941433-304659e8198a?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2Flc2FyJTIwc2FsYWR8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
    },
    {
      'name': 'Spaghetti Bolognese',
      'description': 'Spaghetti pasta with rich meat sauce and parmesan cheese.',
      'price': '10.99',
      'image': 'https://images.unsplash.com/photo-1622973536968-3ead9e780960?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c3BhZ2hldHRpJTIwYm9sb2duZXNlfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    },
    {
      'name': 'Chicken Tacos',
      'description': 'Soft tortillas filled with grilled chicken, salsa, and guacamole.',
      'price': '9.99',
      'image': 'https://images.unsplash.com/photo-1565299585323-38d6b0865b47?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hpY2tlbiUyMHRhY29zfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60',
    },
  ];

  PreOrder preOrder = PreOrder(); // PreOrder object to manage selected items

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cafeteria Menu',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Appcolors.AppBaseColor,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderScreen(preOrder: preOrder),
                ),
              );
            },
          ),
        ],
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
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item['image']!,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
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