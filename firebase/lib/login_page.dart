import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'reset_password.dart';
import 'auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginEmail = TextEditingController();
  final loginPwd = TextEditingController();
  final service = AuthService();

  void login() async {
    if (!service.isValidEmail(loginEmail.text.trim())) {
      showMsg("Email invalide");
      return;
    }

    if (loginPwd.text.isEmpty) {
      showMsg("Insert Password");
      return;
    }

    try {
      await service.login(loginEmail.text.trim(), loginPwd.text);
    } on FirebaseAuthException catch (e) {
      showMsg(e.message ?? "Login failed");
    }
  }

  void showMsg(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: loginEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: loginPwd,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: login,
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
                );
              },
              child: const Text("Forgot password ?"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't you have an account ?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SignupPage()),
                    );
                  },
                  child: const Text("Signup"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}