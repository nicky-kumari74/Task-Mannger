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
  List<String> teams = []; // Dynamic team lists
  List<String> organizationLists = [];
  String? organizationName;
  bool dialogShown = false;

  @override
  void initState() {
    super.initState();
    loadOrganization(); // load teams when app starts
    checkAndShowDialogbox();
  }

  //Function to load Teams from when app starts
  Future<void> loadOrganization() async {
    SharedPreferences shareprefs = await SharedPreferences.getInstance();
    setState(() {
      organizationLists = shareprefs.getStringList('organizations') ?? [];
    });
  }


  // Function to check dialog box is open or not

  Future<void> checkAndShowDialogbox() async {
    SharedPreferences shareprefes = await SharedPreferences.getInstance();
    bool shown = shareprefes.getBool('orgDialogShown') ?? false;
    if (!shown) {
      String? orgName = await showorganizationDialogbox();
      if (orgName != null && orgName.isNotEmpty) {
        addOrganizatioinName(orgName);
        Navigator.push(context, MaterialPageRoute(builder: (context) => sendInvitation()),
        );
      }
      await shareprefes.setBool(("orgDialogShown"), true);
    }
  }

  // Function to add Organization Name

  Future<void> addOrganizatioinName(String name) async {
    if (organizationLists.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              "Limit Reached!! You can only add up to 5 organizations"))
      );
      return;
    }
    setState(() {
      organizationLists.add(name);
    });
    SharedPreferences shaerpref = await SharedPreferences.getInstance();
    await shaerpref.setStringList("organizations", organizationLists);
  }

  // Function to delete the Organizations

  Future<void> deleteOrganizations(int index) async {
    setState(() {
      organizationLists.removeAt(index);
    });
    SharedPreferences sharepref = await SharedPreferences.getInstance();
    await sharepref.setStringList("organizations", organizationLists);
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
    if (organizationLists.length >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can only add up to 5 organizations. For more Contact to the Admin")),
      );
      return;
    }

    String? orgName = await showorganizationDialogbox();
    if (orgName != null && orgName.isNotEmpty) {
      await addOrganizatioinName(orgName);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => sendInvitation(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: organizationLists.isEmpty
          ? Center(child: Text("No organizations yet."))
          : ListView.builder(
        itemCount: organizationLists.length,
        itemBuilder: (context, index) => Card(
              color: inputBoxbgColor,
              child: ListTile(
                title: Text(organizationLists[index], style: TextStyle(color: txtcolor),),
                subtitle: Text("Team details will be shown here", style: TextStyle(color: txtcolor)),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red,),
                  onPressed: () => deleteOrganizations(index),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowTeamMembers(orgName: organizationLists[index],))
                  );
                },
              ),
            ),
      ),

      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 29, right: 140),
        child: FloatingActionButton(
          onPressed: handleAddOrganization,
          shape: CircleBorder(),
          backgroundColor: btncolor,
          child: Icon(Icons.add),
        ),
      ),

    );
  }
}




/*  Column(
        children: [
      Center(child: Text('No Organization yet', style: TextStyle(color: txtcolor),),),
          //Expanded(child: TeamList(teams: teams, deleteTeam : deleteTeam)), //Display teams dynamically
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: inputBoxbgColor,
              child: ListTile(
                title: Text( "Organization Name: ",
                  style: TextStyle(fontSize: 15, color: txtcolor, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Team Details will be shown here. ", style: TextStyle(color: txtcolor),),
                trailing: Icon(Icons.arrow_forward_ios),
              ),

            ),

          ),
        ],
      ),*/

/*
class TeamList extends StatelessWidget {
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

