import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
class AddPersonalTask extends StatefulWidget {
  @override
  _AddTaskState createState() => _AddTaskState();
}
class _AddTaskState extends State<AddPersonalTask> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  var task = TextEditingController();
  // Dropdown selected value
  String selectedPriority = 'Personal';
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

  /// Function to show Time Picker
  void _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 54,
        leadingWidth: 37,
        title: Text(
          'Add Task',
          style: TextStyle(fontSize: 25, color: txtcolor,fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 40),
        child:SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(35.0),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: btncolor),
                borderRadius: BorderRadius.circular(25)
              ),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Text('What is to be done?', style: TextStyle(fontSize: 20, color: txtcolor)),
                    SizedBox(height: 5),
                    Container(
                      width: 230,
                      height: 40,
                      child: TextField(
                        controller: task,
                          style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Colors.black, width: 2),    // Dynamic Border color
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Due date', style: TextStyle(fontSize: 20, color: txtcolor)),
                    SizedBox(height: 5),
                    Container(
                      width: 180,
                      height: 35,
                      //margin: EdgeInsets.only(left: 40),
                      child: TextField(
                        controller: _dateController,
                        readOnly: true,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color:Colors.black, width: 2),    // Dynamic Border color
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          suffixIcon: IconButton(
                            onPressed: _pickDate,
                            icon: Icon(Icons.date_range,color: Colors.black,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: 180,
                      height: 35,
                      //margin: EdgeInsets.only(left: 40),
                      child: TextField(
                        controller: _timeController,
                        readOnly: true,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide(color:Colors.black, width: 2),    // Dynamic Border color
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(6)
                          ),
                          suffixIcon: IconButton(
                            onPressed: _pickTime,
                            icon: Icon(Icons.timer_outlined,color: Colors.black,),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    /*Text('Add to \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t', style: TextStyle(fontSize: 20, color: appbarcolor)),
                    Container(
                      width: 250,
                      margin: EdgeInsets.only(left: 40),
                      child: DropdownButton<String>(
                        value: selectedPriority,
                        isExpanded: true,
                        items: ['Personal', 'Team'].map((String priority) {
                          return DropdownMenuItem<String>(
                            value: priority,
                            child: Text(priority, style: TextStyle(fontSize: 18)),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedPriority = newValue!;
                          });
                        },
                      ),
                    ),*/
                    SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          addTask();
                          //Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btncolor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          minimumSize: Size(180, 40), // Increased button size
                        ),
                        child: Text('Add', style: TextStyle(fontSize: 22, color: Colors.white)), // Increased font size
                      ),
                    ),
                    SizedBox(height: 50)
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  void addTask() async {
    var sharepref= await SharedPreferences.getInstance();
    var email=sharepref.getString("email");
    FirebaseFirestore.instance.collection(email!).add({
      'Task Name': task.text,
      'Date': _dateController.text,
      'Time': _timeController.text,
    }).then((value) {
      print("Task Added");
      task.clear();
      _timeController.clear();
      _dateController.clear();
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }
}