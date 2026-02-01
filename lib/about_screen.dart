import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> teamMembers = [
      {
        "name": "SYED AKMAL RIZAL BIN SYED SHAHRIZAL ",
        "role": "Project Manager",
        "email": "syed@email.com",
        "image": "assets/images/syed.jpg",
      },
      {
        "name": "MUHAMMAD ADIB ZUHAIR BIN ROSLEE",
        "role": "Lead Developer",
        "email": "adib@email.com",
        "image": "assets/images/adib.jpg",
      },
      {
        "name": "NUR FATNIN INSYIRAH BINTI MOHD NAZRI ",
        "role": "Project Designer",
        "email": "fatnin@email.com",
        "image": "assets/images/fatnin.jpg",
      },
      {
        "name": "MUHAMMAD HARIZ DANIAL BIN AZMAN",
        "role": "UI/UX Designer",
        "email": "hariz@email.com",
        "image": "assets/images/hariz.jpg",
      },
      {
        "name": "WAN FATIN AISYAH BINTI WAN ABD MALIK",
        "role": "Backend Developer",
        "email": "fatin@email.com",
        "image": "assets/images/fatin.jpg",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        backgroundColor: Colors.redAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Team Members",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // TEAM MEMBER CARDS
            ...teamMembers.map(
                  (member) => Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ListTile(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  leading: CircleAvatar(
                    radius: 26,
                    backgroundImage: AssetImage(member['image']!),
                  ),
                  title: Text(
                    member['name']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(member['role']!),
                      const SizedBox(height: 2),
                      Text(
                        member['email']!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Divider(),

            const SizedBox(height: 20),
            const Text(
              "Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "This application helps users report and find lost or found items "
                  "within the community using real-time GPS-based location tracking "
                  "and map visualization.",
              style: TextStyle(color: Colors.black87),
            ),

            const SizedBox(height: 30),
            const Center(
              child: Text(
                "© 2026 Lost & Found. All rights reserved.",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
