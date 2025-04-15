
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';

class TeamDetails extends StatefulWidget{
  String teamname;
  TeamDetails(this.teamname);

  @override
  State<TeamDetails> createState() => _TeamDetailsState();
}

class _TeamDetailsState extends State<TeamDetails> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: bgcolor,
    );
  }
}