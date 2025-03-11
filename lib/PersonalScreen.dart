import 'package:flutter/material.dart';

class PersonalTask extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Column(
              children: [
                Center(
                    child: Text('personal task')
                ),
                Container(
                    margin: EdgeInsets.only(left: 300,top: 400),
                  child: ElevatedButton(
                        onPressed: () => print('hello'),
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: Colors.blue,
                        ),
                        child: Icon(Icons.add, color: Colors.white,size: 40,),
                      ),
                ),
              ],
            ),
          ),
    );
  }
}