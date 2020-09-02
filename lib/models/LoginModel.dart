import 'package:flutter/cupertino.dart';

class LoginModel extends ChangeNotifier{
  String name;
  String email;
  String phoneNumber;
  String photoUrl;
  void setUserEmail(email){
    this.email = email;
    notifyListeners();
  }
  void setName(name){
    this.name = name;
  }
  void setUrl(url){
    this.photoUrl = url;
  }
  String getUserEmail(){
    return this.email;
  }
}