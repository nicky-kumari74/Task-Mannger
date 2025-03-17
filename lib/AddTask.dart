import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
class AddTask extends StatelessWidget{

  var assignPersonalTask = TextEditingController();
  var assignTo = TextEditingController();
  var comment = TextEditingController();
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