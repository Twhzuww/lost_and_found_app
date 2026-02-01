import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Needed to detect Web
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'admin_dashboard.dart'; // Make sure you import your new web file!

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const LostAndFoundApp());
}

class LostAndFoundApp extends StatelessWidget {
  const LostAndFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. If Firebase is still checking the login status, show a loading spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // 2. If the user is logged in
          if (snapshot.hasData) {
            if (kIsWeb) {
              // If on Chrome/Web, show the Admin Dashboard
              return const AdminWebDashboard();
            } else {
              // If on Android/iOS, show the normal Mobile Home
              return const HomeScreen();
            }
          }

          // 3. If NOT logged in, show the Login Screen
          return const LoginScreen();
        },
      ),
    );
  }
}
