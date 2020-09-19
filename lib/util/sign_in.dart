import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';

class sign_in{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<User> signInWithGoogle(context) async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential authResult;
    try{
      authResult = await _auth.signInWithCredential(credential);
    }
    catch( PlatformException ){
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Error while signing in to Google account!", style: TextStyle(color: GradientDecoration.getButtonTextColor()),),
        backgroundColor: Colors.yellow,
      ));
    }

    final User user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);
    return user;
  }
  void signOutGoogle() async{
    await googleSignIn.signOut();
    print("User Signed Out");
  }
}