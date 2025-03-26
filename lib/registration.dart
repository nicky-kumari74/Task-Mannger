import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
import 'package:taskmanager/loginScreen.dart';


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

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration', style: TextStyle(color: Colors.white),),
        backgroundColor: appbarcolor,
      ),
      backgroundColor: Colors.white,

      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    controller: Name,
                    validator: (value) => value!.isEmpty ? 'Enter can not be empty' : null,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                        color: Colors.black, fontSize: 20   // Change label font color and size for better experience.
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.black87,)
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: Email,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: Colors.black, fontSize: 20),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          prefixIcon: Icon(Icons.email),
                        ),
                       /* validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email can not be empty';
                          } else if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a=zA-Z]{2,}$').hasMatch(value)) {
                            return'Enter a valid Email';
                          }
                          return null;
                        },*/
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: TextFormField(
                    obscureText:_isObscure,
                    controller: Password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      }, icon: Icon(
                     _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                        ),
                     ),
                    ),
                    validator: (value) {
                      if (value ==null || value.isEmpty) {
                        return 'Password can not be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                 ),
                ),

                SizedBox(height: 18,),

                ElevatedButton( onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: Email.text.trim(),
                        password: Password.text.trim(),
                      );
                      User? user = userCredential.user;
                      if (user != null) {
                        //await user.updateDisplayName(Name.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Registration Successful!'))
                        );

                        Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error: ${e.toString()}')),
                      );
                    }
                  }
                },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: appbarcolor,    // change background color for better visibility.
                        padding: EdgeInsets.only(left: 60, right: 60),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                    ),
                    child: Text('Submit', style: TextStyle(fontSize: 19, color: Colors.white),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? ", style: TextStyle(fontSize: 14, color: Colors.black87)),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),  // Replace with your login screen
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),


                /* Row(

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
                ),*/



              ]

            ),
          ),
        ),
      ),
    );
  }
}

Future<void> registerUser(BuildContext context, String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('User registered: ${userCredential.user?.email}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Registration Successful!'))
    );
  } catch (e) {
    String errorMessage = 'Registration Failed. Try again';

    if (e is FirebaseAuthException) {
      switch(e.code) {
        case 'email-already-in-use': errorMessage = "This email is already in use.";
        break;
        case 'invalid-email': errorMessage = "Invalid email format";
        break;
        case 'weak-password': errorMessage = "Password must be at least 8 characters long.";
        break;
        default: errorMessage = e.message ?? 'Ann unexpected error occurred.';
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('errorMessage')),
    );
  }
}