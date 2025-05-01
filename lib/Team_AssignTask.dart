import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/ShowTeamDetails.dart';

class AssignTask extends StatefulWidget {
  final List<String> memberNames;
  final orgName;
  AssignTask(this.memberNames,this.orgName);

  @override
  State<AssignTask> createState() => _AssignTaskState();

}

class _AssignTaskState extends State<AssignTask> with SingleTickerProviderStateMixin{
  var taskNmae=TextEditingController();
  var dueDate=TextEditingController();
  var Remark=TextEditingController();
  late String teamName;
  late List<bool> checked;
  bool isLoading=false;
  @override
  void initState(){
    super.initState();
    teamName=widget.memberNames[widget.memberNames.length-1];
    widget.memberNames.removeLast();
    checked=List<bool>.filled(widget.memberNames.length,false);
  }
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: bgcolor,
        title: Text("Assign Task",style: TextStyle(color: txtcolor),),
        iconTheme: IconThemeData(color: txtcolor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40,right: 40),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(width: 300,
                  margin: EdgeInsets.only(left: 10),
                  child: Text('Task Name :',style: TextStyle(color: txtcolor,fontSize: 18,fontWeight: FontWeight.w500),)
              ),
              TextField(
                controller: taskNmae,
                style: TextStyle(color: txtcolor),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: inputBoxbgColor,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                ),
              ),
              SizedBox(height: 10,),
              Container(width: 300,
                  margin: EdgeInsets.only(left: 10),
                  child: Text('Assign To :',style: TextStyle(color: txtcolor,fontSize: 18,fontWeight: FontWeight.w500),)
              ),
              ListView.builder(
                    itemCount: widget.memberNames.length,
                    shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context , index){
                      return Container(
                        //width: 50,
                        height: 35,
                        child: Row(
                          children: [
                            Checkbox(
                                value: checked[index],
                                onChanged: (bool?value){
                                  setState(() {
                                    checked[index]=value!;
                                  });
                                },
                              side: BorderSide(color: btncolor,width: 2),
                              activeColor: btncolor,
                              checkColor: bgcolor,
                            ),
                            Text(widget.memberNames[index],style: TextStyle(color: textColor2,fontSize: 18))
                          ],
                        ),
                      );
                    }
                ),
              SizedBox(height: 10,),
              Container(width: 300,
                  margin: EdgeInsets.only(left: 10),
                  child: Text('Due Date :',style: TextStyle(color: txtcolor,fontSize: 18,fontWeight: FontWeight.w500),)
              ),
              Container(
                width: 300,
                height: 50,
                margin: EdgeInsets.only(right: 50),
                child: TextField(
                  controller: dueDate,
                  readOnly: true,
                  style: TextStyle(fontSize: 18,color: txtcolor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inputBoxbgColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    suffixIcon: IconButton(
                      onPressed: _pickDate,
                      icon: Icon(Icons.date_range,color: btncolor,),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  ),
                ),
              ),
              SizedBox(height: 10,),
        
              Container(width: 300,
                  margin: EdgeInsets.only(left: 10),
                  child: Text('Remark :',style: TextStyle(color: txtcolor,fontSize: 18,fontWeight: FontWeight.w500),)
              ),
              Container(
                height: 150,
                width: 300,
                margin: EdgeInsets.only(right: 50),

                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black)
                ),
                child: TextField(
                  controller: Remark,
                  style: TextStyle(fontSize: 20, color: txtcolor),    // increase font size
                  maxLines: null,   // Allow multiple lines
                  expands: true, // Expands to fill the container
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: inputBoxbgColor,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)
                    )
                  ),
                ),
              ),
              SizedBox(height: 30,),
              isLoading?CircularProgressIndicator(color: btncolor,)
              :ElevatedButton(onPressed: (){
                saveAssignTask();
              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: btncolor,    // change background color for better visibility.
                      padding: EdgeInsets.only(left: 100,right: 100,top: 11,bottom: 11),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  child: Text('Assign',
                    style: TextStyle(fontSize: 19, color: bgcolor),
                  )
              ),
            ],
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

  void saveAssignTask() {
    setState(() {
      isLoading=true;
    });
    late List<String> selectedName=[];
    for(int i=0;i<checked.length;i++){
      if(checked[i]){
        selectedName.add(widget.memberNames[i]);
      }
    }
    String taskname=taskNmae.text.trim();
    String duedate=dueDate.text.trim();
    if(taskname.isEmpty)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please Enter Task Name')),
        );
        stopLoading();
        return;
      }
    if(duedate.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please Select a Due Date')),
      );
      stopLoading();
      return;
    }
    try{
      final String creatorEmail = FirebaseAuth.instance.currentUser!.email!;
      for(int i=0;i<selectedName.length;i++){
        FirebaseFirestore.instance
            .collection("Teams")
            .doc(creatorEmail)
            .collection('team name')
            .doc(teamName)
            .collection('Members').doc(selectedName[i]).set({
          'Task Name':taskname,
          'Due date':duedate,
          'Remark':Remark.text.trim(),
          'Status':'Pending'

        }
        ).then((value) {
          stopLoading();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Task Assigned Successfully!")),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeamDetails(teamName,widget.orgName)),
          );
        }).catchError((error) {
          print("Failed to add user: $error");
          stopLoading();
        });
      }
    }catch (e){
      print('Error: $e');
      stopLoading();
    }
  }
  void stopLoading(){
    setState(() {
      isLoading=false;
    });
  }
}