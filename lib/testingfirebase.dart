/*
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseTestScreen(),
    );
  }
}

class FirebaseTestScreen extends StatelessWidget {
  void testFirebase() async {
    try {
      print("Testing Firebase Authentication...");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "testuser@gmail.com",
        password: "Test@1234",
      );
      print("✅ Firebase Connection Successful! Registered: ${userCredential.user?.email}");
    } catch (e) {
      print("❌ Firebase Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Test")),
      body: Center(
        child: ElevatedButton(
          onPressed: testFirebase,
          child: Text("Test Firebase Connection"),
        ),
      ),
    );
  }
}
*/
