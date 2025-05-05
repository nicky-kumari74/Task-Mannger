import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/CreateOrg.dart';
import 'package:taskmanager/JoinOrg.dart';
import 'package:taskmanager/PersonalScreen.dart';
import 'package:taskmanager/SendInvitation.dart';
import 'package:taskmanager/TeamScreen.dart';

import 'package:taskmanager/loginScreen.dart';
class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String userName = "loading.."; // Default text while loading
  String userEmail = "loading..";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    var sharepref= await SharedPreferences.getInstance();
    setState(() {
      userName = sharepref.getString("name")?? "loading..."; // Default name
      userEmail = sharepref.getString("email") ?? "loading.."; // Default email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      /*appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 30,
        backgroundColor: bgcolor,
      ),*/
        drawer: Drawer(
          child: Container(
            color: inputBoxbgColor,
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: bgcolor, // ⚫ Set black background for account section
                  ),
                  child:Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white,
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : "N",
                      style: TextStyle(fontSize: 25, color: bgcolor),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(userName, style: TextStyle(fontWeight: FontWeight.bold, color: txtcolor,fontSize: 20),),
                    ],
                  ),
                  Row(
                    children: [
                      Text(userEmail, style: TextStyle(color: txtcolor,fontSize: 17),),
                    ],
                  ),
                ],
              ),
            ),),
                ListTile(
                  leading: Icon(Icons.group_add,color: btncolor,),
                  title: Text('Create Team',style: TextStyle(color: btncolor),),
                  onTap: () async {
                    final teamref = FirebaseFirestore.instance.collection(
                        'Personal Task').doc(userEmail).collection(
                        "organization");
                    final snapshot = await teamref.get();
                    if (snapshot.docs.isEmpty) {
                      print('Something went wrong');
                      showDialogbox("Please create or join organization to Make Team.....");
                    }
                    else {
                      var orgName;
                      for (var doc in snapshot.docs) {
                        orgName = doc.id;
                      }
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => sendInvitation(orgName: orgName ?? "njk"),),
                      );
                    }
                  }
                ),
                /*ListTile(
                  leading: Icon(Icons.group,color: txtcolor,),
                  title: Text('Join Team',style: TextStyle(color: txtcolor)),
                  onTap: () => print('Join Team tapped'),
                ),*/
                ListTile(
                  leading: Icon(Icons.apartment,color: btncolor,),
                  title: Text('Join Organization',style: TextStyle(color: btncolor)),
                  onTap: () => {JoinOrg.showCustomAlertDialog(context: context)},
                ),
                ListTile(
                  leading: Icon(Icons.apartment,color: btncolor,),
                  title: Text('Create Organization',style: TextStyle(color: btncolor)),
                  onTap: () => {createOrg()},
                ),
                ListTile(
                  leading: Icon(Icons.help,color: btncolor,),
                  title: Text('Help',style: TextStyle(color: btncolor)),
                  onTap: () => print('Help tapped'),
                ),
                ListTile(
                  leading: Icon(Icons.settings,color: btncolor,),
                  title: Text('Settings',style: TextStyle(color: btncolor)),
                  onTap: () => print('Settings tapped'),
                ),
                ListTile(
                  leading: Icon(Icons.logout,color: btncolor,),
                  title: Text('Logout',style: TextStyle(color: btncolor)),
                  onTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool("login", false);
                    prefs.remove("organizationName");
                    prefs.remove("name");
                    prefs.remove("email");
                    signOut(context);
                    /*Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );*/
                  },
                ),
                //Divider(),
              ],
            ),
          ),
        ),

        backgroundColor: bgcolor,

      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              Container(
                height: 115,
                color: bgcolor,
                padding: EdgeInsets.only(top: 30,bottom: 10),
                child: Row(
                  children: [
                    /// 🟡 Drawer Icon
                    Builder(
                      builder: (context) => IconButton(
                        icon: Icon(Icons.menu, color: btncolor,size: 30,),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),

                    //SizedBox(width: 10),

                    Expanded(
    child: PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Theme(
    data: Theme.of(context).copyWith(
    tabBarTheme: TabBarTheme(
    dividerColor: Colors.transparent, // Removes thin white line
    ),
    ),
                      child: TabBar(
                        physics: const ClampingScrollPhysics(),
                        unselectedLabelColor: btncolor,
                        labelColor: Colors.black,
                        indicatorSize: TabBarIndicatorSize.label,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: btncolor,
                        ),
                        tabs: [
                          Tab(
                            child: Container(
                              height: 40,
                              //width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: btncolor, width: 1),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Personal",style: TextStyle(fontSize: 15),),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(color: btncolor, width: 1),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Team",style: TextStyle(fontSize: 15)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      ),),)
                  ],
                ),
              ),

              /// 🟡 TabBarView Section
              Expanded(
                child: TabBarView(
                  children: [
                    PersonalTask(),
                    TeamTask(),
                    //MyTeamScreen()
                  ],
                ),
              ),
            ],
          ),
        )

    );

  }

  void showDialogbox(String text) {
    showDialog(context: context,
        builder: (BuildContext context){
      return AlertDialog(backgroundColor: inputBoxbgColor,
        //title: Text("organization not created"),
        content: Text(text,style: TextStyle(color: txtcolor,fontSize: 18),),
        actions: [
          TextButton(
              onPressed: (){Navigator.of(context).pop();},
              child: Text("Ok",style: TextStyle(color: btncolor,fontSize: 20),))
        ],
      );
        });
  }

  createOrg() async {
    final shareprefs = await SharedPreferences.getInstance();
    String? email=shareprefs.getString("email");
    final teamref=FirebaseFirestore.instance.collection('Personal Task').doc(email).collection("organization");
    final snapshot = await teamref.get();
    if (snapshot.docs.isEmpty) {
      CreateOrg.showCustomAlertDialog(context: context);
    }
    else{
      showDialogbox("You have already in Organization");
    }
  }
}

Future<void> signOut(BuildContext context) async {
  try {
    var sharepref= await SharedPreferences.getInstance();
    var google=sharepref.getBool("google");
    if(google==true){
      sharepref.remove("google");
      final googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect(); // Optional: to remove access completely
      await googleSignIn.signOut();
    }
    else
    await FirebaseAuth.instance.signOut(); // Sign out from Firebase
    /*final googleSignIn = GoogleSignIn();
    await googleSignIn.disconnect(); // Optional: to remove access completely
    await googleSignIn.signOut();*/
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  } catch (error) {
    print("Error signing out: $error");
  }
}