
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        //title: Text("Add Task",style: TextStyle(color: txtcolor,),),
        iconTheme: IconThemeData(color: btncolor),
        actions: [
          GestureDetector(
            onTap: (){shareTask();},
              child: Icon(Icons.share,color: btncolor,)
          ),
          SizedBox(width: 15,),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: TextButton(onPressed: (){
              widget.taskdata.toString().isEmpty?AddTask():UpdateTask();
            },
                child: Text(widget.taskdata.toString().isEmpty?"Save":"Update",style: TextStyle(color: btncolor,fontSize: 16,fontWeight: FontWeight.bold),)
            ),
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
          return Stack(
            children: [
              /*Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                margin: EdgeInsets.only(top:5),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/page2.jpg'),fit: BoxFit.cover),
                ),
              ),*/
              /*Divider(
                color: Colors.grey,
                thickness: 2,
              ),*/
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top:5.65),
                  child: Column(
                    children: [
                      Container(
                        //height: constraints.maxHeight, //Make TextField fill the screen
                        //height: 610,
                        height: screenHeight-105,
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
                            hintStyle: TextStyle(color: textColor2,fontSize: 18),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: inputBoxbgColor,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.transparent)
                            ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.transparent)
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    ]
          );
        },
      ),
        floatingActionButton: !widget.taskdata.toString().isEmpty?SizedBox():Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
    child: SizedBox(
    width: 50,
    height: 50, // desired height
    child: FloatingActionButton(
    onPressed: () {
      AddTask();
    //showPersonaldialogbox();
    },
    backgroundColor: btncolor,
    child: Icon(Icons.check, color: bgcolor, size: 30),
      tooltip: 'Add Task',
    ),

    ),
        )
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

  void shareTask() {
    String tsk=task.text.trim();
    if(tsk.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please Enter Message",style: TextStyle(color: btncolor,fontSize: 18),),backgroundColor: Colors.transparent,)
      );
    }
    else{
      Share.share(tsk);
    }
  }

}