
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';

class AddPersonalTask extends StatefulWidget{
  final taskdata;
  final taskid;
  AddPersonalTask(this.taskdata,this.taskid);
  @override
  State<AddPersonalTask> createState() => _AddAddPersonalTaskState();
}

class _AddAddPersonalTaskState extends State<AddPersonalTask>{
  var task=TextEditingController();
  bool _isLoading=false;
  String? email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    task.text=widget.taskdata;
    _getEmail();
  }
  Future<void> _getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString("email");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        //title: Text("Add Task",style: TextStyle(color: txtcolor,),),
        iconTheme: IconThemeData(color: txtcolor),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(onPressed: (){
              widget.taskdata.toString().isEmpty?AddTask():UpdateTask();
            },
                child: Text(widget.taskdata.toString().isEmpty?"Save":"Update",style: TextStyle(color: btncolor,fontSize: 18,fontWeight: FontWeight.bold),)),
            /*child:IconButton(
              icon: Icon(Icons.edit,color: btncolor,),
              iconSize: 35,
              onPressed: () {
               // MemberAdd();
              },
            ),*/
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight,   //Make TextField fill the screen
                      //height: 540,
                      child: TextField(
                        controller: task,
                        expands: true,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        textInputAction: TextInputAction.newline,
                        textAlignVertical: TextAlignVertical.top,
                        cursorColor: btncolor,
                        style: TextStyle(color: txtcolor,fontSize: 18),
                        decoration: InputDecoration(
                          hintText: "Enter tasks......",
                          hintStyle: TextStyle(color: textColor2),
                          filled: true,
                          fillColor: inputBoxbgColor,
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    _isLoading
                        ? CircularProgressIndicator(color: btncolor)
                        : ElevatedButton(onPressed: () {
                      AddTask();
                    },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: btncolor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 100),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text("Add",
                        style: TextStyle(color: bgcolor,fontWeight: FontWeight.w500),),
                    ),
                    //SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> AddTask() async {
    String tsk=task.text.trim();
    if(tsk.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Enter task")),
      );
      return;
    }
    var sharepref= await SharedPreferences.getInstance();
    var email=sharepref.getString("email");
    FirebaseFirestore.instance.collection('Personal Task').doc(email).collection("Tasks").add({
      'Task Name': tsk,
      'status':"pending",
      'checked':false,
      'Date':DateTime.now(),
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Task Saved successfully",style: TextStyle(color: btncolor,fontSize: 18),),backgroundColor: Colors.transparent,)
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to Save Task",style: TextStyle(color: Colors.red,fontSize: 18),),backgroundColor: Colors.transparent,)
      );
    });
  }

  UpdateTask() {
    String Task = task.text.trim();
    if (Task.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('Personal Task')
          .doc(email)
          .collection("Tasks")
          .doc(widget.taskid) // <-- Replace with the actual task document ID
          .update({
        'Task Name': Task,
        'status': 'pending',
        'checked': false
      }).then((value) {
        //print("Task Updated");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Task Updated successfully",style: TextStyle(color: btncolor,fontSize: 18),),backgroundColor: Colors.transparent,)
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Faild to update Task",style: TextStyle(color: Colors.red,fontSize: 18),),backgroundColor: Colors.transparent,)
        );
      });
    }
  }

}