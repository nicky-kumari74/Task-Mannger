
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:taskmanager/Colors.dart';
import 'package:taskmanager/forgetPasswdScreen.dart';
import "package:store_redirect/store_redirect.dart";
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget{
  @override
  State<Setting> createState()=> _Setting();
}

class _Setting extends State<Setting>{
  final Uri emailUri=Uri(
    scheme: 'mailto',
    path: 'fixtappsfirebase@gmail.com'
  );
  @override
  Widget build(BuildContext context){
    String link="https://play.google.com/store/apps/details?id=com.example.yourapp";
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        iconTheme: IconThemeData(color: txtcolor),
        title: Text("Setting",style: TextStyle(color: txtcolor),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
          child: Column(
            children: [
              Card(
                color: inputBoxbgColor,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: GestureDetector(
                  onTap: ()=>{
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswdScreen("Reset Password")))
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 10),
                    child: Row(
                      children: [
                        Icon(Icons.lock,color: btncolor,size: 23,),
                        SizedBox(width: 10,),
                        Expanded(child: Text("Reset Password",style: TextStyle(color: btncolor,fontSize: 17),)),
                        Icon(Icons.arrow_forward_ios, color: btncolor,size: 15,),
                      ],
                    ),
                  ),
                )
              ),
              SizedBox(height: 15,),
              Card(
                  color: inputBoxbgColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: GestureDetector(
                    onTap: ()=>{
                      showAdminDialogueBox()
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.admin_panel_settings,color: btncolor,size: 23,),
                          SizedBox(width: 10,),
                          Expanded(child: Text("Contact With Admin",style: TextStyle(color: btncolor,fontSize: 17),)),
                          Icon(Icons.arrow_forward_ios, color: btncolor,size: 15,),
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: 15,),
              Card(
                  color: inputBoxbgColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: GestureDetector(
                    onTap: ()=>{
                      Share.share("Download the App: \n $link")
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.share,color: btncolor,size: 23,),
                          SizedBox(width: 10,),
                          Expanded(child: Text("Share App",style: TextStyle(color: btncolor,fontSize: 17),)),
                          Icon(Icons.arrow_forward_ios, color: btncolor,size: 15,),
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: 15,),
              Card(
                  color: inputBoxbgColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.headphones,color: btncolor,size: 23,),
                          SizedBox(width: 10,),
                          Expanded(child: Text("Help & Support",style: TextStyle(color: btncolor,fontSize: 17),)),
                          Icon(Icons.arrow_forward_ios, color: btncolor,size: 15,),
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: 15,),
              Card(
                  color: inputBoxbgColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: GestureDetector(
                    onTap: (){
                      StoreRedirect.redirect(androidAppId: 'com.example.taskmanager',iOSAppId: 'com.example.taskmanager');
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.messenger_outline,color: btncolor,size: 23,),
                          SizedBox(width: 10,),
                          Expanded(child: Text("Rate App",style: TextStyle(color: btncolor,fontSize: 17),)),
                          Icon(Icons.arrow_forward_ios, color: btncolor,size: 15,),
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: 15,),
              Card(
                  color: inputBoxbgColor,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.help_outline,color: btncolor,size: 23,),
                          SizedBox(width: 10,),
                          Expanded(child: Text("About",style: TextStyle(color: btncolor,fontSize: 17),)),
                          Icon(Icons.arrow_forward_ios, color: btncolor,size: 15,),
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  showAdminDialogueBox() {
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(
            backgroundColor: Colors.transparent,
            // Transparent background for glass effect
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    // Glassy semi-transparent effect
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("If you have any query then you can contact with admin on this given Email:\n",style: TextStyle(fontSize: 17,color: txtcolor),),
                      GestureDetector(
                        onTap: () async {
                          if (await canLaunchUrl(emailUri)) {
                            await launchUrl(emailUri);
                          }
                        },
                          child: Text("fixtappsfirebase@gmail.com \n",
                            style: TextStyle(
                                color: btncolor,fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: btncolor,
                              fontSize: 17
                            ),)
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(
                            "Close",
                            style: TextStyle(color: btncolor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}