import 'package:flutter/material.dart';
import 'package:taskmanager/AddTeamTask.dart';
import 'package:taskmanager/Colors.dart';

class TeamTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: Text('Team task',style: TextStyle(color: Colors.white),)
              ),
              Container(
                margin: EdgeInsets.only(top: 480, ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AddTeamTask()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    elevation: 10, shadowColor: Colors.blueGrey,
                    padding: EdgeInsets.all(10),
                    backgroundColor: btncolor,
                  ),
                  child: Icon(Icons.add, color: Colors.white,size: 30,),
                ),
              ),

            ],
          ),
        ),
    );
  }
}