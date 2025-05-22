
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';

class Setting extends StatefulWidget{
  @override
  State<Setting> createState()=> _Setting();
}

class _Setting extends State<Setting>{
  @override
  Widget build(BuildContext context){
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
                    child: Padding(
                      padding: EdgeInsets.only(top: 10,bottom: 10,left: 8,right: 10),
                      child: Row(
                        children: [
                          Icon(Icons.messenger_outline,color: btncolor,size: 23,),
                          SizedBox(width: 10,),
                          Expanded(child: Text("Feedback",style: TextStyle(color: btncolor,fontSize: 17),)),
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
}