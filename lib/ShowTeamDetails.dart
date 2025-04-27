
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/Team_AssignTask.dart';

class TeamDetails extends StatefulWidget{
  String teamname;
  TeamDetails(this.teamname);

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> with SingleTickerProviderStateMixin {
  List<String> memberNames = [];
  List<Map<String, dynamic>> allMemberData = [];
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  String? cremail;
  bool isDataLoaded = false;
  var taskNmae=TextEditingController();
  var dueDate=TextEditingController();
  var Remark=TextEditingController();
  void initState() {
    super.initState();
    fetchMemberEmail();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        title: Text(
          'Team Details', style: TextStyle(color: txtcolor, fontSize: 20),),
        iconTheme: IconThemeData(color: txtcolor),
        actions: [
          isDataLoaded==false?SizedBox(): cremail != null && cremail != userEmail ?SizedBox():
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child:IconButton(
              icon: Icon(Icons.person_add_alt_1,color: boxColor,),
              iconSize: 35,
              onPressed: () {
                MemberAdd();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("Team Name : ${widget.teamname}",
              style: TextStyle(color: btncolor, fontSize: 20),),
            SizedBox(height: 10),
            Expanded(
                child: //memberNames.isEmpty?Center(child: CircularProgressIndicator(),)
                ListView.builder(
                    itemCount: memberNames.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: inputBoxbgColor,
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  remarkDialogueBox(index);
                                },
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Icon(
                                        Icons.person, color: btncolor,),
                                      title: Text(
                                        memberNames[index] == userEmail
                                            ? "You"
                                            : memberNames[index],
                                        style: TextStyle(color: btncolor,
                                            fontWeight: FontWeight.w500),),
                                    ),
                                    allMemberData[index]['Task Name'] == null
                                        ? Text("Task Not Assigned",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 15),)
                                        : Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 40),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                'lib/icons/clipboard.png',
                                                width: 30,
                                                height: 20,
                                                color: textColor2,),
                                              Text(
                                                "${allMemberData[index]['Task Name']}",
                                                style: TextStyle(
                                                    color: txtcolor,
                                                    fontSize: 15),),
                                            ],
                                          ),
                                        ),
                                        Container(height: 10,),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 45),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.timer, color: textColor2,
                                                size: 20,),
                                              Text(
                                                "${allMemberData[index]['Due date']}",
                                                style: TextStyle(
                                                    color: txtcolor,
                                                    fontSize: 15),),
                                            ],
                                          ),
                                        ),
                                        //if(allMemberData[index]['Remark']!=null)Text("Task ${allMemberData[index]['Remark']}",style: TextStyle(color: txtcolor,fontSize: 15),),
                                      ],
                                    ),
                                    Container(height: 20,)
                                  ],
                                ),
                              ),
                              Positioned(
                                //top: 1,
                                right: 1,
                                child: allMemberData[index]['Status'] ==
                                    'Pending'
                                    ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        btncolor),
                                    // Red color for the pending animation
                                    strokeWidth: 3,
                                    // Width of the spinner
                                    semanticsLabel: 'Pending Task',
                                    backgroundColor: Colors
                                        .transparent, // To make the background transparent
                                  ),
                                )
                                    : SizedBox
                                    .shrink(), // If no pending, show nothing
                              ),
                              cremail != null && cremail != userEmail ? SizedBox
                                  .shrink()
                                  : Positioned(
                                top: 1,
                                right: 30,
                                child: allMemberData[index]['Status'] ==
                                    'Pending'
                                    ? GestureDetector(
                                  onTap: () {
                                    EditTaskDialoguebox(index);
                                  },
                                  child: Icon(
                                    Icons.edit_note,
                                    size: 30,
                                    color: btncolor,
                                    semanticLabel: 'Edit Task',
                                  ),
                                )
                                    : SizedBox
                                    .shrink(), // If no pending, show nothing
                              ),
                            ]
                        ),
                      );
                    }
                )
            )
          ],
        ),
      ),
      floatingActionButton: isDataLoaded == false ? null
          : cremail != null && cremail != userEmail ? null
          : SizedBox(
        width: 150,
        height: 40, // desired height
        child: FloatingActionButton.extended(
          onPressed: () {
            //handleAddOrganization();
            memberNames.add(widget.teamname);
            Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => AssignTask(memberNames: memberNames),));
          },
          backgroundColor: btncolor,
          icon: Icon(Icons.add, color: bgcolor, size: 20), // smaller icon
          label: Text(
            'Assign Task',
            style: TextStyle(color: bgcolor, fontSize: 17), // smaller text
          ),
        ),
      ),
    );
  }

  void EditTaskDialoguebox(int index) {
    taskNmae.text=allMemberData[index]['Task Name'];
    dueDate.text=allMemberData[index]['Due date'];
    Remark.text=allMemberData[index]['Remark'];
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            backgroundColor: Colors.transparent,
            // Transparent background for glass effect
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    // Glassy semi-transparent effect
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  padding: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: 200,margin: EdgeInsets.only(left:80),
                          child: Text("Edit Task", style: TextStyle(color: btncolor, fontSize: 20, fontWeight: FontWeight.w700,),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Task Name',style: TextStyle(color: txtcolor,fontSize: 17,fontWeight: FontWeight.w500),),
                        Container(height: 40,
                          child: TextField(
                            controller: taskNmae,
                            style: TextStyle(color: txtcolor),
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: textColor2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: textColor2),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Due Date :',style: TextStyle(color: txtcolor,fontSize: 17,fontWeight: FontWeight.w500),),
                        Container(
                          width: 300,
                          height: 40,
                          margin: EdgeInsets.only(right: 40),
                          child: TextField(
                            controller: dueDate,
                            readOnly: true,
                            style: TextStyle(fontSize: 18,color: txtcolor),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: textColor2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: textColor2),
                              ),
                              suffixIcon: IconButton(
                                onPressed: _pickDate,
                                icon: Icon(Icons.date_range,color: txtcolor,),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text('Remark :',style: TextStyle(color: txtcolor,fontSize: 17,fontWeight: FontWeight.w500),),
                        Container(
                          height: 100,
                          width: 300,
                          margin: EdgeInsets.only(right: 10),
                          child: TextField(
                            controller: Remark,
                            style: TextStyle(color: txtcolor),    // increase font size
                            maxLines: null,   // Allow multiple lines
                            expands: true, // Expands to fill the container
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: textColor2)
                                ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: textColor2)
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  "Close",
                                  style: TextStyle(color: btncolor),
                                ),
                              ),
                            ElevatedButton(onPressed: (){
                              updateTask(index);
                            },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: boxColor,    // change background color for better visibility.
                                    padding: EdgeInsets.only(left: 20,right: 20,top: 2,bottom: 2),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                ),
                                child: Text('Update',
                                  style: TextStyle(fontSize: 17, color: bgcolor),
                                )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        dueDate.text =
        "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  void fetchMemberEmail() async {
    final shareprefs = await SharedPreferences.getInstance();
    String? email = shareprefs.getString('email');
    String? orgName = shareprefs.getString('organizationName');
    //print(email);
    List<Map<String, dynamic>> tempList = [];
    try {
      final teamRef = FirebaseFirestore.instance
          .collection('Teams')
          .doc(userEmail)
          .collection('team name').doc(widget.teamname).collection('Members');

      final snapshot = await teamRef.get();

      if (snapshot.docs.isEmpty) {
        //print('No teams found for: $userEmail');
        final teamref = FirebaseFirestore.instance.collection('Personal Task')
            .doc(userEmail).collection(orgName!)
            .doc(widget.teamname);
        final snapshot1 = await teamref.get();
        if (snapshot1.exists) {
          final data = snapshot1.data();
          cremail = data?['creator email'];
          final teamRef = FirebaseFirestore.instance.collection('Teams').doc(
              cremail).collection('team name').doc(widget.teamname).collection(
              'Members');
          final snapshot = await teamRef.get();
          for (var doc in snapshot.docs) {
            tempList.add(doc.data() as Map<String, dynamic>);
          }
          setState(() {
            memberNames = snapshot.docs.map((doc) => doc.id).toList();
            allMemberData = tempList;
            isDataLoaded = true;
          });
        }
      } else {
        for (var doc in snapshot.docs) {
          tempList.add(doc.data() as Map<String, dynamic>);
        }
        setState(() {
          memberNames = snapshot.docs.map((doc) => doc.id).toList();
          allMemberData = tempList;
          isDataLoaded = true;
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void remarkDialogueBox(int index) {
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            backgroundColor: Colors.transparent,
            // Transparent background for glass effect
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    // Glassy semi-transparent effect
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Remark",
                        style: TextStyle(
                          color: btncolor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      allMemberData[index]['Remark'] == null
                          ? Text(
                        "No remark",
                        style: TextStyle(color: Colors.white),
                      )
                          : Text(
                        allMemberData[index]['Remark'],
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Close",
                            style: TextStyle(color: btncolor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }

  updateTask(int index) {
    print(userEmail);
    print(widget.teamname);
    print(memberNames[index]);
        FirebaseFirestore.instance
            .collection("Teams")
            .doc(userEmail)
            .collection('team name')
            .doc(widget.teamname)
            .collection('Members').doc(memberNames[index]).set({
          'Task Name':taskNmae.text.trim(),
          'Due date':dueDate.text.trim(),
          'Remark':Remark.text.trim(),
          'Status':'Pending'
        }
        ).then((value) {
          fetchMemberEmail();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Task Updated Successfully!")),
          );
          Navigator.pop(context);
        }).catchError((error) {
          print("Failed to update task: $error");
        });
  }

  void MemberAdd() {
    var emailcontroller=TextEditingController();
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            backgroundColor: Colors.transparent,
            // Transparent background for glass effect
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.20),
                    // Glassy semi-transparent effect
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add Member", style: TextStyle(color: btncolor, fontSize: 20, fontWeight: FontWeight.bold,),
                      ),
                      SizedBox(height: 30),
                      TextField(
                        style: TextStyle(color: txtcolor),
                        controller: emailcontroller,
                        decoration: InputDecoration(
                            labelText: 'Enter Email ID',
                            labelStyle: TextStyle(color: txtcolor),
                            border: OutlineInputBorder(
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: textColor2)
                            ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:textColor2)
                          )
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () async{
                            print("add member click");
                            try{
                              final membersRef = FirebaseFirestore.instance
                                  .collection("Teams")
                                  .doc(userEmail)
                                  .collection('team name')
                                  .doc(widget.teamname)
                                  .collection('Members').doc(emailcontroller.text.trim()).set({
                                "Created At": FieldValue.serverTimestamp(),
                              }, SetOptions(merge: true));
                              final shareprefs = await SharedPreferences.getInstance();
                              final orgName = shareprefs.getString('organizationName');
                              final personRef=FirebaseFirestore.instance.collection('Personal Task').doc(emailcontroller.text.trim()).collection(orgName!).doc(widget.teamname).set({
                                "creator email":userEmail
                              },SetOptions(merge:true));;
                              fetchMemberEmail();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Member added successfully!")),
                              );
                              Navigator.pop(context);
                            }catch(e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Failed to add member")),
                              );
                            }
                          },
                          child: Text(
                            "Add Member",
                            style: TextStyle(color: btncolor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}