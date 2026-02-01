import 'package:cloud_firestore/cloud_firestore.dart';

class ItemService {
  Future<void> addItem(
      String title,
      String status,
      double lat,
      double lng,
      String contact,
      ) async {
    await FirebaseFirestore.instance.collection('items').add({
      'title': title,
      'status': status,
      'lat': lat,
      'lng': lng,
      'contact': contact,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
