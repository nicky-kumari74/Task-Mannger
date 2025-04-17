
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';

class TeamDetails extends StatefulWidget{
  String teamname;
  TeamDetails(this.teamname);

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> with SingleTickerProviderStateMixin {
  List<String> memberNames = [];
  void initState() {
    super.initState();
    fetchMemberEmail();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        //toolbarHeight: 70,
        title: Text('Team Details', style: TextStyle(color: txtcolor, fontSize: 20),),
        iconTheme: IconThemeData(color: txtcolor),
      ),
      body: Text(widget.teamname,style: TextStyle(color: txtcolor, fontSize: 20)),
    );
  }

  void fetchMemberEmail() async {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    try {
      final teamRef = FirebaseFirestore.instance
          .collection('Teams')
          .doc(userEmail)
          .collection('team name').doc('ABC').collection('Members');

      final snapshot = await teamRef.get();

      if (snapshot.docs.isEmpty) {
        print('No teams found for: $userEmail');
      } else {
        for (var doc in snapshot.docs) {
          print('Team ID: ${doc.id}');
          //print('Data: ${doc.data()}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}