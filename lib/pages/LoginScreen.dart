import 'package:flutter/material.dart';
import 'package:thedietplan/pages/subpages/LoginPageContent.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("SignIn/SignUp", style: TextStyle(color: Colors.white70),),
        centerTitle: true,
        backgroundColor: Color(0XFF6d6875),
        iconTheme: IconThemeData(
            color:Color(0XFFC4BFBF)
        ),
        actions: <Widget>[

          Icon(Icons.notifications_none),
        ],
      ),
      body: LoginPageContent(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
