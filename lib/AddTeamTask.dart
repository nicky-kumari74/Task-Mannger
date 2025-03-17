import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
import 'package:taskmanager/TeamScreen.dart';

class AddTeamTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}
class _AddTaskState extends State<AddTeamTask> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  var assignTask = TextEditingController();
  var assignTo = TextEditingController();
  var comment = TextEditingController();

  /// Function to show Date Picker
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 54,
          leadingWidth: 37,
          title: Text(
            'Powering Personal and Team Task',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          margin: EdgeInsets.only(top: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Asign Task \t \t \t \t \t \t \t \t \t \t ', style: TextStyle(fontSize: 20, color: appbarcolor)),
                Container(
                  width: 250,
                  height: 35,
                  margin: EdgeInsets.only(left: 40),
                  child: TextField(
                    controller: assignTask,
                      style: TextStyle(fontSize: 18)
                  ),
                ),
                SizedBox(height: 20),
                Text('Asign To \t \t \t \t \t \t \t \t \t \t \t \t', style: TextStyle(fontSize: 20, color: appbarcolor)),
                Container(
                  width: 250,
                  height: 35,
                  margin: EdgeInsets.only(left: 40),
                  child: TextField(
                    controller: assignTo,
                      style: TextStyle(fontSize: 18)
                  ),
                ),
                SizedBox(height: 20),
                Text('Due date \t \t \t \t \t \t \t \t \t \t \t \t', style: TextStyle(fontSize: 20, color: appbarcolor)),
                Container(
                  width: 250,
                  height: 30,
                  margin: EdgeInsets.only(left: 40),
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _pickDate,
                        icon: Icon(Icons.date_range,color: appbarcolor,),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text('Comment \t \t \t \t \t \t \t \t \t \t \t \t', style: TextStyle(fontSize: 20, color: appbarcolor)),
                Container(
                  height: 180,
                  width: 280,
                  margin: EdgeInsets.only(left: 50,top: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)
                  ),
                  child: TextField(
                    controller: comment,
                    style: TextStyle(fontSize: 20, color: Colors.black),    // increase font size
                    maxLines: null,   // Allow multiple lines
                    expands: true,    // Expands to fill the container

                  ),
                ),
                SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minimumSize: Size(180, 40), // Increased button size
                    ),
                    child: Text('Assign', style: TextStyle(fontSize: 22, color: Colors.white)), // Increased font size
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}