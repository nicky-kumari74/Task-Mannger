import 'package:flutter/material.dart';

class TeamTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Text('Team task')
              ),
              ElevatedButton(
                onPressed: () => print('hello'),
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15),
                  backgroundColor: Colors.blue,
                ),
                child: Icon(Icons.add, color: Colors.white,size: 40,),
              ),

            ],
          ),
        ),
    );
  }
}