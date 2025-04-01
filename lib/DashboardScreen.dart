import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
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
      userName = sharepref.getString("name") ?? "Nicky"; // Default name
      userEmail = sharepref.getString("email") ?? "bhagat@gmail.com"; // Default email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        toolbarHeight: 30,
        backgroundColor: bgcolor,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(userName,style: TextStyle(fontWeight: FontWeight.bold),),
              accountEmail: Text(userEmail),
              currentAccountPicture: CircleAvatar(
                child: Text(userName.isNotEmpty ? userName[0].toUpperCase() : "N",style: TextStyle(fontSize: 25),),
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Create Team'),
              onTap: () => print('Create Team tapped'),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Join Team'),
              onTap: () => print('Join Team tapped'),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () => print('Help tapped'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => print('Settings tapped'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () async {
                var prefs = await SharedPreferences.getInstance();
                prefs.setBool("login", false); // Set to false for logout
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
      backgroundColor: bgcolor,
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 100,
              margin: EdgeInsets.only(top: 20),
              color: bgcolor,
              child: TabBar(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(top: 55, left: 10, right: 10),
                unselectedLabelColor: btncolor,
                labelColor: Colors.black,
                indicatorColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: btncolor,
                ),
                tabs: [
                  Tab(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: btncolor, width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Personal"),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: btncolor, width: 1),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Team"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  PersonalTask(),
                  TeamTask(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
