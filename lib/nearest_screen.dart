import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NearestScreen extends StatefulWidget {
  const NearestScreen({super.key});

  @override
  State<NearestScreen> createState() => _NearestScreenState();
}

class _NearestScreenState extends State<NearestScreen> {
  // Default center (Kuala Lumpur)
  final LatLng _initialCenter = const LatLng(3.1390, 101.6869);

  // 🔹 Helper: calculate bounds so all markers are visible
  LatLngBounds _boundsFromMarkers(Set<Marker> markers) {
    final positions = markers.map((m) => m.position).toList();

    double south = positions.first.latitude;
    double north = positions.first.latitude;
    double west = positions.first.longitude;
    double east = positions.first.longitude;

    for (final pos in positions) {
      if (pos.latitude < south) south = pos.latitude;
      if (pos.latitude > north) north = pos.latitude;
      if (pos.longitude < west) west = pos.longitude;
      if (pos.longitude > east) east = pos.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nearest Items & Hazards")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, itemSnapshot) {
          if (!itemSnapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return StreamBuilder<QuerySnapshot>(
            stream:
            FirebaseFirestore.instance.collection('hazards').snapshots(),
            builder: (context, hazardSnapshot) {
              if (!hazardSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              Set<Marker> markers = {};

              // 🔴🟢 LOST & FOUND ITEMS
              for (var doc in itemSnapshot.data!.docs) {
                final data = doc.data() as Map<String, dynamic>;

                double? lat;
                double? lng;

                // Support GeoPoint OR lat/lng
                if (data['location'] is GeoPoint) {
                  GeoPoint point = data['location'];
                  lat = point.latitude;
                  lng = point.longitude;
                } else if (data['lat'] != null && data['lng'] != null) {
                  lat = (data['lat'] as num).toDouble();
                  lng = (data['lng'] as num).toDouble();
                }

                // Skip invalid item
                if (lat == null || lng == null) continue;

                markers.add(
                  Marker(
                    markerId: MarkerId("item_${doc.id}"),
                    position: LatLng(lat, lng),
                    infoWindow: InfoWindow(
                      title: data['title'] ?? 'Item',
                      snippet: "Status: ${data['status'] ?? ''}",
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      data['status'] == 'Lost'
                          ? BitmapDescriptor.hueRed
                          : BitmapDescriptor.hueGreen,
                    ),
                  ),
                );
              }

              // ⚠️ HAZARDS
              for (var doc in hazardSnapshot.data!.docs) {
                final data = doc.data() as Map<String, dynamic>;

                double? lat = data['lat'] != null
                    ? (data['lat'] as num).toDouble()
                    : null;
                double? lng = data['lng'] != null
                    ? (data['lng'] as num).toDouble()
                    : null;

                // Skip invalid hazard
                if (lat == null || lng == null) continue;

                markers.add(
                  Marker(
                    markerId: MarkerId("hazard_${doc.id}"),
                    position: LatLng(lat, lng),
                    infoWindow: InfoWindow(
                      title: "⚠️ ${data['type'] ?? 'Hazard'}",
                      snippet: data['description'] ?? '',
                    ),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange,
                    ),
                  ),
                );
              }

              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialCenter,
                  zoom: 12,
                ),
                markers: markers,
                myLocationEnabled: true,
                onMapCreated: (controller) {
                  if (markers.isNotEmpty) {
                    controller.animateCamera(
                      CameraUpdate.newLatLngBounds(
                        _boundsFromMarkers(markers),
                        80,
                      ),
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
