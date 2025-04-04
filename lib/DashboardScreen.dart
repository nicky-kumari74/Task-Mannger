import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/PersonalScreen.dart';
import 'package:taskmanager/TeamScreen.dart';
import 'package:taskmanager/loginScreen.dart';
class Dashboard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            toolbarHeight: 30,
            title: Text('Task Manager',
              style: TextStyle(color: Colors.white,fontSize: 0),),
            backgroundColor:Colors.transparent, // change color for better experience
            elevation: 0.0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                //borderRadius: BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(colors: [Color(0xFF9370DB),Color(0xFFBEA1E4)],
                begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
            ),
            bottom: TabBar(
              labelColor: Colors.white,
                indicatorColor: Colors.white,
              unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: 'Personal',  icon: Icon(Icons.access_time_filled,), ),
                  Tab(text: 'Team',icon: Icon(Icons.access_time_filled,),),
                ]
            ),
          ),
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                    accountName:Text('Nicky'), 
                    accountEmail: Text('bhagatnicky@gmail.com'),
                   currentAccountPicture: CircleAvatar(child: Text('N'),backgroundColor: Colors.white,),

                ),
                ListTile(
                  leading: Icon(Icons.ac_unit_sharp),
                  title: Text('Create Team'),
                  onTap: ()=>print('hello'),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit_sharp),
                  title: Text('Join Team'),
                  onTap: ()=>print('hello'),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit_sharp),
                  title: Text('Help'),
                  onTap: ()=>print('hello'),
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit_sharp),
                  title: Text('Setting'),
                  onTap: ()=>print('hello'),
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.red),
                  title: Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  onTap: () => signOut(context), // Call the logout function
                ),
                Divider(),
              ],
            ),
          ),
          body: TabBarView(
              children:[
                PersonalTask(),
                TeamTask(),
              ]
          ),
        )
    );

  }

}

Future<void> signOut(BuildContext context) async {
  try {
   // await GoogleSignIn().signIn(); // Sign out from Google
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase

    // Navigate to Login Screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  } catch (error) {
    print("Error signing out: $error");
  }
}