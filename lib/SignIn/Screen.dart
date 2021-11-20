import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app_flutter/utils/text.dart';

// import 'package:GoogleSignIn/homepage.dart';
final FirebaseAuth auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();
Future<void> signup(BuildContext context) async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    // Getting users credential
    UserCredential result = await auth.signInWithCredential(authCredential);
    User user = result.user;

    if (result != null) {
      print("SIGN IN DONE");
      print(user);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => _buildPopupDialog(context)));
    }
  }
}

Future<void> signout(BuildContext context) async {
  if (googleSignIn.signOut() != null) {
    print("SIGN OUT DONE");
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => _buildPopupDialogOUT(context)));
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('ALERT!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[Text("Sign In Successfully!")],
    ),
    actions: <Widget>[
      // ignore: deprecated_member_use
      new FlatButton(
        onPressed: () {
          // Navigator.of(context).pop();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

Widget _buildPopupDialogOUT(BuildContext context) {
  return new AlertDialog(
    title: const Text('ALERT!'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[Text("Sign OUT Successfully!")],
    ),
    actions: <Widget>[
      // ignore: deprecated_member_use
      new FlatButton(
        onPressed: () {
          // Navigator.of(context).pop();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignInScreen()));
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Close'),
      ),
    ],
  );
}

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.blue,
            ],
          ),
        ),
        child: Card(
          margin: EdgeInsets.only(top: 200, bottom: 200, left: 30, right: 30),
          elevation: 20,
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              modified_text(
                text: "Binge",
                color: Colors.red,
                size: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/alien.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Sign In with Google",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  onPressed: () {
                    signup(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: MaterialButton(
                  color: Colors.teal[100],
                  elevation: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 30.0,
                        width: 30.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/alien.png'),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Sign OUT",
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                  onPressed: () {
                    signout(context);
                  },
                ),
              ),
              if (googleSignIn.currentUser != null)
                GoogleUserCircleAvatar(identity: googleSignIn.currentUser)
              else
                modified_text(
                  text: "Please SIGN In!",
                  color: Colors.white,
                )
            ],
          ),
        ),
      ),
    );
  }
}
