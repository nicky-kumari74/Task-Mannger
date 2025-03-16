import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
import 'package:taskmanager/TeamScreen.dart';

class AddTeamTask extends StatelessWidget{

  var assignTeamTask = TextEditingController();
  var assignTo = TextEditingController();
  var comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 54,  // Optional, appbar height
        leadingWidth: 37,
        title: Text('Powering Personal and Team Task', style: TextStyle(fontSize: 18, color: Colors.white),),
        backgroundColor: appbarcolor,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: assignTeamTask,
              style: TextStyle(fontSize: 20, color: Colors.black),    // increase font size
              decoration: InputDecoration(
                labelText: 'Assign Task',
                labelStyle: TextStyle(color: Colors.black87, fontSize: 20),
                /*focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: borderColor, width:2)
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black, width: 2)
                )*/   // For Border
              ),
            ),
          ),

          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: assignTo,
              style: TextStyle(fontSize: 20, color: Colors.black),    // increase font size
              decoration: InputDecoration(
                  labelText: 'Assign To',
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 20),
               /*   focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: borderColor, width:2)
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black, width: 2)
                  )*/       // For Border
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
              style: TextStyle(fontSize: 20, color: Colors.black),    // increase font size
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