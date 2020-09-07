import 'package:flutter/material.dart';

import 'subpages/HomePageContent.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Your Dashboard", style: TextStyle(color: Colors.white70), ),
        centerTitle: true,
        backgroundColor: Color(0XFF6d6875),
        iconTheme: IconThemeData(
            color:Color(0XFFC4BFBF)
        ),
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        }),
        actions: <Widget>[
        ],
      ),
      body: HomePageContent( ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
