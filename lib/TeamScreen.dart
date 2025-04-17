import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import "package:mailer/mailer.dart";
//import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/AddTeamTask.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/SendInvitation.dart';
import 'package:taskmanager/ShowTeamDetails.dart';
import 'package:taskmanager/TeamMembersScreen.dart';
import 'package:taskmanager/testingfirebase.dart';

class TeamTask extends StatefulWidget{
  @override
  State<TeamTask> createState() => _TeamTaskState();
}

class _TeamTaskState extends State<TeamTask> with SingleTickerProviderStateMixin {
  String? orgName;
  List<String> teamNames = [];
  bool isLoading = true;
  //final Future<List<Map<String, dynamic>>> _teamsFuture = TeamService.fetchTeamsAndMembers();

  //TextEditingController organizationController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadOrgName();
    fetchTeamNames();
    //showorganizationDialogbox();
  }
  Future<void> loadOrgName() async {
    final shareprefs = await SharedPreferences.getInstance();
    orgName = shareprefs.getString('organizationName');

    setState(() {
      orgName = shareprefs.getString('organizationName');
    });
    if (orgName == null) {
      showorganizationDialogbox();
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
            child: Text("Submit", style: TextStyle(color: txtcolor),),
          ),
        ],
      )
     );
  }
  Future<void> fetchTeamNames() async {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    List<String> teamnm = [];
    try {
      final teamRef = FirebaseFirestore.instance
          .collection('Team Task')
          .doc('tcs')
          .collection(userEmail!);

      final snapshot = await teamRef.get();

      if (snapshot.docs.isEmpty) {
        print('No teams found for: $userEmail');
      } else {
        for (var doc in snapshot.docs) {
          print('Team ID: ${doc.id}');
          teamnm.add(doc.id);
          //print('Data: ${doc.data()}');
        }
      }
      setState(() {
        teamNames=teamnm;
        print("teams $teamNames");
        isLoading = false;
      });
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
            child: Text(
              "No organizations yet.",
              style: TextStyle(color: txtcolor),
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
                      Text("$orgName",style: TextStyle(color: btncolor,fontWeight: FontWeight.bold,fontSize: 20),),
                      Container(height: 5,),
                      Text("Teams Found for $orgName organization",style: TextStyle(color: textColor2,fontSize: 15),),

                      /*FutureBuilder<List<Map<String, dynamic>>>(
                        future: _teamsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          }

                          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(child: Text('No team found.'));
                          }

                          final teams = snapshot.data!;

                          return ListView.builder(
                            shrinkWrap: true, // 🔑 Add this
                            physics: NeverScrollableScrollPhysics(), // 🔑 Add this to disable scroll conflict
                            itemCount: teams.length,
                            itemBuilder: (context, index) {
                              final team = teams[index];
                              return Card(
                                margin: const EdgeInsets.all(10),
                                child: ExpansionTile(
                                  title: Text(
                                    team['teamName'],
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  children: team['members'].map<Widget>((member) {
                                    return ListTile(
                                      leading: const Icon(Icons.person),
                                      title: Text(member),
                                    );
                                  }).toList(),
                                ),
                              );
                            },
                          );
                        },
                      ),*/

                      isLoading
                          ? Center(child: CircularProgressIndicator())
                          : teamNames.isEmpty
                          ? Center(child: Text('No teams found.',style: TextStyle(color:txtcolor),))
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
                                                        MaterialPageRoute(builder: (context)=>TeamDetails(teamNames[index]))
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
      floatingActionButton: SizedBox(
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
}


