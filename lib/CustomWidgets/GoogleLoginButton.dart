import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/CustomWidgets/Dialogs.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/util/sign_in.dart';
import 'package:clay_containers/clay_containers.dart';
final GlobalKey<State> _keyLoader = new GlobalKey<State>();
class GoogleLoginButton{

  static Widget getLoginButton (context) {
    return FlatButton(
      onPressed: () {
        LoginModel loginModel = Provider.of<LoginModel>(context, listen:false);
        if(loginModel.getUserEmail() != null && loginModel.getUserEmail().length > 0){
          Navigator.pushNamed(context, "/home");
        }else{
          sign_in().signInWithGoogle().then((value) => {
            loginModel.setName(value.displayName),
            loginModel.setUrl(value.photoURL),
            loginModel.setUserEmail(value.email),
            Navigator.pushNamed(context, "/home")
          });
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: ClayContainer(
        color: Color(0xffffcdb2),
        depth: 40,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0,),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff6d6875),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
