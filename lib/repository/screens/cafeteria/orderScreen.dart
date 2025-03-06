import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/cafeteria/preoder.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  final PreOrder preOrder;

  const OrderScreen({super.key, required this.preOrder});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text('Your Order'),
        backgroundColor:Appcolors.AppBaseColor,
        centerTitle: true,

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
                            color: Appcolors.AppBaseColor,
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () {
                        
                        preOrder.removeItem(item['name']!);
                    
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.AppBaseColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                
                preOrder.clear();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Order submitted successfully!')),
                );

                Navigator.of(context).pop();
              },

              style: ElevatedButton.styleFrom(
                backgroundColor:Appcolors.AppBaseColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

              ),
              child: Text(
                'Submit Order',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}