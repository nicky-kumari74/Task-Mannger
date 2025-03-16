import 'package:flutter/material.dart';
import 'package:taskmanager/AddTask.dart';
import 'package:taskmanager/Colors.dart';

class PersonalTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text('personal task')
                ),
                Container(
                    margin: EdgeInsets.only(left: 0,top: 480),
                  child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AddTask()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.all(10),
                          elevation: 10
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