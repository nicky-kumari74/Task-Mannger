import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Add_PersonalTask.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/date_extension.dart';

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
      body: SingleChildScrollView(
        child: email == null
            ? Center(child: CircularProgressIndicator()) // Show loader until email is fetched
            : StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Personal Task').doc(email).collection('Tasks').orderBy('Date', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading state
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No tasks available!",style: TextStyle(color: txtcolor),));
            }
        
            var tasks = snapshot.data!.docs;
        // Group tasks by date
            Map<String, List<Map<String, dynamic>>> groupedTasks = {};
        
            for (var task in tasks) {
              var taskData = task.data() as Map<String, dynamic>;
              taskData['id']=task.id;
              // Check if the 'date' field exists and is a Timestamp
              if (taskData['Date'] != null && taskData['Date'] is Timestamp) {
                DateTime taskDate = (taskData['Date'] as Timestamp).toDate();
                String dateKey = "${taskDate.year}-${taskDate.month.toString().padLeft(2, '0')}-${taskDate.day.toString().padLeft(2, '0')}";
        
                // Group tasks by date
                if (!groupedTasks.containsKey(dateKey)) {
                  groupedTasks[dateKey] = [];
                }
                groupedTasks[dateKey]!.add(taskData);

              } else {
                // Handle the case where date is missing or invalid
                print("Task has no valid date: ${taskData['Task Name']}");
              }
            }
            return Padding(
              padding: const EdgeInsets.only(right: 25, left: 25),
              child: Column(
                children: [
                  //const SizedBox(height: 10),
                  // Loop through each date group
                  ...groupedTasks.entries.map((entry) {
                    String dateKey = entry.key;
                    List<Map<String, dynamic>> dayTasks = entry.value;

                    // Format the date for display
                    DateTime date = DateTime.parse(dateKey);
                    String formattedDate = (date.isToday)
                        ? "Today"
                        : (date.isYesterday)
                        ? "Yesterday"
                        : "${date.day}/${date.month}/${date.year}";
        
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Card(
                        color: inputBoxbgColor,
                        child: Padding(
                          padding: const EdgeInsets.only(top:5,left: 12,right: 12),
                          child: Column(
                            children: [
                              Text(formattedDate, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: btncolor)),
                              // ListView of tasks for this date
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,  // Important: makes ListView take only needed height
                                physics: const NeverScrollableScrollPhysics(), // Prevents ListView from scrolling separately
                                itemCount: dayTasks.length,
                                itemBuilder: (context, index) {
                                  var taskData = dayTasks[index];
                                  return Dismissible(
                                    key: Key(tasks[index].id),
                                    direction: DismissDirection.endToStart, // Swipe left to delete
                                    background: Container(
                                      alignment: Alignment.centerRight,
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      child: Icon(Icons.delete, color: Colors.white),
                                    ),
                                    confirmDismiss: (direction) async {
                                      bool confirm = await _showDeleteConfirmationDialog(context, taskData['id'],"Delete Task");
                                      return false;
                                    },
                                    child: Container(
                                      height: 50,  // Adjusted for better spacing
                                      margin: const EdgeInsets.symmetric(horizontal: 10,),
                                      child: InkWell(
                                        onTap: () {
                                          // Handle onTap if needed
                                        },
                                        child: Card(
                                          color: cardbg,
                                          elevation: 3,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                onTap: ()async{
                                                  bool confirm = await _showDeleteConfirmationDialog(context, taskData['id'],"Completed");
                                                  //return false;
                                                },
                                                  child: Image.asset(
                                                    'lib/icons/time.png',
                                                    color: taskData['status'] == "pending" ? Colors.red : iconColor,
                                                    width: 20,
                                                    height: 15,
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  //width: 100,
                                                  child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPersonalTask(taskData['Task Name'],taskData['id'])));
                                                      },
                                                    child: Container(
                                                      height: 20,
                                                      child: Text(
                                                          //taskData['Task Name'],
                                                          getFirstTwoWords(taskData['Task Name'] ?? ''),
                                                          style: TextStyle(
                                                            color: bgcolor,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPersonalTask(taskData['Task Name'],taskData['id'])));
                                                    //UpdateTask(taskId,taskData['Task Name']);
                                                    },
                                                    child: Icon(Icons.arrow_forward_ios, color: bgcolor,size: 15,)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: SizedBox(
          width: 130,
          height: 45, // desired height
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPersonalTask("","")));
              //showPersonaldialogbox();
            },
            backgroundColor: btncolor,
            icon: Icon(Icons.add, color: bgcolor, size: 25), // smaller icon
            label: Text(
              'Add Task  ',
              style: TextStyle(color: bgcolor, fontSize: 18), // smaller text
            ),
          ),
        ),
      ),
    );
  }
  void showPersonaldialogbox() {
    TextEditingController Taskname = TextEditingController();
    TextEditingController inviteMembers = TextEditingController();
    showDialog(context: context, builder: (context) {
      return AlertDialog(title: Text("Create New Task",style: TextStyle(color: btncolor,fontWeight: FontWeight.w500),),backgroundColor: inputBoxbgColor,
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,  // This make dialog box width responsive.
            child: Column(
              mainAxisSize: MainAxisSize.min,  // Help to shrink the dialog box height according to content.
              children: [
                Container(height: 10,),
                TextField(
                  controller: Taskname,
                  style: TextStyle(color: txtcolor),
                  decoration: InputDecoration(
                    hintText: 'Enter Task Name',
                    hintStyle: TextStyle(color: textColor2),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:textColor2,width: 2),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:textColor2,width: 1),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop((context)),   // close dialog box
              child: Text('Cancel',style: TextStyle(fontSize: 18,color: btncolor)),
            ),
            TextButton(onPressed: () {
              String Task = Taskname.text.trim();
              if (Task.isNotEmpty) {
                //addTask(Task);
                setState(() {
                  //teams.add(newTeam);
                  //saveTeams();
                });
                Navigator.pop(context);   // Close dialog box
              }
            }, child: Text("Add",style: TextStyle(fontSize: 18,color: btncolor),),
            ),
          ],

      );
    });
  }
  String getFirstTwoWords(String text) {
    List<String> words = text.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0]} ${words[1]}';
    } else {
      return text; // If less than 2 words, show the whole text
    }
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context,String taskId,String title) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(backgroundColor: inputBoxbgColor,
        title: Row(
          children: [
            Text(title,style: TextStyle(color: txtcolor),),
            Container(width: 20,),
            title=="Completed"?Image.asset(
              'lib/icons/checkmark.png',
              color:  Colors.green,
              width: 25,
              height: 25,
            ) :Icon(Icons.delete, color: Colors.red, size: 25)
          ],
        ),
        content: Text(title=="Completed"?"Do you want to mark this task as completed?":"Are you sure you want to delete this task?",style: TextStyle(color: txtcolor,fontSize: 15),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancel",style: TextStyle(color: btncolor),),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(taskId);
              Navigator.pop(context, false);
              },
            child: Text(title=="Completed"?"Yes":"Delete", style: TextStyle(color: btncolor))),
        ],
      ),
    ) ??
        false;
  }
  void _deleteTask(String taskId) {
    if (email == null) {
      print("Email not found. Cannot delete task.");
      return;
    }
    print("task id $taskId");
    FirebaseFirestore.instance
        .collection('Personal Task').doc(email).collection('Tasks') // Use email! directly
        .doc(taskId) // Reference the document by its ID
        .delete()
        .then((_) {
      print("Task Deleted Successfully! $taskId");
      setState(() {}); // Refresh the UI after deletion
    }).catchError((error) {
      print("Failed to delete task: $error");
    });
  }
}