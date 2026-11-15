import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data == null
              ? const LoginPage()
              : const ProfilePage();
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final service = AuthService();

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: service.profileStream(user.uid),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("First name: ${data['firstName']}"),
                Text("Last name: ${data['lastName']}"),
                Text("Date of birth: ${data['dob']}"),
                Text("Email: ${data['email']}"),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => service.logout(),
                  child: const Text("Logout"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}