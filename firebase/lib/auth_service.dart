import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  // Email validation
  bool isValidEmail(String email) {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(email);
  }

  // Check age is at least 13 (exact: takes month and day into account)
  bool isAtLeast13(DateTime dob) {
    final now = DateTime.now();
    var age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age >= 13;
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required DateTime dob,
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await _db.collection("users").doc(cred.user!.uid).set({
      "firstName": firstName,
      "lastName": lastName,
      "dob": dob.toString().split(" ")[0],
      "email": email,
    });
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<Map<String, dynamic>> getProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data() ?? {};
  }

  // Live version of the profile (used by the profile page)
  Stream<Map<String, dynamic>?> profileStream(String uid) {
    return _db.collection("users").doc(uid).snapshots().map((d) => d.data());
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  // Exercise 2
  Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}