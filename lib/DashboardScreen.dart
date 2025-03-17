import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/PersonalScreen.dart';
import 'package:taskmanager/TeamScreen.dart';
class Dashboard extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            toolbarHeight: 50,
            title: Text('Task Manager',
              style: TextStyle(color: Colors.white),),
            backgroundColor: appbarcolor, // change color for better experience
            bottom: TabBar(
              labelColor: Colors.white,
                indicatorColor: Colors.white,
              unselectedLabelColor: Colors.blueGrey,
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
                  leading: Icon(Icons.ac_unit_sharp),
                  title: Text('Logout'),
                  onTap: ()=>print('hello'),
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