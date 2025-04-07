import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  bool _isLoading=false;

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
     backgroundColor: bgcolor,
     body: Center(
       child: SingleChildScrollView(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: 10,),
           Text('LogIn', style: TextStyle(color: txtcolor, fontSize: 30,fontWeight: FontWeight.bold)),
             SizedBox(height: 10,),
             Text("Welcome Back!!",style: TextStyle(color: textColor2,fontSize: 18),),
             SizedBox(height: 40,),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30),  //adjust padding for better experience
               child: TextField(
                 keyboardType: TextInputType.emailAddress,
                 style: TextStyle(color: txtcolor),
                 controller: Email,
                 focusNode: _focusNode,
                 decoration: InputDecoration(
                   filled: true, // Enables the background color
                   fillColor: inputBoxbgColor,
                 labelText: 'Email',
                   labelStyle: TextStyle(
                     color:txtcolor, fontSize: 18   // Change font color and fot size for better visibility
                 ),  // Dynamic label text color labelTextColor
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(12),
                     borderSide: BorderSide(color:txtcolor, width: 2),    // Dynamic Border color
                   ),
                   enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(color: Colors.transparent, width: 2),
                     borderRadius: BorderRadius.circular(16)
                   ),
                   prefixIcon: Icon(Icons.email, color: iconColor,),
                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
         
                 ),
               ),
             ),
             SizedBox(height: 20,),
             Padding(
               padding: const EdgeInsets.only(left: 30,right: 30),
               child: TextField(
                 obscureText: _isobscure,
                 style: TextStyle(color: txtcolor),
                 controller: Password,
                 decoration: InputDecoration(
                   filled: true, // Enables the background color
                   fillColor: inputBoxbgColor,
                     //counterText: 'Password must be 8 character long ',   // Add if you want to customized input from user
                     labelText: 'Password',
                     labelStyle: TextStyle(
                     color: txtcolor, fontSize: 18
                       // Change font color and fot size for better visibility
                     ),
                     focusedBorder: OutlineInputBorder(                             // When user clicked on it then the color of border will change
                         borderRadius: BorderRadius.circular(12),
                         borderSide: BorderSide(color:txtcolor, width: 2)
                     ),
                     enabledBorder: OutlineInputBorder(                             // Default border color when login page will open.
                         borderSide: BorderSide(color: Colors.transparent, width: 2),   // Change color for better experience
                         borderRadius: BorderRadius.circular(16)
                     ),
                     prefixIcon: Icon(Icons.lock, color: iconColor,),
                     suffixIcon: IconButton(onPressed: () {
                       setState(() {
                         _isobscure = !_isobscure;
                       });
                     }, icon:Icon(_isobscure ? Icons.visibility_off: Icons.visibility, color: iconColor,) ,),
                   contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                   'Forgot Password?',
                   style: TextStyle(
                     fontSize: 14,
                     color:txtcolor,   // Change Text color for better user experience.
                   ),
                 ),
               ),
             ),
             SizedBox(height: 25,),
             _isLoading
                 ? CircularProgressIndicator(color: btncolor)
                 : ElevatedButton(onPressed: _login,
                 style: ElevatedButton.styleFrom(
                   backgroundColor: btncolor,    // change background color for better visibility.
                   padding: EdgeInsets.only(left: 100,right: 100,top: 11,bottom: 11),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                 ),
                 child: Text('Login',
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
                       child: Text(' or continue with ', style: TextStyle(fontSize: 15,color: iconColor),)),
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
             SizedBox(height: 18,),
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
             SizedBox(height: 50,),
             Center(
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text("Don't have an account? ", style: TextStyle(fontSize: 14, color: txtcolor, ),),

                   InkWell(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> RegistrationScreen()));
                       },

                       child: Text('Sign Up', style: TextStyle(color: btncolor, fontSize: 14, fontWeight: FontWeight.bold),))
                 ],
               ),

             ),
         ],
         ),
       ),
       ),
   );
  }
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: Email.text.trim(),
        password: Password.text.trim(),
      );
      User? user = userCredential.user;
      if(user!=null){
        String email=Email.text.trim();
        String docId = "users-${email.replaceAll('.', '-')}-data";
        DocumentSnapshot doc= await FirebaseFirestore.instance.collection('users').doc(docId).get();

        var sharepref= await SharedPreferences.getInstance();
        await sharepref.setBool("login", true);
        await sharepref.setString("email", email);
        await sharepref.setString("name", doc['name']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.close, color: Colors.red),
              SizedBox(width: 8),
              Text("Login Failed",style: TextStyle(color: Colors.red),),
            ],
          ),
          content: Text("Invalid email or password. Please try again."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Clear the input fields
                Email.clear();
                Password.clear();
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
      /*ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed: \$e")),
      );*/
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

}