import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/CreateOrg.dart';
import 'package:taskmanager/JoinOrg.dart';
import 'package:taskmanager/PersonalScreen.dart';
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
    print("hello 1");
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
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: bgcolor, // ⚫ Set black background for account section
                  ),
                  accountName: Text(
                    userName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text on black
                    ),
                  ),
                  accountEmail: Text(
                    userEmail,
                    style: TextStyle(color: Colors.white),
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: Text(
                      userName.isNotEmpty ? userName[0].toUpperCase() : "N",
                      style: TextStyle(fontSize: 25),
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.group_add,color: txtcolor,),
                  title: Text('Create Team',style: TextStyle(color: txtcolor),),
                  onTap: () => print('Create Team tapped'),
                ),
                ListTile(
                  leading: Icon(Icons.group,color: txtcolor,),
                  title: Text('Join Team',style: TextStyle(color: txtcolor)),
                  onTap: () => print('Join Team tapped'),
                ),
                ListTile(
                  leading: Icon(Icons.group,color: txtcolor,),
                  title: Text('Join Organization',style: TextStyle(color: txtcolor)),
                  onTap: () => {JoinOrg.showCustomAlertDialog(context: context)},
                ),
                ListTile(
                  leading: Icon(Icons.group,color: txtcolor,),
                  title: Text('Create Organization',style: TextStyle(color: txtcolor)),
                  onTap: () => {CreateOrg.showCustomAlertDialog(context: context)},
                ),
                ListTile(
                  leading: Icon(Icons.help,color: txtcolor,),
                  title: Text('Help',style: TextStyle(color: txtcolor)),
                  onTap: () => print('Help tapped'),
                ),
                ListTile(
                  leading: Icon(Icons.settings,color: txtcolor,),
                  title: Text('Settings',style: TextStyle(color: txtcolor)),
                  onTap: () => print('Settings tapped'),
                ),
                ListTile(
                  leading: Icon(Icons.logout,color: txtcolor,),
                  title: Text('Logout',style: TextStyle(color: txtcolor)),
                  onTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    prefs.setBool("login", false);
                    prefs.remove("organizationName");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
                Divider(),
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