import 'package:flutter/material.dart';
class Dashboard extends StatelessWidget{

  var Email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:Scaffold(
          appBar: AppBar(
            title: Text('Task Manager'),
            backgroundColor: Colors.indigoAccent, // change color for better experience
            bottom: TabBar(
                tabs: [
                  Tab(text: 'tab1',icon: Icon(Icons.access_time_filled),),
                  Tab(text: 'tab2',icon: Icon(Icons.access_time_filled),),
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
                Center(child: Text('Tab 1 content'),),
                Center(child: Text('Tab 2 content'),)
              ]
          ),
        )
    );

  }

}