import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';

class sendInvitation extends StatefulWidget {

  final String orgName;
  sendInvitation({required this.orgName});

  @override
  State<sendInvitation> createState() => _sendInvitationState();
}

class _sendInvitationState extends State<sendInvitation> {
  TextEditingController teamnameController = TextEditingController();
  List<TextEditingController> emailControllers = [];

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
    String teamname = teamnameController.text.trim();
    List<String> emailslist = emailControllers.map((controller) =>
        controller.text.trim())
        .where((email) => email.isNotEmpty).toList();

    if (teamname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a team name')),
      );
      return;
    }
    if (emailslist.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter at least two email')),
      );
      return;
    }

    try {
      // Save data to Firebase
     /* var sharepref= await SharedPreferences.getInstance();
      var emails=sharepref.getString("email");
      var shaerpref = await SharedPreferences.getInstance();
      var organization  = shaerpref.getString("organization");*/
      final String creatorEmail = FirebaseAuth.instance.currentUser!.email!;

      //Save organization level data with creator email
      await FirebaseFirestore.instance.collection("Team Task").doc(widget.orgName).
      set({
        "Creator Email" : creatorEmail,
        //"Created At": FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await FirebaseFirestore.instance.collection("Team Task").doc(widget.orgName).collection(creatorEmail).doc(teamname).set(
          {
            "Team Name" : teamname,
            "Members" : FieldValue.arrayUnion(emailslist),
            "Created At" : FieldValue.serverTimestamp(),
          }, SetOptions(merge: true)
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invitations sent successfully!")),
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error saving data to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save invitation")),
      );
    }
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        toolbarHeight: 70,
        title: Text('Send Invitation', style: TextStyle(color: txtcolor, ),),
        iconTheme: IconThemeData(color: txtcolor),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(19),
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
                            borderSide: BorderSide(color: btncolor)
                          )
                        ),
                      ),
                      SizedBox(height: 39,),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: emailControllers.length,
                          itemBuilder: (context, index) {
                          return Padding(padding: EdgeInsets.symmetric(vertical: 8.1),
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
                              child: Text('+ add more...', style: TextStyle(color: btncolor),))
                        ),

                      SizedBox(height: 160,),
                      ElevatedButton(onPressed: () {
                        sendInvitation();
                         },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: btncolor,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 31),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: Text("Send Invitation", style: TextStyle(color: txtcolor),),
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