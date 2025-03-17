import 'package:flutter/material.dart';
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
        child:SingleChildScrollView(
          child: Column(
            children: [
              Text('What is to be done? \t \t \t', style: TextStyle(fontSize: 20, color: appbarcolor)),
              Container(
                width: 250,
                height: 35,
                margin: EdgeInsets.only(left: 40),
                child: TextField(
                  controller: task,
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
              Container(
                width: 250,
                height: 30,
                margin: EdgeInsets.only(left: 40),
                child: TextField(
                  controller: _timeController,
                  readOnly: true,
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _pickTime,
                      icon: Icon(Icons.timer_outlined,color: appbarcolor,),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Add to \t \t \t \t \t \t \t \t \t \t \t \t \t \t \t', style: TextStyle(fontSize: 20, color: appbarcolor)),
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
                  child: Text('Add', style: TextStyle(fontSize: 22, color: Colors.white)), // Increased font size
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}