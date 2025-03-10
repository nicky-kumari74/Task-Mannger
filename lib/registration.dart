import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/main.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }

}

class RegistrationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.indigo[900],
      ),
      backgroundColor: Colors.white,

      body: Container(
        child: Center(
          child: Text('New', style: TextStyle(
            fontSize: 24,
          ),

          ),
        ),
      ),
    );
  }

}


