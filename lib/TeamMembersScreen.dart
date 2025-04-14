/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/SendInvitation.dart';

class ShowTeamMembers extends StatefulWidget {
  final String orgName;
  ShowTeamMembers({required this.orgName});

  @override
  State<ShowTeamMembers> createState() => _ShowTeamMembersState();
}

class _ShowTeamMembersState extends State<ShowTeamMembers> {

  String? creatorEmail;
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if(user != null) {
      creatorEmail = user.email;
      setState(() {

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text(" ${widget.orgName}", style: TextStyle(color: txtcolor),),
        iconTheme: IconThemeData(color: txtcolor),
        backgroundColor: bgcolor,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection("Team Task").doc(widget.orgName).
            collection("Creator Email").doc(creatorEmail).collection("Teams").doc("Your Team Name").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }

              // Check if the document exists
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(
                  child: Text("No data found for ${widget.orgName} yet.",
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
                  itemBuilder:(context, index)
              {
                final email = emails[index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Card(
                    color: inputBoxbgColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11)
                    ),
                    child: ListTile(
                      title: Text(email, style: TextStyle(color: txtcolor),),
                    ),
                  ),
                );
              },
            );
              }
            ),
          ),
          Padding(padding: EdgeInsets.all(18),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => sendInvitation(orgName: widget.orgName,))
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
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowTeamMembers extends StatefulWidget {
  final String organizationId;
  final String teamName;

  const ShowTeamMembers({
    required this.organizationId,
    required this.teamName,
  });

  @override
  State<ShowTeamMembers> createState() => _Screen3State();
}

class _Screen3State extends State<ShowTeamMembers> {
  @override
  Widget build(BuildContext context) {
    final membersRef = FirebaseFirestore.instance
        .collection('Team Task')
        .doc('Organization')
        .collection(widget.organizationId)
        .doc(widget.teamName)
        .collection('members');

    return Scaffold(
      appBar: AppBar(title: Text(widget.teamName)),
      body: StreamBuilder<QuerySnapshot>(
        stream: membersRef.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final docs = snapshot.data!.docs;

          if (docs.isEmpty) return Center(child: Text("No members added"));

          return ListView(
            children: docs.map((doc) {
              final email = doc['email'];
              return ListTile(
                title: Text(email),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        _showEditDialog(context, doc.id, email, membersRef);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        membersRef.doc(doc.id).delete();
                      },
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  void _showEditDialog(BuildContext context, String docId, String oldEmail, CollectionReference membersRef) {
    final controller = TextEditingController(text: oldEmail);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Edit Email"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("Save"),
            onPressed: () {
              membersRef.doc(docId).update({'email': controller.text});
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
