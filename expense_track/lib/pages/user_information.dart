/*
in appbar - logout
* user icon - in circle at center
* username
* email
* total balance
*
*  */

import 'package:expense_track/Screens/LoginForm.dart';
import 'package:flutter/material.dart';

import 'info_card.dart';

class UserInformation extends StatefulWidget {
  String email;
   UserInformation({Key? key, required this.email}) : super(key: key);
  @override
  State<UserInformation> createState() => _UserInformationState(email);
}

class _UserInformationState extends State<UserInformation> {
  String email;
  _UserInformationState(this.email);
  static const phone = "7897451234"; // not real number :)
  static const location = "Rajkot, Gujarat, India";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Information"),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage()
                      ),
                  );
                },
                child: Icon(
                    Icons.logout
                ),
              )
          ),
        ],
      ),

      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              radius: 60,
              child: Icon(
                Icons.person,
                color: Colors.black87,
                size: 85,
              ),
            ),
            SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
              ),
            ),

            InfoCard(text: email, icon: Icons.email, onPressed: () async {}),
            InfoCard(text: phone, icon: Icons.phone, onPressed: () async {}),
            // InfoCard(text: url, icon: Icons.web, onPressed: () async {}),
            InfoCard(
                text: location,
                icon: Icons.location_city,
                onPressed: () async {}),

          ],
        ),
      ));
  }
}