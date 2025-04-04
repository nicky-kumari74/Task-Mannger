import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';

class ForgetPasswdScreen extends StatefulWidget{

  @override
  State<ForgetPasswdScreen> createState() => _ForgetPasswdScreenState();
}

class _ForgetPasswdScreenState extends State<ForgetPasswdScreen> {
  var Email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text('Powering Personal and Team Tasks',
          style: TextStyle(color: Colors.white),),
        backgroundColor: appbarcolor, // change color for better experience
      ),
      backgroundColor: bgcolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          //SizedBox(height: 1,),
          Padding(

            padding: const EdgeInsets.all(20),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: Email,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.black,),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black54, fontSize: 20),    // change font color and size for better experience
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: borderColor, width: 2,)       // color change when user clicked on this widget and change border color for better experience
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.black, width: 2)       // color change when user clicked on this widget and change border color for better experience

                )
              ),
            ),
          ),

          SizedBox(height: 20,),
          ElevatedButton(onPressed: () async {
            if (Email.text.isNotEmpty) {
              try {
                await _auth.sendPasswordResetEmail(email: Email.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password reset email sent! Check your inbox.')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter your email')),
              );
            }
          },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.green,
              elevation: 12,
            ),
              child: Text('Submit', style: TextStyle(fontSize: 20,color: Colors.black),),
          )
        ],
      )
    );
  }
}