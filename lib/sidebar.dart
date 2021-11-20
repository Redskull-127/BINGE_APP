import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_flutter/assets/meer_icons.dart';
import 'package:movie_app_flutter/unityad.dart';
import 'package:movie_app_flutter/utils/text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'main.dart';
import 'ad.dart';
import 'SignIn/Update.dart';

class NavDrawer extends StatelessWidget {
  _launchURL() async {
    var ul = 'https://redskull-127.github.io/BINGE/#about';
    if (await canLaunch(ul)) {
      await launch(ul);
    } else {
      throw 'Could not launch';
    }
  }

  _contactURL() async {
    var con = 'https://www.instagram.com/127.0.0.1.exe/';
    if (await canLaunch(con)) {
      await launch(con);
    } else {
      throw 'Could not launch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            padding: EdgeInsets.only(left: 135, right: 20, top: 20, bottom: 20),
            child: modified_text(
              text: '\nBinge',
              size: 30,
              color: Colors.red,
              textAlign: TextAlign.left,
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(top: 35, left: 15),
            leading: Icon(
              Icons.input,
              color: Colors.red,
            ),
            title: modified_text(text: 'Login'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GoogleSignIn()),
              )
            },
          ),
          ListTile(
            leading: Icon(MEERIcon.youtube_play, color: Colors.red),
            title: modified_text(text: 'YouTube'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThirdRoute()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user, color: Colors.red),
            title: modified_text(text: 'Update'),
            onTap: () => _launchURL(),
          ),
          ListTile(
            leading: Icon(Icons.download, color: Colors.red),
            title: modified_text(text: 'Downloads'),
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySecApp()),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle, color: Colors.red),
            title: modified_text(text: 'Contact US'),
            onTap: () => _contactURL(),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Colors.red),
            title: modified_text(text: 'Logout'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GoogleSignIn()),
            ),
          ),
          HomeScreen(),
        ],
      ),
    );
  }
}
