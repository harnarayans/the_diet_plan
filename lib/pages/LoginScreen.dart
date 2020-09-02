import 'package:flutter/material.dart';
import 'package:thedietplan/pages/subpages/LoginPageContent.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("SignIn/SignUp"),
        backgroundColor: Color(0XFF1E1E1E),
        iconTheme: IconThemeData(
            color:Color(0XFFC4BFBF)
        ),
        actions: <Widget>[

          Icon(Icons.notifications_none),
          Icon(Icons.search)
        ],
      ),
      body: LoginPageContent(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
