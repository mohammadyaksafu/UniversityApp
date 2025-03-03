import 'package:all_in_all_university_app/repository/screens/cafeteria/preoder.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final PreOrder preOrder;

  OrderScreen({required this.preOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Order'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: preOrder.items.length,
              itemBuilder: (context, index) {
                final item = preOrder.items[index];
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
                          '\$${parsePrice(item['price']!).toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        // Remove item from the pre-order list
                        preOrder.removeItem(item['name']!);
                        // Refresh the screen
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => OrderScreen(preOrder: preOrder),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${preOrder.getTotalPrice().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle order submission (e.g., send to backend)
                preOrder.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order submitted successfully!')),
                );
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                'Submit Order',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}