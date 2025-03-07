import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:all_in_all_university_app/repository/screens/campusNavigation/Arnavigationscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class CampusNavigationScreen extends StatefulWidget {
  const CampusNavigationScreen({super.key});

  @override
  _CampusNavigationScreenState createState() => _CampusNavigationScreenState();
}

class _CampusNavigationScreenState extends State<CampusNavigationScreen> {
  final LatLng _mapCenter = LatLng(23.707306, 90.415482);
  final double _initialZoom = 15;

  final List<Map<String, dynamic>> locations = [
    {
      'name': 'Main Library',
      'description': 'Open 8 AM - 10 PM',
      'position': LatLng(23.707408, 90.415483),
    },
    {
      'name': 'Engineering Building',
      'description': 'Houses CS, EE, and ME departments',
      'position': LatLng(23.707306, 90.415485),
    },
    {
      'name': 'Faculty Offices',
      'description': 'Meet your professors here',
      'position': LatLng(23.707210, 90.415473),
    },
    {
      'name': 'Student Center',
      'description': 'Cafeteria, lounge, and club rooms',
      'position': LatLng(23.707108, 90.415283),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Navigation & AR Map'
        ,style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Appcolors.AppBaseColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: _mapCenter,
                initialZoom: _initialZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: locations.map((location) {
                    return Marker(
                      point: location['position'],
                      width: 80,
                      height: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40,
                          ),
                          Text(
                            location['name'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution(
                      'OpenStreetMap contributors',
                      onTap: () async {
                        final Uri url =
                            Uri.parse('https://www.openstreetmap.org/copyright');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to AR Navigation Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ARNavigationScreen(
                      startLocation: locations[0]['position'], 
                      endLocation: LatLng(23.707108, 90.415283), 
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(
                  fontSize: 18
                  
                  ),
                backgroundColor:  Appcolors.AppBaseColor,
              ),
              child: const Text('Use AR Navigation',
              style: TextStyle(
                color: Colors.white,
                
              ),
              textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


