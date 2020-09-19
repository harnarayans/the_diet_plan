import 'package:flutter/material.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/pages/subpages/LoginPageContent.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("The Nutrition Planner", style: TextStyle(color: GradientDecoration.getFontColor()),),
        centerTitle: true,
        backgroundColor: GradientDecoration.getAppBarColor(),
        iconTheme: IconThemeData(
            color:GradientDecoration.getFontColor()
        ),
        actions: <Widget>[
        ],
      ),
      body: LoginPageContent(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
