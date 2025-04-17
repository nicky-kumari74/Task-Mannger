/*
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseTestScreen(),
    );
  }
}

class FirebaseTestScreen extends StatelessWidget {
  void testFirebase() async {
    try {
      print("Testing Firebase Authentication...");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "testuser@gmail.com",
        password: "Test@1234",
      );
      print("✅ Firebase Connection Successful! Registered: ${userCredential.user?.email}");
    } catch (e) {
      print("❌ Firebase Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firebase Test")),
      body: Center(
        child: ElevatedButton(
          onPressed: testFirebase,
          child: Text("Test Firebase Connection"),
        ),
      ),
    );
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamService {
  static Future<List<Map<String, dynamic>>> fetchTeamsAndMembers() async {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    List<Map<String, dynamic>> teams = [];
    /*try {
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
          //print('Data: ${doc.data()}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }*/
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
          print('Data: ${doc.data()}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }

    /*QuerySnapshot taskSnapshot = await FirebaseFirestore.instance
        .collection('Teams')
        .where('email', isEqualTo: userEmail)
        .get();

    print("📄 Found ${taskSnapshot.docs.length} matching org(s)");

    if (taskSnapshot.docs.isEmpty) return teams;

    for (var orgDoc in taskSnapshot.docs) {
      final orgId = orgDoc.id;
      print("🏢 Org Doc: $orgId");

      DocumentReference taskDocRef = orgDoc.reference;

      QuerySnapshot teamsSnapshot = await taskDocRef.collection(userEmail!).get();
      print("👥 Found ${teamsSnapshot.docs.length} team(s) under $orgId");

      for (var teamDoc in teamsSnapshot.docs) {
        String teamName = teamDoc.id;
        print("🔹 Team: $teamName");

        QuerySnapshot membersSnapshot =
        await teamDoc.reference.collection('Members').get();

        List<String> members =
        membersSnapshot.docs.map((doc) => doc.id.toString()).toList();

        print("  ↳ Members: $members");

        teams.add({
          'teamName': teamName,
          'members': members,
        });
      }
    }*/

    /*if (taskSnapshot.docs.isEmpty) return teams;
    // Step 1: Get user-specific doc in 'Team Task'
    for (var orgDoc in taskSnapshot.docs) {
      final orgId = orgDoc.id;
      print("🏢 Org Doc: $orgId");

      DocumentReference taskDocRef = orgDoc.reference;

      QuerySnapshot teamsSnapshot = await taskDocRef.collection(userEmail).get();
      print("👥 Found ${teamsSnapshot.docs.length} team(s) under $orgId");

      for (var teamDoc in teamsSnapshot.docs) {
        String teamName = teamDoc.id;
        print("🔹 Team: $teamName");

        QuerySnapshot membersSnapshot =
        await teamDoc.reference.collection('Members').get();

        List<String> members =
        membersSnapshot.docs.map((doc) => doc.id.toString()).toList();

        print("  ↳ Members: $members");

        teams.add({
          'teamName': teamName,
          'members': members,
        });
      }
    }*/

    return teams;
  }
}
