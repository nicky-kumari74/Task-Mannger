import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/DashboardScreen.dart';
import 'package:taskmanager/FirebaseServices.dart';
import 'package:taskmanager/loginScreen.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/setting_provider.dart';

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
  var phone=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  bool _isLoading = false;bool _isLoading2=false;
  final provider=SettingProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgcolor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Padding(padding: const EdgeInsets.only(right: 20),
            child: Image.asset('assets/images/task_master.jpg',height: 50,width: 60,),
          )
        ],
      ),
      backgroundColor: bgcolor,

      body: Center(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                SizedBox(height: 10,),
                Text("Create your account",style: TextStyle(color: textColor2,fontSize: 25,fontWeight: FontWeight.w400),),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  child: TextFormField(
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
                        borderSide: BorderSide(color: txtcolor, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: txtcolor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      prefixIcon: Icon(Icons.person, color: iconColor,),
                      contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    ),
                    validator: (value) =>provider.nameValidator(value!),
                  ),
                ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  child: TextFormField(
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
                        borderSide: BorderSide(color: txtcolor, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: txtcolor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.email,color: iconColor),
                      contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    ),
                    validator: (value) =>provider.emailValidator(value),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  child: TextFormField(
                    controller: phone,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color:Colors.white),
                    decoration: InputDecoration(
                      filled: true, // Enables the background color
                      fillColor: inputBoxbgColor,
                      labelText: 'Phone no.',
                      labelStyle: TextStyle(
                          color: textColor2, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: txtcolor, width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent, width: 1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: txtcolor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      prefixIcon: Icon(Icons.call,color: iconColor),
                      contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    ),
                    validator: (value) =>provider.phoneValidator(value),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35),
                  child: TextFormField(
                    obscureText:_isObscure,
                    controller: Password,
                    style: TextStyle(color: txtcolor),
                    decoration: InputDecoration(
                      filled: true, // Enables the background color
                      fillColor: inputBoxbgColor,
                      labelText: 'Password',
                      labelStyle: TextStyle(color: textColor2, fontSize: 18),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: txtcolor, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: txtcolor, width: 1),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(10),
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
                    validator: (value)=>provider.passwordValidator(value),
                 ),
                ),

                SizedBox(height: 40,),

                _isLoading
                    ? CircularProgressIndicator(color: btncolor)
                    : ElevatedButton(
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      _register();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btncolor,
                    padding: EdgeInsets.symmetric(horizontal: 110, vertical: 11),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text('Sign Up', style: TextStyle(fontSize: 19, color: bgcolor)),
                ),

                SizedBox(height: 50,),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children:
                      [
                        Center(
                            child: Text('_________________ or _________________ ', style: TextStyle(fontSize: 15,color: iconColor),)),
                      ]
                  ),
                ),
                SizedBox(height: 40,),
                _isLoading2?CircularProgressIndicator(color: btncolor)
                    :GestureDetector(
                  onTap: () async {
                    googleSignin();
                  },
                  child: Container(
                    width: 275, height: 48,
                    decoration: BoxDecoration(
                      //color: inputBoxbgColor,
                      border: Border.all(color: CupertinoColors.systemGrey, width: 2),  // Border color and width, adjust for better experience.
                      borderRadius: BorderRadius.circular(10), //optional, Rounded corner
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 35),
                        Image.asset(
                          'assets/images/google.png',
                          height: 28,
                          width: 28,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(fontSize: 17, color: txtcolor),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70,),
              ]

            ),
          ),
        ),
      ),
    );
  }
  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email.text.trim(),
        password: Password.text.trim(),
      );
      User? user = userCredential.user;
      if (user != null) {
        String email=Email.text.trim();
        String docId = "users-${email.replaceAll('.', '-')}-data";
        await FirebaseFirestore.instance.collection('users').doc(docId).set({
          'name':Name.text.trim(),
          'email': email,
          'phone':phone.text.trim(),
          'createdAt': Timestamp.now(),
        });
        /*var sharepref = await SharedPreferences.getInstance();
        sharepref.setString("name", Name.text.trim());*/
        RegistrationPopup();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Failed: \$e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void RegistrationPopup() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title:
        Image.asset(
          'lib/icons/checkmark.png',
          color:  Colors.green,
          width: 45,
          height: 45,
        ),
        content: Text('Registration completed successfully!!!',style: TextStyle(color: bgcolor,fontSize: 18),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text('OK',style: TextStyle(color: btncolor,fontSize: 17,fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Future<void> googleSignin() async{
    setState(() {
      _isLoading2=true;
    });
    await FirebaseServices().signInwithGoogle();
    var name=FirebaseAuth.instance.currentUser!.displayName??'';
    var email=FirebaseAuth.instance.currentUser!.email??'';
    String docId = "users-${email.replaceAll('.', '-')}-data";
    await FirebaseFirestore.instance.collection('users').doc(docId).set({
      'name':name,
      'email': email,
      'createdAt': Timestamp.now(),
    });
    var sharepref= await SharedPreferences.getInstance();
    await sharepref.setBool("google", true);
    await sharepref.setBool("login", true);
    await sharepref.setString("email",email );
    await sharepref.setString("name", name);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Dashboard(),));
  }
}


