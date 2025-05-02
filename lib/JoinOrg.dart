import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Colors.dart';

class JoinOrg{
  static void showCustomAlertDialog({
    required BuildContext context,
  }) {
    var orgid=TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final ValueNotifier<String?> errorText = ValueNotifier<String?>(null);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(backgroundColor: inputBoxbgColor,
          title: Text("Join Organization\n",style: TextStyle(color: btncolor),),
          content: Form(
            key: _formKey,
            child: ValueListenableBuilder<String?>(
              valueListenable: errorText,
              builder: (context, error, child) {
                return TextFormField(
                  controller: orgid,
                  style: TextStyle(color: txtcolor),
                  decoration: InputDecoration(
                    fillColor: inputBoxbgColor,
                    labelText: "Enter organization code",
                    labelStyle: TextStyle(color: txtcolor),
                    errorText: error,
                    errorStyle: TextStyle(fontSize: 17),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: txtcolor, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textColor2, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(),
                  ),
                );
              },
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
                    errorText.value="Invalid Organization code";
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