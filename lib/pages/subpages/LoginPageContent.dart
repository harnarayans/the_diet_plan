import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
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
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage("assets/pregnancy_logo.png"),
            ),
            SizedBox(height: 50),
            _signInButton(),
          ],
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        LoginModel loginModel = Provider.of<LoginModel>(context, listen:false);
        sign_in().signInWithGoogle().then((value) => {
              loginModel.setName(value.displayName),
              loginModel.setUrl(value.photoURL),
              loginModel.setUserEmail(value.email),
      });
        Navigator.pushNamed(context, "/home");
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
