import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/CustomWidgets/FbLoginButton.dart';
import 'package:thedietplan/CustomWidgets/GoogleLoginButton.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/util/sign_in.dart';

class LoginPageContent extends StatefulWidget {
  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginModel(),
      child: Container(
        decoration: GradientDecoration.getDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 5,
              margin: EdgeInsets.all(18),
              child: Image(
                image: AssetImage("assets/diet_Plan.jpg"),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 70,),
            GoogleLoginButton.getLoginButton(context),
          ],
        ),
      ),
    );
  }
}