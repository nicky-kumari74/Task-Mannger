import 'package:flutter/material.dart';
import 'package:taskmanager/AddTeamTask.dart';
import 'package:taskmanager/Colors.dart';

class TeamTask extends StatefulWidget{
  @override
  State<TeamTask> createState() => _TeamTaskState();
}

class _TeamTaskState extends State<TeamTask> with SingleTickerProviderStateMixin {
  List<String> teams = [];    // Dynamic team lists

  @override
  void initState(){
    super.initState();

    //Simulate fetching teams dynamically

    /*Future.delayed(Duration(seconds: 1), (){
      setState(() {
        teams = List.generate(12, (index) => "Team ${index+1}");   //change this dynamically
      });
    });*/
  }

  // Function to create a new team and also invite members in it

 void showAddTeamdialogbox() {
    TextEditingController customTeamname = TextEditingController();
    TextEditingController inviteMembers = TextEditingController();
    showDialog(context: context, builder: (context) {
      return AlertDialog(title: Text("Create New Team"),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,  // This make dialog box width responsive.
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Help to shrink the dialog box height according to content.
            children: [
              TextField(
                controller: customTeamname,
                decoration: InputDecoration(
                  hintText: 'Enter Your Team Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: inviteMembers,
                decoration: InputDecoration(
                  hintText: 'Invite new members in your team',
                  border: OutlineInputBorder(),
                ),
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop((context)),   // close dialog box
              child: Text('Cancel'),
          ),
          TextButton(onPressed: () {
            String newTeam = customTeamname.text.trim();
            if (newTeam.isNotEmpty) {
              setState(() {
                teams.add(newTeam);
              });
              Navigator.pop(context);   // Close dialog box 
            }
          }, child: Text("Create"),
          ),
        ],
      );
    });
 }

  // Function to delete a team
  void deleteTeam(int index) {
    setState(() {
      teams.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      body: TabBarView(
          children: [
            Center(child: Text('Teams Content'),),
            TeamList(teams: teams, deleteTeam : deleteTeam), //Display teams dynamically
          ],
      ),

         floatingActionButton: Container(
           margin: EdgeInsets.only(bottom: 29,right: 140),
           child: FloatingActionButton(
             onPressed: showAddTeamdialogbox,
             hoverColor: Colors.blueGrey,
             shape: CircleBorder(),
             backgroundColor: Colors.blue,
           child: Icon(Icons.add),
           ),
         ),

    );
  }
}


class TeamList extends StatelessWidget {
  final List<String> teams;
  final Function(int) deleteTeam;
  TeamList({required this.teams, required this.deleteTeam});
  @override
  Widget build(BuildContext context) {
    return teams.isEmpty ? Center(child: Text("No team yet. Click + to add one!", style: TextStyle(fontSize: 16),),)
        : Padding(padding: const EdgeInsets.all(10),
    child: ListView.builder(
      itemCount: teams.length, itemBuilder: (context, index) {
        return Dismissible(key: Key(teams[index]),    // Unique key for each item
         direction: DismissDirection.endToStart,
         onDismissed: (direction) {
          deleteTeam(index);    // Call delete function.
          ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${teams[index]} deleted')),
      );
      },
        background: Container(
      color: Colors.red,
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      child: Icon(Icons.delete, color: Colors.white,),
      ),
         child: Container(
           margin: EdgeInsets.all(8),  // help to adjust the card view on the screen.
           child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            margin: EdgeInsets.symmetric(vertical: 9),
            child: Container( 
              padding: EdgeInsets.all(10),
              height: 70,
              child: ListTile(
                title: Text(teams[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward_ios,size: 16, color: Colors.grey,),
                onTap: () {
                  // Function will be here when click on the teams
                },
              ),
            ),
           ),
         ),
        );
    },
    ),
    );
  }

}
