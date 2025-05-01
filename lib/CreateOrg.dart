
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/Colors.dart';
import 'package:uuid/uuid.dart';

class CreateOrg{
 static void showCustomAlertDialog({
    required BuildContext context,
  }) {
   var organizationController=TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(backgroundColor: inputBoxbgColor,
          title: Text("Create Organization\n",style: TextStyle(color: btncolor),),
          content: TextField(
            controller: organizationController,
            style: TextStyle(color: txtcolor),
            decoration: InputDecoration(
              fillColor: inputBoxbgColor,
              labelText: "Enter your organization name",
              labelStyle: TextStyle(color: txtcolor,),
              focusedBorder: OutlineInputBorder(                             // When user clicked on it then the color of border will change
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color:txtcolor, width: 2)
              ),
              enabledBorder: OutlineInputBorder(                             // Default border color when login page will open.
                  borderSide: BorderSide(color: textColor2, width: 2),   // Change color for better experience
                  borderRadius: BorderRadius.circular(10)
              ),
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel",style: TextStyle(color: txtcolor,fontSize: 17),),
            ),
            TextButton(
              onPressed: () async {
                if(organizationController.text.trim().isEmpty){}
                else{
                  var uuid = Uuid();
                  String orgCode = uuid.v4().split('-').first;
                  //print(orgCode);
                  await FirebaseFirestore.instance
                      .collection('organizations')
                      .doc(orgCode)
                      .set({
                    'org_name': organizationController.text.trim(),
                  });
                  final shareprefs = await SharedPreferences.getInstance();
                  String? email=shareprefs.getString("email");
                  await FirebaseFirestore.instance.collection("Personal Task").doc(email).collection("organization").doc(organizationController.text.trim()).set({
                    "org_id":orgCode,
                  });
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Organization Created!')));
                  Navigator.of(context).pop();
                }
              },
              child: Text("Create",style: TextStyle(color: btncolor,fontSize: 17),),
            ),
          ],
        );
      },
    );
  }
}