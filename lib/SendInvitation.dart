import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';

import 'DashboardScreen.dart';

class sendInvitation extends StatefulWidget {

  final String orgName;
  sendInvitation({required this.orgName});

  @override
  State<sendInvitation> createState() => _sendInvitationState();
}

class _sendInvitationState extends State<sendInvitation> {
  TextEditingController teamnameController = TextEditingController();
  List<TextEditingController> emailControllers = [];
  bool _isLoading=false;

  @override
  void initState () {
    super.initState();
    // Start with 3 email fields
    for (int i = 0; i<3; i++) {
      emailControllers.add(TextEditingController());
    }
  }

  // Functions to add a new email field (max 10)

  void addEmailField () {
    if (emailControllers.length <10) {
      setState(() {
        emailControllers.add(TextEditingController());
      });

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can only add up to 10 emails")),
      );
      return ;
    }
  }

  //Function to send invitation
  Future<void> sendInvitation () async {
    setState(() {
      _isLoading = true;
    });
    String teamname = teamnameController.text.trim();
    List<String> emailslist = emailControllers.map((controller) =>
        controller.text.trim())
        .where((email) => email.isNotEmpty).toList();

    if (teamname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a team name')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (emailslist.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter at least two email')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      // Save data to Firebase
      /* var sharepref= await SharedPreferences.getInstance();
      var emails=sharepref.getString("email");
      var shaerpref = await SharedPreferences.getInstance();
      var organization  = shaerpref.getString("organization");*/
      final String creatorEmail = FirebaseAuth.instance.currentUser!.email!;
      FirebaseFirestore.instance.collection('Team Task').doc(widget.orgName).collection(
          creatorEmail).doc(teamname).set({
      }).then((value) {
        print("Task Added");
      }).catchError((error) {
        print("Failed to add user: $error");
      });
      final membersRef = FirebaseFirestore.instance
          .collection("Teams")
          .doc(creatorEmail)
          .collection('team name')
          .doc(teamname)
          .collection('Members');

      await Future.wait(emailslist.map((email) {
        return membersRef.doc(email).set({
          "Created At": FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
      }));

      final personRef=FirebaseFirestore.instance.collection('Personal Task');
      await Future.wait(emailslist.map((email){
        return personRef.doc(email).collection(widget.orgName).doc(teamname).set({
          "creator email":creatorEmail
        },SetOptions(merge:true));
      }));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invitations sent successfully!")),
      );
      //Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Dashboard()));
    } catch (e) {
      print("Error saving data to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save invitation")),
      );
    }
    finally {
      setState(() {
        _isLoading = false;
      });
    }
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: bgcolor,
        appBar: AppBar(
          backgroundColor: bgcolor,
          toolbarHeight: 70,
          title: Text('Create Team', style: TextStyle(color: txtcolor,),),
          iconTheme: IconThemeData(color: txtcolor),
        ),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          controller: teamnameController,
                          style: TextStyle(color: txtcolor),
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: inputBoxbgColor,
                              hintText: 'Enter Team Name',
                              hintStyle: TextStyle(
                                color: txtcolor,
                                fontSize: 18,
                              ),
                              //border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: btncolor),
                                borderRadius: BorderRadius.circular(10)
                              ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                        ),
                        SizedBox(height: 39,),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: emailControllers.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.1),
                                child: TextField(
                                  style: TextStyle(color: txtcolor),
                                  controller: emailControllers[index],
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: inputBoxbgColor,
                                      labelText: 'Enter Email ID',
                                      labelStyle: TextStyle(color: txtcolor),
                                      border: OutlineInputBorder(
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: btncolor)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      )
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              );
                            }),

                        SizedBox(height: 20,),

                        Align(
                            alignment: Alignment.topRight,
                            child: InkWell(
                                onTap: () {
                                  if (emailControllers.length < 10) {
                                    addEmailField();
                                  }
                                },
                                child: Text('+ add more...',
                                  style: TextStyle(color: btncolor),))
                        ),

                        SizedBox(height: 50,),
                        _isLoading
                            ? CircularProgressIndicator(color: btncolor)
                            : ElevatedButton(onPressed: () {
                          sendInvitation();
                        },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: btncolor,
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 110),
                            textStyle: TextStyle(fontSize: 20),
                          ),
                          child: Text("Create",
                            style: TextStyle(color: bgcolor,fontWeight: FontWeight.w500),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }