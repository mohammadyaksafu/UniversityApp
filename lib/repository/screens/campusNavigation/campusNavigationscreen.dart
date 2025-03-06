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
  final LatLng _mapCenter = LatLng(37.7749, -122.4194); // San Francisco coordinates
  final double _initialZoom = 15;

  final List<Map<String, dynamic>> locations = [
    {
      'name': 'Main Library',
      'description': 'Open 8 AM - 10 PM',
      'position': LatLng(37.7749, -122.4194),
    },
    {
      'name': 'Engineering Building',
      'description': 'Houses CS, EE, and ME departments',
      'position': LatLng(37.7755, -122.4185),
    },
    {
      'name': 'Faculty Offices',
      'description': 'Meet your professors here',
      'position': LatLng(37.7760, -122.4175),
    },
    {
      'name': 'Student Center',
      'description': 'Cafeteria, lounge, and club rooms',
      'position': LatLng(37.7765, -122.4165),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Navigation & AR Map'),
        backgroundColor: Colors.teal,
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
                      width: 80, // Increased width to accommodate text
                      height: 80, // Increased height to accommodate text
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
                    builder: (context) => ARNavigationScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 18),
                backgroundColor: Colors.teal,
              ),
              child: const Text('Use AR Navigation'),
            ),
          ),
        ],
      ),
    );
  }
}

// New Screen for AR Navigation
class ARNavigationScreen extends StatelessWidget {
  const ARNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Navigation'),
        backgroundColor: Colors.teal,
      ),
      body: const Center(
        child: Text(
          'AR Navigation Feature Coming Soon!',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}