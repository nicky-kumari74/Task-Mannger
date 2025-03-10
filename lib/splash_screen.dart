import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/loginScreen.dart';
import 'package:taskmanager/registration.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 4), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color : Colors.indigo[900],  // Change background color for better experience
        child: Center(
            child: Container(
              width: 288,
              margin: EdgeInsets.only(left: 9),
              child: Text('Task Manager:Smart Planning for Busy Lives',
                style: TextStyle(
                    fontSize: 23,       //Optional, change text size for better visibility
                    fontWeight: FontWeight.w600, // Optional, change weight for better visibility
                    color: Colors.white   // Change text color for better experiences
                ),
              ),
            )
        ),
      ),
    );
  }
}