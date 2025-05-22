import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/Colors.dart';

class ForgetPasswdScreen extends StatefulWidget{
  final data;
   ForgetPasswdScreen(this.data);

  @override
  State<ForgetPasswdScreen> createState() => _ForgetPasswdScreenState();
}

class _ForgetPasswdScreenState extends State<ForgetPasswdScreen> {
  var Email = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool send=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(widget.data,
          style: TextStyle(color: Colors.white),),
        backgroundColor: bgcolor, // change color for better experience
      ),
      backgroundColor:bgcolor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //SizedBox(height: 1,),
            /*Container(
              margin: EdgeInsets.only(left: 20,right: 20),
                child: Center(child: Text("Enter email address associated with your account and we'll send email with instruction to reset your password",style: TextStyle(color: textColor2,fontSize: 15),))
            ),*/
            SizedBox(height: 10,),
            Lottie.asset(
              'assets/forgot-password.json', // Place the file in assets/animations/
              height: 200,
              repeat: true,
            ),
            SizedBox(height: 20,),
            Container(
              margin: EdgeInsets.only(left: 40,right: 40),
                child: Text("Enter your email address and we'll email you a secure link to reset your password",style: TextStyle(color: textColor2),textAlign: TextAlign.center,)
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 30,right: 30),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: Email,
                style: TextStyle(color: txtcolor),
                decoration: InputDecoration(
                    filled: true, // Enables the background color
                    fillColor: inputBoxbgColor,
                  prefixIcon: Icon(Icons.email, color: iconColor,),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: textColor2, fontSize: 18),    // change font color and size for better experience
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: txtcolor, width: 2,)       // color change when user clicked on this widget and change border color for better experience
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.transparent, width: 2)       // color change when user clicked on this widget and change border color for better experience
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                ),
              ),
            ),
        
            SizedBox(height: 40,),
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
                    backgroundColor: btncolor,    // change background color for better visibility.
                    padding: EdgeInsets.only(left: 50,right: 50,top: 9,bottom: 9),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                child: Text('Send',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
            ),
          ],
        ),
      )
    );
  }
}