import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
import 'package:taskmanager/main.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RegistrationScreen(),
    );
  }

}

class RegistrationScreen extends StatefulWidget {
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  var Name =  TextEditingController();
  var Email =  TextEditingController();
  var Password =  TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgcolor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: bgcolor,

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Text("Create your account",style: TextStyle(color: textColor2,fontSize: 25,fontWeight: FontWeight.w400),),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: TextField(
                  style: TextStyle(color: txtcolor),
                  controller: Name,
                  decoration: InputDecoration(
                      filled: true, // Enables the background color
                      fillColor: inputBoxbgColor,
                    labelText: 'Name',
                    labelStyle: TextStyle(
                      color: textColor2, fontSize: 18   // Change label font color and size for better experience.
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: Icon(Icons.person, color: iconColor,),
                    contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: TextField(
                  controller: Email,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color:Colors.white),
                  decoration: InputDecoration(
                      filled: true, // Enables the background color
                      fillColor: inputBoxbgColor,
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: textColor2, fontSize: 18),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: Icon(Icons.email,color: iconColor),
                    contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 25,right: 25),
                child: TextField(
                  obscureText:_isObscure,
                  controller: Password,
                  style: TextStyle(color: txtcolor),
                  decoration: InputDecoration(
                    filled: true, // Enables the background color
                    fillColor: inputBoxbgColor,
                    labelText: 'Password',
                    labelStyle: TextStyle(color: textColor2, fontSize: 18),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent, width: 2),
                      borderRadius: BorderRadius.circular(10)
                    ),
                    prefixIcon: Icon(Icons.lock,color: iconColor,),
                    contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    suffixIcon: IconButton(onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    }, icon: Icon(
                   _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: iconColor,
                      ),
                   ),

                 ),
               ),
              ),

              SizedBox(height: 20,),

              ElevatedButton(onPressed: () async {
                UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: Email.text.trim(),
                  password: Password.text.trim(),
                );
                User? user = userCredential.user;
                if(user!=null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard()),
                  );
                }
              },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: btncolor,    // change background color for better visibility.
                      padding: EdgeInsets.only(left: 90,right: 90,top: 11,bottom: 11),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  child: Text('Sign Up',
                    style: TextStyle(fontSize: 19, color: Colors.white),
                  )
              ),

              SizedBox(height: 50,),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                    children:
                    [
                      Container(
                        height: 2,
                        color: iconColor,
                        margin: EdgeInsets.only(left: 1, right: 3),
                        padding: EdgeInsets.only(left: 130),
                      ),
                      Center(
                          child: Text(' or continue with', style: TextStyle(fontSize: 15,color: iconColor),)),
                      Container(
                        height: 2,
                        color: iconColor,   // Color of horizontal lines
                        margin: EdgeInsets.symmetric(horizontal: 5),  // Horizontally shift the line from left to right.
                        padding: EdgeInsets.only(right: 177),
                      ),
                    ]
                ),
              ),
              SizedBox(height: 18,),

              Row(

                children: [

                  Container(
                    margin: EdgeInsets.only(left: 90, top: 10),
                    width: 70, height: 40,      // Same height width for square box.
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent, width: 2),  // Border color and width, adjust for better experience.
                      borderRadius: BorderRadius.circular(10), //optional, Rounded corner
                      image: DecorationImage(
                          image: AssetImage('assets/images/google.png',),
                          fit: BoxFit.fitHeight
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));
                      },
                    ),
                  ),

                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left:65, top:10),
                    width: 70, height: 50,  // Same height and wight for square box.
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.transparent, width: 2),   // Border color and width, adjust for better experience.
                      borderRadius: BorderRadius.circular(10),  //Optional, Rounded Border
                      image: DecorationImage(
                        image: AssetImage('assets/images/facebook.png'),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                      },
                    ),
                  ),

                  /*Container(
                    margin: EdgeInsets.only(left: 68, top: 10),
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.transparent, width: 2, ),  // Border color and width, adjust for better experience.
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: AssetImage('assets/images/twitter.png'))
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                      },
                    ),
                  ),*/
                ],
              ),
              SizedBox(height: 70,),
            ]

          ),
        ),
      ),
    );
  }
}


