/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class showTeamMembers extends StatelessWidget {
  final List<String> teamMembers;

  showTeamMembers({super.key, required this.teamMembers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: teamMembers.length, itemBuilder: (context, index) {
        return Dismissible(key: Key(teamMembers[index]),    // Unique key for each item
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
           // deleteTeam(index);    // Call delete function.
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${teamMembers[index]} deleted')),
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
                  title: Text(teamMembers[index], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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

}*/


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowTeamMembers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Screen"),
        backgroundColor: Colors.blue,
      ),
    );
  }

}