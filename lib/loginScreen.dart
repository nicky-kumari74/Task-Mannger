import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/forgetPasswdScreen.dart';

class LoginScreen extends StatelessWidget{

  var Email = TextEditingController();
  var Password = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: appbarcolor,
       toolbarHeight: 70,
       title: Text('Smart Planning for Busy Lives',
         style: TextStyle(
           color: Colors.white, // Change color for better visibility
         ),
       ),
     ),
     backgroundColor: bgcolor,

     body: Container(
       child: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,

           children: [
             SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.all(13),  //adjust padding for better experience
               child: TextField(
                 style: TextStyle(color: Colors.white),
                 controller: Email,
                 decoration: InputDecoration(
                 labelText: 'Email',
                   labelStyle: TextStyle(color: Colors.black54, fontSize: 20 ),  // Change font color and fot size for better visibility
                   focusedBorder: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(12),
                     borderSide: BorderSide(color: Colors.white, width: 2)
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
                 keyboardType: TextInputType.emailAddress,
                 style: TextStyle(color: Colors.white),
                 controller: Email,
                 decoration: InputDecoration(
                     //counterText: 'Password must be 8 character long ',   // Add if you want to customized input from user
                     labelText: 'Password',
                     labelStyle: TextStyle(
                     color: Colors.black, fontSize: 20    // Change font color and fot size for better visibility
                     ),
                     focusedBorder: OutlineInputBorder(                             // When user clicked on it then the color of border will change
                         borderRadius: BorderRadius.circular(12),
                         borderSide: BorderSide(color: Colors.white, width: 2)
                     ),
                     enabledBorder: OutlineInputBorder(                             // Default border color when login page will open.
                         borderSide: BorderSide(color: Colors.black54, width: 2),   // Change color for better experience
                         borderRadius: BorderRadius.circular(16)
                     ),
                     prefixIcon: Icon(Icons.lock, color: Colors.black,)

                 ),
               ),
             ),

             Container(
               margin: EdgeInsets.only(left: 210),
               child: InkWell(
                 onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswdScreen(),)
                   );
                 },
                 child: Text(
                   'Forget Password',
                   style: TextStyle(
                     fontSize: 14,
                     color:appbarcolor,
                   ),
                 ),
               ),
             ),

             SizedBox(height: 18,),

             ElevatedButton(onPressed: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Dashboard()),
               );
             },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.green,
                   padding: EdgeInsets.only(left: 30, right: 30),
                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                 ),
                 child: Text('Login',
                   style: TextStyle(fontSize: 19, color: Colors.black),
                 )
             ),
         ElevatedButton(onPressed: () {},
             style: ElevatedButton.styleFrom(
               backgroundColor: Colors.green,     // background color of  the button
               padding: EdgeInsets.only(left: 80, right: 80),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
             ),
             child: Text('Login',
               style: TextStyle(fontSize: 19, color: Colors.black),
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
                 Center(child: Text('or', style: TextStyle(fontSize: 20),)),
                 Container(
                   height: 2,
                   color: Colors.blue,
                   margin: EdgeInsets.symmetric(horizontal: 5),
                   padding: EdgeInsets.only(right: 170),
                 )
         SizedBox(height: 18,),
         Row(
           children:
           [
             Container(
              height: 2,
               color: Colors.blue,    // change the color of horizontal line for better visibility
               margin: EdgeInsets.only(left: 10, right: 3),
               padding: EdgeInsets.only(left: 170),
             ),
             Center(child: Text('or', style: TextStyle(fontSize: 20),)),
             Container(
               height: 2,
               color: Colors.blue,      // change the color of horizontal line for better visibility
               margin: EdgeInsets.symmetric(horizontal: 5),
               padding: EdgeInsets.only(right: 170),
             ),
           ],
         ),

         Row(
           children: [
             Container(
               margin: EdgeInsets.only(left: 40, top: 10),
               width: 60, height: 60,      // Same height width for square box.
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.indigoAccent, width: 2),  //Adding border color and border width
                 borderRadius: BorderRadius.circular(10), //optional, Rounded corner
                 image: DecorationImage(
                     image: AssetImage('assets/images/google.png'),
                 ),

               ),
               child: GestureDetector(
                 onTap: () {

                 },
               ),
             ),

             SizedBox(width: 45,),

             Container(
               margin: EdgeInsets.only(left:30, top:10),
               width: 60, height: 60,  // Same height and wight for square box.
               decoration: BoxDecoration(
                 border: Border.all(color: Colors.indigoAccent, width: 2),   //Border color and width
                 borderRadius: BorderRadius.circular(10),  //Optional, Rounded Border
                 image: DecorationImage(
                     image: AssetImage('assets/images/facebook.png'),
                 ),
               ),
             ),

              ],
             ),

           ],
         ),
       ),
     )

   );
  }

}