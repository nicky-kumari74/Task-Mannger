import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/DashboardScreen.dart';
import 'package:taskmanager/loginScreen.dart';
import 'package:taskmanager/registration.dart';

import 'Colors.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN="login";

  @override
  void initState() {
    super.initState();
    whereToGo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color : bgcolor,  // Change background color for better experience
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/splash icon.png',height:75,width: 400,),
                //Text("Task M",style: TextStyle(color: btncolor,fontSize: 23,fontWeight: FontWeight.w600),),
                //Container(height: 100,),
              ],
            )
        ),
      ),
    );
  }

  void whereToGo() async {
    var sharepref= await SharedPreferences.getInstance();
    var isLoggedIn=sharepref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 3), () {
      if(isLoggedIn!=null) {
        if(isLoggedIn)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard(),));
        else
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      }
      else
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen(),));
    }
    );
  }
}