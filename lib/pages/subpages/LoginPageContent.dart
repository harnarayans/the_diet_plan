import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thedietplan/CustomWidgets/FbLoginButton.dart';
import 'package:thedietplan/CustomWidgets/GoogleLoginButton.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/util/HandleFoodModel.dart';
import 'package:thedietplan/util/sign_in.dart';

class LoginPageContent extends StatefulWidget {
  @override
  _LoginPageContentState createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {

  //  void performLoginAndNavigateToHome(context){
//    LoginModel loginModel = Provider.of<LoginModel>(context, listen:false);
//    if(loginModel.getUserEmail() != null && loginModel.getUserEmail().length > 0){
//      Navigator.pushNamed(context, "/home");
//    }else{
//      sign_in().signInWithGoogle(context).then((value) => {
//        loginModel.setName(value.displayName),
//        loginModel.setUrl(value.photoURL),
//        loginModel.setUserEmail(value.email),
//        initializeFoodModel(context),
//        Navigator.of(context)
//            .pushNamedAndRemoveUntil("/home", (Route<dynamic> route) => false),
//      });
//    }
//  }
//
//  void initializeFoodModel(context) async{
//    final prefs = await SharedPreferences.getInstance();
//    prefs.remove("selectedItems");
//    prefs.remove("consumedItems");
//    String selectedFoods = prefs.getString("selectedItems") ?? "";
//    String consumedFoods = prefs.getString("consumedItems") ?? "";
//    if( selectedFoods.length == 0 && consumedFoods.length ==0){
//      String email = Provider.of<LoginModel>(context, listen: false).email;
//      HandleFoodModel handle = HandleFoodModel(email, prefs: prefs);
//      handle.updateLocalModel(context);
//    }
//  }

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
            GoogleLoginButton().getLoginButton(context),
          ],
        ),
      ),
    );
  }
}