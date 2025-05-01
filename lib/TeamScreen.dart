import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
//import "package:mailer/mailer.dart";
//import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/AddTeamTask.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/SendInvitation.dart';
import 'package:taskmanager/ShowTeamDetails.dart';
import 'package:taskmanager/TeamMembersScreen.dart';
import 'package:taskmanager/testingfirebase.dart';

import 'package:taskmanager/CreateOrg.dart';

class TeamTask extends StatefulWidget{
  @override
  State<TeamTask> createState() => _TeamTaskState();
}

class _TeamTaskState extends State<TeamTask> with SingleTickerProviderStateMixin {
  String? orgName;
  String? org_id;
  List<String> teamNames = [];
  List<String> teamnm = [];
  bool isLoading = true;
  //final Future<List<Map<String, dynamic>>> _teamsFuture = TeamService.fetchTeamsAndMembers();

  //TextEditingController organizationController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadOrgName();
    //fetchTeamNames();

  }
  Future<void> loadOrgName() async {
    //final shareprefs = await SharedPreferences.getInstance();
    final shareprefs = await SharedPreferences.getInstance();
    String? email=shareprefs.getString("email");
    final teamref=FirebaseFirestore.instance.collection('Personal Task').doc(email).collection("organization");
    final snapshot = await teamref.get();
    if (snapshot.docs.isEmpty) {
      print('No teams found for: $email');
    } else {
      for (var doc in snapshot.docs) {
        print('Team ID: ${doc.id}');
        final data= doc.data();
        print(data['org_id']);
        setState(() {
          orgName=doc.id;
          org_id=data['org_id'];
        });

    }

      await Future.delayed(Duration(milliseconds: 100));
      fetchTeamNames();
    }
    if (orgName == null) {
      //showorganizationDialogbox();
    }
  }

  Future<void> showorganizationDialogbox() async {
    TextEditingController organizationController = TextEditingController();
     await showDialog<String>(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside
      builder: (context) => AlertDialog(
        backgroundColor: boxColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Organization or Name",
              style: TextStyle(fontSize: 18, color: bgcolor),),
            IconButton(
              icon: Icon(Icons.info_outline, color: bgcolor,),
              onPressed:(){},
            ),
          ],
        ),

        content: TextField(
          controller: organizationController,
          style: TextStyle(color: bgcolor),
          decoration: InputDecoration(
            fillColor: inputBoxbgColor,
            labelText: "Enter your organization name",
            labelStyle: TextStyle(color: bgcolor,),
            focusedBorder: OutlineInputBorder(                             // When user clicked on it then the color of border will change
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color:bgcolor, width: 2)
            ),
            enabledBorder: OutlineInputBorder(                             // Default border color when login page will open.
                borderSide: BorderSide(color: bgcolor, width: 2),   // Change color for better experience
                borderRadius: BorderRadius.circular(16)
            ),
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel", style: TextStyle(color: bgcolor))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: btncolor),
            onPressed: () async {
              String userInput = organizationController.text.trim();
              SharedPreferences shaerpref = await SharedPreferences.getInstance();
              await shaerpref.setString("organizationName", userInput);
              loadOrgName();
              fetchTeamNames();
              Navigator.pop(context, userInput);
            },
            child: Text("Submit", style: TextStyle(color: bgcolor),),
          ),
        ],
      )
     );
  }
  Future<void> fetchPersonalTeam() async{
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    try{
      final teamref=FirebaseFirestore.instance.collection('Personal Task').doc(userEmail).collection(orgName!);
      final snapshot = await teamref.get();

      if (snapshot.docs.isEmpty) {
        print('No teams found for: $userEmail');
      } else {
        for (var doc in snapshot.docs) {
          //print('Team ID: ${doc.id}');
          teamnm.add(doc.id);
          //print('Data: ${doc.data()}');
        }
        setState(() {
          teamNames=teamnm;
          print("teams $teamNames");
          isLoading = false;
        });
      }

    }catch (e) {
      print('Error fetching teams2: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> fetchTeamNames() async {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;

    try {
      final teamRef = FirebaseFirestore.instance
          .collection('Team Task')
          .doc(orgName)
          .collection(userEmail!);

      final snapshot = await teamRef.get();

      if (snapshot.docs.isEmpty) {
        print('No teams found for2: $userEmail');
      } else {
        for (var doc in snapshot.docs) {
          print('Team ID: ${doc.id}');
          teamnm.add(doc.id);
          //print('Data: ${doc.data()}');
        }
      }
      /*setState(() {
        teamNames=teamnm;
        print("teams $teamNames");
        isLoading = false;
      });*/
      fetchPersonalTeam();
    } catch (e) {
      print('Error fetching teams: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future<void> deleteOrganizations() async {
    setState(() {
      orgName= null;
    });
    SharedPreferences sharepref = await SharedPreferences.getInstance();
    await sharepref.remove('organizationName');
    //await sharepref.setBool("orgDialogShown", false);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
        children: [
          // If orgName is null, show a message
          orgName == null
              ? Center(
            child: Column(
              children: [
                Text(
                  "No organizations yet.\n",
                  style: TextStyle(color: txtcolor),
                ),
                Row(
                  children: [
                    Container(width: 60,),
                    Text(
                      "To create organizations  ",style: TextStyle(color: txtcolor),),
                    GestureDetector(
                      onTap:(){ CreateOrg.showCustomAlertDialog(context: context);},
                      child: Text(
                        "click here",style: TextStyle(color:btncolor,fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(width: 60,),
                    Text(
                      "To join organizations  ",
                      style: TextStyle(color: txtcolor),
                    ),
                    Text(
                      "click here",style: TextStyle(color:btncolor,fontWeight: FontWeight.bold),),
                  ],
                ),
              ],
            ),
          )
              : Padding(
            padding: const EdgeInsets.only(top: 30, right: 25, left: 25),
            child: Column(
              children: [
                Container(height: 10,),
                Card(
                  color: inputBoxbgColor,
                  child: Column(
                    children: [
                      Container(height: 10,),
                      Row(
                        children: [
                          Container(width: 120,),
                          Text("$orgName",style: TextStyle(color: btncolor,fontWeight: FontWeight.bold,fontSize: 22),),
                          Container(width: 70,),
                          GestureDetector(onTap:(){ shareCode();},
                              child: Icon(Icons.share,color: btncolor,size: 30,))
                        ],
                      ),
                      Container(height: 5,),
                      Text("Teams Found for $orgName organization",style: TextStyle(color: textColor2,fontSize: 15),),
                      isLoading
                          ? Center(child: CircularProgressIndicator(color: btncolor,))
                          : teamNames.isEmpty
                          ? Center(child: Text('No teams found.',style: TextStyle(color:Colors.red),))
                          : ListView.builder(
                        padding: EdgeInsets.zero,
                                                    shrinkWrap: true,  // Allows ListView to shrink wrap based on its content
                                                    itemCount: teamNames.length,
                                                    itemBuilder: (context, index) {
                                                      return Container(
                                                        height: 50, // increase height to fit extra text
                                                        margin: EdgeInsets.only(left: 25,right: 25,top: 10),
                                                        child:InkWell(
                                                      onTap: (){
                                                        Navigator.push(context,
                                                        MaterialPageRoute(builder: (context)=>TeamDetails(teamNames[index],orgName!))
                                                        );
                                                      },
                                                        child: Card(
                                                          color: cardbg,
                                                          elevation: 5,
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                                            child: Column(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    Icon(Icons.group, color: Colors.black54),
                                                                    SizedBox(width: 10),
                                                                    Expanded(
                                                                      child: Text(
                                                                        teamNames[index],
                                                                        style: TextStyle(color: bgcolor, fontSize: 16),
                                                                      ),
                                                                    ),
                                                                    Icon(Icons.arrow_forward_ios, color: bgcolor, size: 15),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 1),

                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        )
                                                      );

                                                    },
                                                  ),
                      Container(height: 30,)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: orgName==null? SizedBox():SizedBox(
        width: 120,
        height: 40, // desired height
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => sendInvitation(orgName: orgName ?? "njk"),
              ),
            );
            //handleAddOrganization();
          },
          backgroundColor: btncolor,
          icon: Icon(Icons.add, color: bgcolor, size: 20), // smaller icon
          label: Text(
            'Add Team',
            style: TextStyle(color: bgcolor, fontSize: 15), // smaller text
          ),
        ),
      ),
    );

  }

  void shareCode() {
    String playStoreLink =
        'https://play.google.com/store/apps/details?id=com.example.yourapp';
    String message =
        'Join our organization "${orgName}" using this code: "$org_id" \n Download the app: $playStoreLink';
    Share.share(message);
  }
}


