import 'package:all_in_all_university_app/domain/constant/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ARNavigationScreen extends StatelessWidget {
  final LatLng startLocation;
  final LatLng endLocation;

  const ARNavigationScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AR Navigation',  
        style: TextStyle(
          color: Colors.white,
        ),),
        centerTitle: true,
        backgroundColor: Appcolors.AppBaseColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                initialCenter: startLocation,
                initialZoom: 15.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: startLocation,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
                    Marker(
                      point: endLocation,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.flag,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'From: (${startLocation.latitude}, ${startLocation.longitude})',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'To: (${endLocation.latitude}, ${endLocation.longitude})',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PathScreen(
                              startLocation: startLocation,
                              endLocation: endLocation,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolors.AppBaseColor, // Add background color
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      child: Text(
                        'Follow the path in AR!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PathScreen extends StatelessWidget {
  final LatLng startLocation;
  final LatLng endLocation;

  const PathScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path View'),
        backgroundColor: Appcolors.AppBaseColor,
        centerTitle: true,
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: startLocation,
          initialZoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: startLocation,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.amber,
                  size: 40,
                ),
              ),
              Marker(
                point: endLocation,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.flag,
                  color: Colors.green,
                  size: 40,
                ),
              ),
            ],
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: [startLocation, endLocation],
                strokeWidth: 6.0,
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
