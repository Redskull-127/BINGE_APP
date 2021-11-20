import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/widgets.dart';
import 'package:movie_app_flutter/SignIn/Update.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'Screen.dart';

final Meer = googleSignIn.currentUser.displayName;

class Avtar extends StatefulWidget {
  Avtar({Key key}) : super(key: key);
  @override
  AvtarState createState() => AvtarState();
}

class AvtarState extends State<Avtar> {
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    if (googleSignIn.currentUser != null) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            modified_text(
              text: "Welcome Back !\n",
              color: Colors.amberAccent,
              size: 22,
            ),
            modified_text(
              text: Meer,
              color: Colors.amber,
              size: 18,
            ),
            GoogleUserCircleAvatar(identity: googleSignIn.currentUser)
          ]);
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            modified_text(
              text: "Please Sign In!",
              color: Colors.amber,
            )
          ]);
    }
  }
}
