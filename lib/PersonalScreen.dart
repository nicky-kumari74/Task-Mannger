import 'package:flutter/material.dart';
import 'package:taskmanager/AddPersonalTask.dart';
import 'package:taskmanager/Colors.dart';

class PersonalTask extends StatelessWidget{
  List<String> item=<String>['a','b','c'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
              children: [
                ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: item.length,
                    itemBuilder: (BuildContext context,int index){
                      return Container(
                        height: 50,
                        child: Center(child: Text('Entry ${item[index]}'),),
                      );
                    }
                ),
                Container(
                  margin: EdgeInsets.only(left: 0,top: 480),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddPersonalTask()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        backgroundColor: btncolor,
                        padding: EdgeInsets.all(10),
                        elevation: 10
                    ),
                    child: Icon(Icons.add, color: Colors.white,size: 30,),
                  ),
                ),

              ],
            ),
    );
  }
}