import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHandler{
  SharedPreferences pref;
  void writeToLocalStorage(String key, String value)async {
    if(pref == null){
      pref = await SharedPreferences.getInstance();
    }
    pref.setString(key, value);
  }
  Future<String> readFromLocalStorage(String key)async {
    if(pref == null){
      pref = await SharedPreferences.getInstance();
    }
    return pref.getString(key);
  }
}