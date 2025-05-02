import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Colors.dart';

class JoinOrg{
  static void showCustomAlertDialog({
    required BuildContext context,
  }) {
    var orgid=TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(backgroundColor: inputBoxbgColor,
          title: Text("Join Organization\n",style: TextStyle(color: btncolor),),
          content: TextField(
            controller: orgid,
            style: TextStyle(color: txtcolor),
            decoration: InputDecoration(
              fillColor: inputBoxbgColor,
              labelText: "Enter organization code",
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
                if(orgid.text.trim().isEmpty){}
                else {
                  final orgref = FirebaseFirestore.instance.collection(
                      "organizations").doc(orgid.text.trim());
                  final docSnapshot = await orgref.get();

                  if (docSnapshot.exists) {
                    final data = docSnapshot.data();
                    final orgName = data?['org_name']; // This is "tcs"
                    print('Organization  Name: $orgName');
                    final shareprefs = await SharedPreferences.getInstance();
                    String? email=shareprefs.getString("email");
                    await FirebaseFirestore.instance.collection("Personal Task").doc(email).collection("organization").doc(orgName).set({
                      "org_id":orgid.text.trim(),});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Organization Joined!')));
                    Navigator.of(context).pop();
                  } else {
                    print('Document not found');
                  }
                }
              },
              child: Text("Join",style: TextStyle(color: btncolor,fontSize: 17),),
            ),
          ],
        );
      },
    );
  }
}