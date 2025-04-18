
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
      body: Padding(
          padding: EdgeInsets.only(left: 30,right: 30),
        child: Column(
          children: [
            SizedBox(height: 10),
            Text("Team Name : ${widget.teamname}",style: TextStyle(color: btncolor,fontSize: 20),),
            SizedBox(height: 10),
            Expanded(
                child: //memberNames.isEmpty?Center(child: CircularProgressIndicator(),)
                    ListView.builder(
                  itemCount: memberNames.length,
                    itemBuilder: (context,index){
                    return Card(
                      color: inputBoxbgColor,
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: Icon(Icons.person,color: textColor2,),
                        title: Text(memberNames[index],style: TextStyle(color: txtcolor),),
                      ),
                    );
                    }
                )
            )
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 150,
        height: 40, // desired height
        child: FloatingActionButton.extended(
          onPressed: () {
            //handleAddOrganization();
          },
          backgroundColor: btncolor,
          icon: Icon(Icons.add, color: bgcolor, size: 20), // smaller icon
          label: Text(
            'Assign Task',
            style: TextStyle(color: bgcolor, fontSize: 17), // smaller text
          ),
        ),
      ),
    );
  }

  void fetchMemberEmail() async {
    final String? userEmail = FirebaseAuth.instance.currentUser?.email;
    try {
      final teamRef = FirebaseFirestore.instance
          .collection('Teams')
          .doc(userEmail)
          .collection('team name').doc(widget.teamname).collection('Members');

      final snapshot = await teamRef.get();

      if (snapshot.docs.isEmpty) {
        print('No teams found for: $userEmail');
      } else {
        /*for (var doc in snapshot.docs) {
            memberNames.add(doc.id);
          //print('Team ID: ${doc.id}');
          //print('Data: ${doc.data()}');
        }*/
        setState(() {
          memberNames = snapshot.docs.map((doc) => doc.id).toList();
        });
        print(memberNames);
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}