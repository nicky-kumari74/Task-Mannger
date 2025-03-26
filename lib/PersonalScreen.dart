import 'package:flutter/material.dart';
import 'package:taskmanager/AddPersonalTask.dart';
import 'package:taskmanager/Colors.dart';

class PersonalTask extends StatelessWidget {
  List<String> item = <String>['Task Name A', 'Task Name B', 'Task Name C','Task A', 'Task B', 'Task C','Task A', 'Task B', 'Task C'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200], // Assuming a background color
        body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.builder(
                  //padding: EdgeInsets.only(top: 50), // Adjust padding as needed
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.only(top: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            Row(children: [Text('${item[index]}',style: TextStyle(fontWeight: FontWeight.bold,color: txtcolor),),]),
                            Row(children: [
                              Icon(Icons.date_range,color: Colors.black54,size: 18,),
                              Text('6/10/2024',style: TextStyle(color: Colors.black),),
                              Container(width: 20,),
                              Icon(Icons.access_time,color: Colors.black54,size: 18,),
                              Text('5:30',style: TextStyle(color: Colors.black)),
                              Container(width: 40,),
                              ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      //backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                      minimumSize: Size(80, 25),// Increased button size
                                    ),
                                    child: Text('Pending', style: TextStyle(fontSize: 12, color: Colors.red)), // Increased font size
                                  ),
                            ]),
                          ],
                        ),
                      ),
                    );

                  },
                ),
              ),
              Positioned(
                bottom: 40, // Adjust position as needed
                right: 20,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddPersonalTask()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    elevation: 10,
                    shadowColor: Colors.blueGrey,
                    padding: EdgeInsets.all(10),
                    backgroundColor: btncolor, // Assuming a button color
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 30),
                ),
              ),
            ],
            ),
    );
  }
}