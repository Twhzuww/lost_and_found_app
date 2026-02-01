import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminWebDashboard extends StatelessWidget {
  const AdminWebDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lost & Found - Admin Control Panel"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: () {}),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              width: double.infinity,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text('Item Name')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Contact')),
                  DataColumn(label: Text('Manage')),
                ],
                rows: snapshot.data!.docs.map((doc) {
                  return DataRow(
                    cells: [
                      DataCell(Text(doc['title'])),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: doc['status'] == 'Lost'
                                ? Colors.red[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(doc['status']),
                        ),
                      ),
                      DataCell(Text(doc['contact'])),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteItem(doc.id),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                              ),
                              onPressed: () => _markAsFound(doc.id),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  void _deleteItem(String id) {
    FirebaseFirestore.instance.collection('items').doc(id).delete();
  }

  void _markAsFound(String id) {
    FirebaseFirestore.instance.collection('items').doc(id).update({
      'status': 'Found',
    });
  }
}
