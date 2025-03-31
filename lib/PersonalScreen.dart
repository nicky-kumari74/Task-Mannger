import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/AddPersonalTask.dart';
import 'package:taskmanager/Colors.dart';

class PersonalTask extends StatefulWidget {
  @override
  _PersonalTaskState createState() => _PersonalTaskState();
}

class _PersonalTaskState extends State<PersonalTask> {
  String? email; // Store user email
  //bool? isChecked=false;
  late List<bool> isCheckedList;
  Map<String, bool> isCheckedMap = {};

  @override
  void initState() {
    super.initState();
    _getEmail(); // Fetch email from SharedPreferences
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
      body: email == null
          ? Center(child: CircularProgressIndicator()) // Show loader until email is fetched
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(email!).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // Loading state
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No tasks available!",style: TextStyle(color: txtcolor),));
          }

          var tasks = snapshot.data!.docs;

          return ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              var taskData = tasks[index].data() as Map<String, dynamic>;
              String taskId = tasks[index].id; // Unique ID for each task
              bool isChecked = isCheckedMap[taskId] ?? false;
              return Card(
                elevation: 2,
                  color: inputBoxbgColor,
                  margin: EdgeInsets.only(top: index == 0 ? 20 : 15,),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
                  child: Column(
                    children: [
                      //SizedBox(height: 3),
                      Row(children: [
                        Container(
                            height: 20,
                            margin: EdgeInsets.only(top: 10),
                            child:taskData['status']=="pending"?
                    Image.asset('lib/icons/hour_glass.png',color: Colors.white,):
                            Image.asset('lib/icons/checkmark.png',color: Colors.white,)
                        ),
                        //Icon(Icons.pending, color: Colors.white, size: 18),
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(left:50),
                          child: Text(
                            taskData['Task Name'] ?? "No Task",
                            style: TextStyle(
                              color:txtcolor,fontSize: 18,),
                          ),
                        ),
                          //Container(width: 90,),
                          IconButton(
                              onPressed: () {
                                _deleteTask(taskId); // Function to delete task
                              },
                              icon: Icon(Icons.delete, color: Colors.white, size: 25)),

                      ]),
                      Row(children: [
                        /*Icon(Icons.date_range, color: Colors.black54, size: 18),
                        Text(taskData['Date'] ?? "No Date", style: TextStyle(color: Colors.black)),
                        SizedBox(width: 20),
                        Icon(Icons.access_time, color: Colors.black54, size: 18),
                        Text(taskData['Time'] ?? "No Time", style: TextStyle(color: Colors.black)),*/
                        SizedBox(width: 40),
                        Text("Mark as completed",style: TextStyle(color: textColor2),),
                        Checkbox(value: taskData["checked"],
                            activeColor: btncolor,
                            side: BorderSide(color:btncolor, width: 2),
                            onChanged: (bool? newBool) {
                              setState(() {
                                isCheckedMap[taskId] = newBool ?? false;// Update only this task's checkbox
                                FirebaseFirestore.instance
                                    .collection(email!) // Access the user's collection
                                    .doc(taskId) // Find the specific task by its ID
                                    .update({
                                  "status": "completed",
                                  "checked":true// Update only this field
                                })
                                    .then((_) {
                                  print("Task updated successfully!");
                                  setState(() {}); // Refresh UI if needed
                                }).catchError((error) {
                                  print("Failed to update task: $error");
                                });
                              });
                            }),
                        /*ElevatedButton(
                          onPressed: () {
                            print("clicked");
                            //Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            minimumSize: Size(80, 25),
                          ),
                          child: Text('Pending', style: TextStyle(fontSize: 12, color: Colors.red)),
                        ),*/
                      ]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          showPersonaldialogbox();
          //Navigator.push(context, MaterialPageRoute(builder: (context) => AddPersonalTask()));
        },
        backgroundColor: btncolor,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
  void showPersonaldialogbox() {
    TextEditingController Taskname = TextEditingController();
    TextEditingController inviteMembers = TextEditingController();
    showDialog(context: context, builder: (context) {
      return AlertDialog(title: Text("Create New Task"),backgroundColor: boxColor,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,  // This make dialog box width responsive.
            child: Column(
              mainAxisSize: MainAxisSize.min,  // Help to shrink the dialog box height according to content.
              children: [
                Container(height: 10,),
                TextField(
                  controller: Taskname,
                  decoration: InputDecoration(
                    hintText: 'Enter Task Name',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                        borderRadius: BorderRadius.circular(15)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop((context)),   // close dialog box
              child: Text('Cancel',style: TextStyle(fontSize: 18)),
            ),
            TextButton(onPressed: () {
              String Task = Taskname.text.trim();
              if (Task.isNotEmpty) {
                addTask(Task);
                setState(() {
                  //teams.add(newTeam);
                  //saveTeams();
                });
                Navigator.pop(context);   // Close dialog box
              }
            }, child: Text("Add",style: TextStyle(fontSize: 18),),
            ),
          ],

      );
    });
  }

  void addTask(String task) async {
    var sharepref= await SharedPreferences.getInstance();
    var email=sharepref.getString("email");
    FirebaseFirestore.instance.collection(email!).add({
      'Task Name': task,
      'status':"pending",
      'checked':false
    }).then((value) {
      print("Task Added");
    }).catchError((error) {
      print("Failed to add user: $error");
    });
  }

  void _deleteTask(String taskId) {
    if (email == null) {
      print("Email not found. Cannot delete task.");
      return;
    }

    FirebaseFirestore.instance
        .collection(email!) // Use email! directly
        .doc(taskId) // Reference the document by its ID
        .delete()
        .then((_) {
      print("Task Deleted Successfully!");
      setState(() {}); // Refresh the UI after deletion
    }).catchError((error) {
      print("Failed to delete task: $error");
    });
  }
}