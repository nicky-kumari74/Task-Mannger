import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/PersonalScreen.dart';
import 'package:taskmanager/TeamScreen.dart';
import 'package:taskmanager/loginScreen.dart';
class Dashboard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            toolbarHeight: 30,
            /*title: Text('Task Manager',
              style: TextStyle(color: Colors.white,fontSize: 0),),*/
            backgroundColor:bgcolor, // change color for better experience
            /*flexibleSpace: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40),bottomRight: Radius.circular(40)),
                //borderRadius: BorderRadius.all(Radius.circular(30)),
                gradient: LinearGradient(colors: [Color(0xFF9370DB),Color(0xFFBEA1E4)],
                begin: Alignment.bottomCenter,
                  end: Alignment.topCenter
                )
              ),
            ),*/
            /*bottom: TabBar(
              labelColor: Colors.white,
                indicatorColor: Colors.white,
              unselectedLabelColor: Colors.black54,
                tabs: [
                  Tab(text: 'Personal',  icon: Icon(Icons.access_time_filled,), ),
                  Tab(text: 'Team',icon: Icon(Icons.access_time_filled,),),
                ]
            ),*/
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
                  leading: Icon(Icons.ac_unit_sharp),
                  title: Text('Logout'),
                  onTap: () async {
                    var sharepref = await SharedPreferences.getInstance();
                    sharepref.setBool("login", false);// Set to false for logout
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your LoginPage widget
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
                  margin: EdgeInsets.only(top: 10),
                  color: bgcolor,
                  child: TabBar(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.only(top:55, left: 10, right: 10),

                    unselectedLabelColor: btncolor,
                    labelColor: Colors.black,
                    indicatorColor: Colors.transparent, // Ensure no extra line appears
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

          /*body: TabBarView(
              children:[
                PersonalTask(),
                TeamTask(),
              ]
          ),*/

    );

  }

}