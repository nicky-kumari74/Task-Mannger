import 'package:flutter/material.dart';
class AddTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Task Manager'),
          backgroundColor: Colors.indigoAccent,     // change color for better experience
        ),
    );
  }

}