import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeamNames{
  static Future<List<String>> fetchTeamNames() async{
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

    } catch (e) {
      print('Error fetching teams: $e');

    }
    return teamnm;
  }
}