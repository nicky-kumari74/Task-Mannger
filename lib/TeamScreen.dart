import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import "package:mailer/mailer.dart";
//import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/AddTeamTask.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/SendInvitation.dart';
import 'package:taskmanager/ShowTeamName.dart';
import 'package:taskmanager/TeamMembersScreen.dart';

class TeamTask extends StatefulWidget{
  @override
  State<TeamTask> createState() => _TeamTaskState();
}

class _TeamTaskState extends State<TeamTask> with SingleTickerProviderStateMixin {

  String? organizationName;
  bool dialogShown = false;
  String? creatorEmail;
  String? orgName;

  @override
  void initState() {
    super.initState();
    loadOrgName(); // load teams when app starts
    checkAndShowDialogbox();
    creatorEmail = FirebaseAuth.instance.currentUser?.email;
  }

  //Function to load Teams from when app starts
  Future<void> loadOrgName() async {
    final shareprefs = await SharedPreferences.getInstance();
    setState(() {
      orgName = shareprefs.getString('organizationName');
    });
  }


  // Function to check dialog box is open or not

  Future<void> checkAndShowDialogbox() async {
    SharedPreferences shareprefes = await SharedPreferences.getInstance();
    bool shown = shareprefes.getBool('orgDialogShown') ?? false;
    if (!shown && organizationName ==null) {
      String? orgName = await showorganizationDialogbox();
      if (orgName != null && orgName.isNotEmpty) {
        await addOrganizatioinName(orgName);
        Navigator.push(context, MaterialPageRoute(builder: (context) => sendInvitation(orgName: orgName,)),
        );
      }
      await shareprefes.setBool(("orgDialogShown"), true);
    }
  }

  // Function to add Organization Name

  Future<void> addOrganizatioinName(String name) async {
    if (organizationName != null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              "Limit Reached!! You can only add up to 1 organizations"))
      );
      return;
    }

    //final String creatorEmail = FirebaseAuth.instance.currentUser!.email!;

    setState(() {
      organizationName = name;
    });
    SharedPreferences shaerpref = await SharedPreferences.getInstance();
    await shaerpref.setString("organizationName", organizationName!);
  }

  // Function to delete the Organizations

  Future<void> deleteOrganizations() async {
    setState(() {
      organizationName = null;
    });
    SharedPreferences sharepref = await SharedPreferences.getInstance();
    await sharepref.remove('organizationName');
    await sharepref.setBool("orgDialogShown", false);
  }


  Future<String?> showorganizationDialogbox() async {
    TextEditingController organizationController = TextEditingController();

    return await showDialog<String>(
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
                  onPressed: () => showInfoDialogbox(context),
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
                  Navigator.pop(context, userInput);
                },
                child: Text("Submit", style: TextStyle(color: txtcolor),),
              ),
            ],
          ),
    );
  }


  void showInfoDialogbox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgcolor,
          title: Text("Information", style: TextStyle(color: txtcolor),),
          content: Text(
            "If you are not in the organization you put here your name.",
            style: TextStyle(color: txtcolor),),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> handleAddOrganization() async {
    if (organizationName != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can only add 1 organizations. For more Contact to the Admin")),
      );
      return;
    }

    String? orgName = await showorganizationDialogbox();
    if (orgName != null && orgName.isNotEmpty) {
      await addOrganizatioinName(orgName);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => sendInvitation(orgName: orgName,),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: organizationName ==null
          ? Center(child: Text("No organizations yet.", style: TextStyle(color: txtcolor),))
          : Padding(
            padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
            child: Column(
              children: [
                Card(
                    color: inputBoxbgColor,
                    child: ListTile(
                      title: Text(organizationName!, style: TextStyle(color: txtcolor),),
                      //subtitle: Text("Team details will be shown here", style: TextStyle(color: txtcolor)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red,),
                        onPressed: () => deleteOrganizations(),
                      ),

                    ),
                  ),
                SizedBox(height: 14,),
                Text("Teams", style: TextStyle(color: txtcolor, fontSize: 18),),
                /*StreamBuilder(stream: FirebaseFirestore.instance.collection("Team Task").doc(orgName).collection(creatorEmail!)
                    .snapshots(),
                    builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active){
                    if(snapshot.hasData) {
                      final teamdocs = snapshot.data!.docs;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: teamdocs.length,
                          itemBuilder: (context,index) {
                        final teamdata = teamdocs[index].data() as Map<String, dynamic>;
                        final teamName = teamdata["Team Name"] ?? "Unnamed";
                        return Column(
                          children: [
                            Card(
                              child: ListTile(
                                title: Text(teamName, style: TextStyle(color: Colors.black),),
                                trailing: IconButton(
                                  icon: Icon(Icons.arrow_forward_ios, color: inputBoxbgColor,),
                                  onPressed: () => ShowTeamMembers(organizationId: organizationName!, teamName: teamName),
                                ),
                              ),


                             *//* onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTeamMembers(organizationId: organizationName!, teamName: teamname)));
                              },*//*



                            ),
                          ],
                        );
                       }
                      );
                    } else if (snapshot.hasError){
                      return Center(child: Text("${snapshot.hasError.toString()}"),);
                    }
                    else if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    }
                    return Center(child: Text("Something went wrong or no data found."));
                  }
                  else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                    },
                    ),
*/
              ],
            ),
          ),

      floatingActionButton: organizationName == null
      ? SizedBox(
        width: 120,
        height: 40, // desired height
        child: FloatingActionButton.extended(
          onPressed: () {
            handleAddOrganization();
          },
          backgroundColor: btncolor,
          icon: Icon(Icons.add, color: bgcolor, size: 20), // smaller icon
          label: Text(
            'Add Team',
            style: TextStyle(color: bgcolor, fontSize: 15), // smaller text
          ),
        ),
      )
      : null,
    );
  }
}


