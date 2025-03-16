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

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: assignPersonalTask,
              style: TextStyle(fontSize: 20, color: Colors.black),   // increase font size
              decoration: InputDecoration(
                labelText: 'Assign Task',
                labelStyle: TextStyle(color: Colors.black87, fontSize: 20),

              ),
            ),
          ),

          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: assignTo,
              style: TextStyle(fontSize: 20, color: Colors.black),   // increase font size
              decoration: InputDecoration(
                labelText: 'Assign To',
                labelStyle: TextStyle(color: Colors.black87, fontSize: 20),

              ),
            ),
          ),

          SizedBox(height: 9,),
          Container(
            height: 180,
            width: 320,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black)
            ),
            child: TextField(
              controller: comment,
              style: TextStyle(fontSize: 20, color: Colors.black),   // increase font size
              maxLines: null,   // Allow multiple lines
              expands: true,    // Expands to fill the container
              decoration: InputDecoration(
                  labelText: 'Comment',
                  labelStyle: TextStyle(color: Colors.black, fontSize: 18),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8)
              ),
            ),
          ),

          SizedBox(height: 12,),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
          },
              style: ElevatedButton.styleFrom(
                  backgroundColor: appbarcolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
              child: Text('Assign', style: TextStyle(fontSize: 20, color: Colors.white),))

        ],
      ),


    );
  }

}