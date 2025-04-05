import 'package:flutter/material.dart';
//import "package:mailer/mailer.dart";
//import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/AddTeamTask.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/SendInvitation.dart';
import 'package:taskmanager/TeamMembersScreen.dart';

class TeamTask extends StatefulWidget{
  @override
  State<TeamTask> createState() => _TeamTaskState();
}

class _TeamTaskState extends State<TeamTask> with SingleTickerProviderStateMixin {
  List<String> teams = [];    // Dynamic team lists

  @override
  void initState(){
    super.initState();
    loadOrganization(); // load teams when app starts
    //showorganizationDialogbox();
    //getOrganization();
    Future.delayed(Duration.zero, () {
      showorganizationDialogbox();
    });
  }
  //Function to load Teams from when app starts
  Future<void> loadOrganization() async {
    SharedPreferences shareprefs = await SharedPreferences.getInstance();
    setState(() {
      teams = shareprefs.getStringList('teams') ?? [];
    });
  }

  // Function to save Teams to SharedPreferences.
/*
  Future<void> saveTeams() async {
    SharedPreferences shareprefes = await SharedPreferences.getInstance();
    await shareprefes.setStringList('teams', teams);
  }
*/

  // Function to create a new team and also invite members in it
/*
 void showAddTeamdialogbox() {
    TextEditingController customTeamname = TextEditingController();
    TextEditingController inviteMembers = TextEditingController();
    showDialog(context: context, builder: (context) {
      return AlertDialog(title: Text("Create New Team"),

        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,  // This make dialog box width responsive.
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Help to shrink the dialog box height according to content.
            children: [
              TextField(
                controller: customTeamname,
                decoration: InputDecoration(
                  hintText: 'Enter Your Team Name',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),

              SizedBox(height: 20,),
              TextField(
                controller: inviteMembers,
                decoration: InputDecoration(
                  hintText: 'Enter Email ID ',
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop((context)),   // close dialog box
              child: Text('Cancel'),
          ),
          TextButton(onPressed: () {
            String newTeam = customTeamname.text.trim();
            String email = inviteMembers.text.trim();
            if (newTeam.isNotEmpty) {
              setState(() {
                teams.add(newTeam);
                saveTeams();
              });
              
              if (email.isNotEmpty) {
                //sendInvitationEmail(email);
              }
              Navigator.pop(context);   // Close dialog box
            }
          }, child: Text("Create"),
          ),
        ],
      );
    });
 }
*/

  // Function to delete a team
 /* void deleteTeam(int index) {
    setState(() {
      teams.removeAt(index);
      saveTeams();    //save after deleting
    });
  }*/



void showorganizationDialogbox() {
  TextEditingController organizationController = TextEditingController();

  showDialog(
      context: context,
      barrierDismissible: false,     // Prevent closing by tapping outside
      builder: (context) {
    return AlertDialog(
      backgroundColor: boxColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Organization or Name", style: TextStyle(fontSize: 18, color: bgcolor),),
          IconButton(
              onPressed: () {
            showInfoDialogbox(context);
          }, icon: Icon(Icons.info_outline, color: bgcolor,)),

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
        TextButton(onPressed: () {
          Navigator.pop(context);
        }, child: Text("Cancel",  style: TextStyle(color: bgcolor))
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: btncolor),
          onPressed: () async {
            String userInput = organizationController.text.trim();
            var sharepref = await SharedPreferences.getInstance();
            sharepref.setString("organization", userInput);
            print("User Input: $userInput");
            Navigator.pop(context);
          },
          child: Text("Submit", style: TextStyle(color: txtcolor),),
        ),

      ],
    );
  });
}

  void showInfoDialogbox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgcolor,
          title: Text("Information", style: TextStyle(color: txtcolor),),
          content: Text("If you are not in the organization you put here your name.", style: TextStyle(color: txtcolor),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: Column(
          children: [
            Center(child: Text('No Teams yet', style: TextStyle(color: txtcolor),),),
            //Expanded(child: TeamList(teams: teams, deleteTeam : deleteTeam)), //Display teams dynamically
          ],
      ),

         floatingActionButton: Container(
           margin: EdgeInsets.only(bottom: 29,right: 140),
           child: FloatingActionButton(
             onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => sendInvitation()));
             },
             shape: CircleBorder(),
             backgroundColor: btncolor,
           child: Icon(Icons.add),
           ),
         ),

    );
  }

  Future<void> getOrganization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var org=prefs.getString("organization");

  }
}


/*class TeamList extends StatelessWidget {
  final List<String> teams;
  final Function(int) deleteTeam;

  TeamList({required this.teams, required this.deleteTeam});

  @override
  Widget build(BuildContext context) {
    return teams.isEmpty ? Center(child: Text("No team yet. Click + to add one!", style: TextStyle(fontSize: 16, color: Colors.black),),)
        : Padding(padding: const EdgeInsets.all(10),
    child: ListView.builder(
      itemCount: teams.length, itemBuilder: (context, index) {
        return Dismissible(key: Key(teams[index]),    // Unique key for each item
         direction: DismissDirection.endToStart,
         onDismissed: (direction) {
          deleteTeam(index);    // Call delete function.
          ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${teams[index]} deleted')),
      );
      },
        background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.delete, color: Colors.white,),
      ),
         child: Container(
           margin: EdgeInsets.all(8),  // help to adjust the card view on the screen.
           child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            margin: EdgeInsets.symmetric(vertical: 9),
            child: Container( 
              padding: EdgeInsets.all(10),
              height: 70,
              child: ListTile(
                title: Text(teams[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios,size: 16, color: Colors.black,),
                onTap: () {
                   //Navigator.push(context, MaterialPageRoute(builder: (context) => showTeamMembers()));      // Function will be here when click on the teams
                },
              ),
            ),
           ),
         ),
        );
    },
    ),
    );
  }

}*/

