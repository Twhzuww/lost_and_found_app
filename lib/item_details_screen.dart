import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDetailsScreen extends StatelessWidget {
  final DocumentSnapshot item;
  const ItemDetailsScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Get location from the database document
    LatLng location = LatLng(item['lat'], item['lng']);

    return Scaffold(
      appBar: AppBar(title: Text(item['title'])),
      body: Column(
        children: [
          ListTile(
            title: const Text(
              "Status",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item['status']),
            trailing: Icon(
              item['status'] == 'Lost' ? Icons.warning : Icons.check_circle,
              color: item['status'] == 'Lost' ? Colors.red : Colors.green,
            ),
          ),
          ListTile(
            title: const Text(
              "Contact Info",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(item['contact']),
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Last Seen Location:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          // SHOW THE MAP
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: location, zoom: 15),
              markers: {
                Marker(markerId: const MarkerId("itemLoc"), position: location),
              },
            ),
          ),
        ],
      ),
    );
  }
}
