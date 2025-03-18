import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
import 'package:taskmanager/forgetPasswdScreen.dart';
import 'package:taskmanager/registration.dart';

class LoginScreen extends StatefulWidget{

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var Email = TextEditingController();
  var Password = TextEditingController();
  bool _isobscure = true;
  final FocusNode _focusNode = FocusNode();
  Color enableborderColor =  Colors.black;
  Color labelTextColor =  Colors.black;

  @override
  void initState(){
    super.initState();

    _focusNode.addListener( () {
      setState(() {
        if (_focusNode.hasFocus) {
          enableborderColor =  Colors.blue;
          labelTextColor = Colors.blue;
        } else {
          enableborderColor = Colors.black;
          labelTextColor = Colors.black;
        }
      });
    }
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: appbarcolor,
       toolbarHeight: 70,       // Height of appbar
       title: Text('Powering Personal and Team Tasks',
         style: TextStyle(color: Colors.white, fontSize: 20 //  app bar text color, change for better visibility
         ),
       ),
     ),
     backgroundColor: bgcolor,

     body: Center(
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(13),  //adjust padding for better experience
               child: TextField(
                 keyboardType: TextInputType.emailAddress,
                 style: TextStyle(color: Colors.black),
                 controller: Email,
                 focusNode: _focusNode,
                 decoration: InputDecoration(
                 labelText: 'Email',
                   labelStyle: TextStyle(color: labelTextColor, fontSize: 20 ),  // Dynamic label text color
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(12),
                     borderSide: BorderSide(color: enableborderColor, width: 2),    // Dynamic Border color
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.black54, width: 2),
                     borderRadius: BorderRadius.circular(16)
                   ),
                   prefixIcon: Icon(Icons.email, color: Colors.black,)
         
                 ),
               ),
             ),
         
             SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(13),
               child: TextField(
                 obscureText: _isobscure,
                 style: TextStyle(color: Colors.black),
                 controller: Password,
                 decoration: InputDecoration(
                     //counterText: 'Password must be 8 character long ',   // Add if you want to customized input from user
                     labelText: 'Password',
                     labelStyle: TextStyle(
                     color: Colors.black, fontSize: 20    // Change font color and fot size for better visibility
                     ),
                     focusedBorder: OutlineInputBorder(                             // When user clicked on it then the color of border will change
                         borderRadius: BorderRadius.circular(12),
                         borderSide: BorderSide(color: borderColor, width: 2)
                     ),
                     enabledBorder: OutlineInputBorder(                             // Default border color when login page will open.
                         borderSide: BorderSide(color: Colors.black54, width: 2),   // Change color for better experience
                         borderRadius: BorderRadius.circular(16)
                     ),
                     prefixIcon: Icon(Icons.lock, color: Colors.black,),
                     suffixIcon: IconButton(onPressed: () {
                       setState(() {
                         _isobscure = !_isobscure;
                       });
                     }, icon:Icon(_isobscure ? Icons.visibility_off: Icons.visibility, color: Colors.black,) )
         
                 ),
               ),
             ),
         
             Container(
               margin: EdgeInsets.only(left: 210),
               child: InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswdScreen(),)   // this will help to navigate forgetpsswd screen when user click on Forget Password.
                   );
                 },
                 child: Text(
                   'Forget Password',
                   style: TextStyle(
                     fontSize: 14,
                     color:Colors.black87,   // Change Text color for better user experience.
                   ),
                 ),
               ),
             ),
         
             SizedBox(height: 18,),
         
             ElevatedButton(onPressed: () async {
               try {
                 UserCredential userCredential = await FirebaseAuth.instance
                     .signInWithEmailAndPassword(
                   email: Email.text.trim(),
                   password: Password.text.trim(),
                 );
                 User? user = userCredential.user;
                 if(user!=null){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => Dashboard()),
                   );
                 }
               }
               catch(e){
                 ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text(e.toString())),
                 );
               }

             },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: appbarcolor,    // change background color for better visibility.
                   padding: EdgeInsets.only(left: 60, right: 60),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                 ),
                 child: Text('Login',
                   style: TextStyle(fontSize: 19, color: Colors.white),
                 )
             ),

             SizedBox(height: 18,),

             Row(
               children:
               [
                 Container(
                  height: 2,
                   color: Colors.blue,
                   margin: EdgeInsets.only(left: 10, right: 3),
                   padding: EdgeInsets.only(left: 170),
                 ),
                 Center(
                     child: Text('or', style: TextStyle(fontSize: 20),)),
                 Container(
                   height: 2,
                   color: Colors.blue,   // Color of horizontal lines
                   margin: EdgeInsets.symmetric(horizontal: 5),  // Horizontally shift the line from left to right.
                   padding: EdgeInsets.only(right: 177),
                 ),
                ]
             ),
                SizedBox(height: 18,),
         
          Row(
         
           children: [
         
             Container(
               margin: EdgeInsets.only(left: 40, top: 10),
               width: 60, height: 60,      // Same height width for square box.
               decoration: BoxDecoration(
                 color: Colors.transparent,
                 border: Border.all(color: Colors.transparent, width: 2),  // Border color and width, adjust for better experience.
                 borderRadius: BorderRadius.circular(10), //optional, Rounded corner
                 image: DecorationImage(
                     image: AssetImage('assets/images/google.png'),
                 ),
               ),
               child: GestureDetector(
                 onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(),));
                 },
               ),
             ),
         
             SizedBox(height: 18,),
             Container(
               margin: EdgeInsets.only(left:65, top:10),
               width: 60, height: 60,  // Same height and wight for square box.
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
         
             Container(
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
             ),
           ],
          ),
         
         SizedBox(height: 70,),
         Center(
           child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Don't have an account ", style: TextStyle(fontSize: 14, color: Colors.black87, ),),
         
                 InkWell(
                   onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen()));
                   },
         
                     child: Text('Sign Up', style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),))
               ],
             ),
         
         )
         
         ],
         ),
       ),
       ),
   );
  }

}