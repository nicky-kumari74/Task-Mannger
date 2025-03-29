import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add this package in pubspec.yaml

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/loading.json', width: 200, height: 200), // Animation
            SizedBox(height: 20),
            Text(
              "Logging in...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
