import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final email = TextEditingController();
  final service = AuthService();

  void reset() async {
    if (!service.isValidEmail(email.text.trim())) {
      showMsg("Invalid email");
      return;
    }

    try {
      await service.resetPassword(email.text.trim());
      showMsg("Reset link sent. Check your inbox (and spam).");
    } on FirebaseAuthException catch (e) {
      showMsg(e.message ?? "Could not send reset email");
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: email,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: reset,
              child: const Text("Send reset link"),
            ),
          ],
        ),
      ),
    );
  }
}