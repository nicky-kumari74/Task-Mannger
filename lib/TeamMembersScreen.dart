/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showTeamMembers extends StatelessWidget {
  final List<String> teamMembers;

  showTeamMembers({super.key, required this.teamMembers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: teamMembers.length, itemBuilder: (context, index) {
        return Dismissible(key: Key(teamMembers[index]),    // Unique key for each item
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
           // deleteTeam(index);    // Call delete function.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${teamMembers[index]} deleted')),
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
                  title: Text(teamMembers[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    // Function will be here when click on the teams
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


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/SendInvitation.dart';

class ShowTeamMembers extends StatelessWidget {
  final String orgName;
  ShowTeamMembers({required this.orgName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text(" $orgName", style: TextStyle(color: txtcolor),),
        iconTheme: IconThemeData(color: txtcolor),
        backgroundColor: bgcolor,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder <DocumentSnapshot>
              (stream: FirebaseFirestore.instance.collection("teams").doc(orgName).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }

              // Check if the document exists
              if (!snapshot.data!.exists) {
                return Center(
                  child: Text("No data found for $orgName yet.",
                  style: TextStyle(color: txtcolor),
                  ),
                );
              }
              List<dynamic> emails = snapshot.data!.get("emails") ?? [];
              if (emails.isEmpty) {
                return Center(
                  child: Text("No team members yet.", style: TextStyle(color: txtcolor),),
                );
              }
              return ListView.builder(
                  itemCount: emails.length,
                  itemBuilder:(context, index) => Card(
                    color: inputBoxbgColor,
                    child: ListTile(
                      title: Text(emails[index], style: TextStyle(color: txtcolor),),
                    ),
                  )
              );
            }
            ),
          ),
          Padding(padding: EdgeInsets.all(18),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => sendInvitation())
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: btncolor),
                child: Text("Invite Members", style: TextStyle(color: txtcolor),)
            ),
          )
        ],
      ),
      
    );
  }

}