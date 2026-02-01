import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({super.key});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _titleController = TextEditingController();
  final _contactController = TextEditingController();
  String _selectedStatus = 'Lost';
  LatLng _selectedLocation = const LatLng(
    3.1390,
    101.6869,
  ); // Default to Kuala Lumpur

  void _saveItem() async {
    await FirebaseFirestore.instance.collection('items').add({
      'title': _titleController.text,
      'contact': _contactController.text,
      'status': _selectedStatus,
      'lat': _selectedLocation.latitude,
      'lng': _selectedLocation.longitude,
      'createdAt': FieldValue.serverTimestamp(),
    });
    Navigator.pop(context); // Go back after saving
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Report Item")),
      body: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: "Item Name"),
          ),
          TextField(
            controller: _contactController,
            decoration: const InputDecoration(labelText: "Contact Info"),
          ),
          DropdownButton<String>(
            value: _selectedStatus,
            items: [
              'Lost',
              'Found',
            ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
            onChanged: (val) => setState(() => _selectedStatus = val!),
          ),
          // THE MAP BOX
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _selectedLocation,
                zoom: 14,
              ),
              onTap: (pos) => setState(() => _selectedLocation = pos),
              markers: {
                Marker(
                  markerId: const MarkerId("selected"),
                  position: _selectedLocation,
                ),
              },
            ),
          ),
          ElevatedButton(
            onPressed: _saveItem,
            child: const Text("Submit Report"),
          ),
        ],
      ),
    );
  }
}
