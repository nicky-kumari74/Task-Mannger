import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskmanager/Colors.dart';

class sendInvitation extends StatefulWidget {

  @override
  State<sendInvitation> createState() => _sendInvitationState();
}

class _sendInvitationState extends State<sendInvitation> {
  TextEditingController teamnameController = TextEditingController();
  List<TextEditingController> emailControllers = [];

  @override
  void initState () {
    super.initState();
    // Start with 3 email fields
    for (int i = 0; i<3; i++) {
      emailControllers.add(TextEditingController());
    }
  }

  // Functions to add a new email field (max 10)

  void addEmailField () {
    print('Current email count : ${emailControllers.length}');
    if (emailControllers.length <10) {
      setState(() {
        emailControllers.add(TextEditingController());
      });
      print("Email field added");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You can only add up to 10 emails")),

      /*ScaffoldMessenger.of(context, root).showSnackBar(
      SnackBar(content: Text("You can only add up to 10 emails")),*/
      );
    }
  }

  //Function to send invitation
  Future<void> sendInvitation () async {
    String teamname = teamnameController.text.trim();
    List<String> emails = emailControllers.map((controller) =>
        controller.text.trim())
        .where((email) => email.isNotEmpty).toList();

    if (teamname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a team name')),
      );
      return;
    }
    if (emails.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter at least two email')),
      );
      return;
    }

   /* for (String email in emails) {
      try {
        final result = await FirebaseFunctions.instance.httpsCallable(
            'sendInvitationEmail').call({'teamname': teamname, "email": email});

        if (result.data['success']) {
          print('Invitation sent to $email');
        } else {
          print("Failed to send invitation: ${result.data['message']}");
        }
      } catch (e) {
        print("Error sending email: $e");
      }
    }*/

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Invitations sent successfully! ")),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        backgroundColor: bgcolor,
        toolbarHeight: 70,
        title: Text('Send Invitation', style: TextStyle(color: txtcolor, ),),
        iconTheme: IconThemeData(color: txtcolor),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: teamnameController,
              style: TextStyle(color: txtcolor),
              decoration: InputDecoration(
                filled: true,
                fillColor: inputBoxbgColor,
                hintText: 'Enter Team Name',
                hintStyle: TextStyle(
                  color: txtcolor,
                  fontSize: 18,
                ),
                //border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: btncolor)
                )
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: emailControllers.length,
                  itemBuilder: (context, index) {
                  return Padding(padding: EdgeInsets.symmetric(vertical: 8.1),
                  child: TextField(
                    controller: emailControllers[index],
                    decoration: InputDecoration(
                    filled: true,
                    fillColor: inputBoxbgColor,
                      labelText: 'Enter Email ID',
                      labelStyle: TextStyle(color: txtcolor),
                      border: OutlineInputBorder(
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: btncolor)
                      )
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  );
                  }),
            ),

            SizedBox(height: 10,),

              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      if (emailControllers.length < 10) {
                          addEmailField();

                      }
                    },
                    child: Text('+ add more...', style: TextStyle(color: btncolor),))
                /*IconButton(onPressed: () {},
                    icon: Icon(Icons.add_circle, color: Colors.white,size: 27,)
                ),*/
              ),

            SizedBox(height: 160,),
            ElevatedButton(onPressed: sendInvitation,
              child: Text("Send Invitation", style: TextStyle(color: txtcolor),),
              style: ElevatedButton.styleFrom(
                backgroundColor: btncolor,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 31),
                textStyle: TextStyle(fontSize: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}