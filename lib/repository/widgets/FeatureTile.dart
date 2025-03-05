import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';

class FeatureTile {
  static buildFeatureTile(BuildContext context, IconData icon, String title, Widget page) {
    
    return GestureDetector(
     
      onTap: () {

        Navigator.push(
          context,

          MaterialPageRoute(builder: (context) => page),
        );
      },

      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(10)),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Icon(icon, size: 50,
            color: Appcolors.AppBaseColor
            ),

            SizedBox(height: 10),

            Text(
            title,
            textAlign: TextAlign.center, 
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold,
              
              )),
          ],
        ),
      ),
    );
  }
}