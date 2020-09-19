import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';

import 'Pages/CreateDietChart.dart';
import 'Pages/LoginScreen.dart';
import 'Pages/TrackFood.dart';
import 'models/FoodModel.dart';
import 'models/LoginModel.dart';
import 'pages/HomePage.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return SomethingWentWrong();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MyApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Loading();
      },
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(title: Text("The Nutritions Planner"),),
        backgroundColor: Color(0XFFD569A8),
        body: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                JumpingDotsProgressIndicator(
                  fontSize: 40.0,
                  color: Colors.blueAccent,
                  numberOfDots: 5,
                ),
              ]
          ),
        ),
      ),
    );
  }
}

class SomethingWentWrong extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<LoginModel>(
          create: (context) => LoginModel(),
        ),
        ListenableProvider<FoodModel>(
          create: (context) => FoodModel(),
        )
      ],
      child: MaterialApp(
        title: 'The Nutritions Planner',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          "/": (context) => LoginScreen(),
          '/home': (context) => HomePage(),
          '/food': (context) => TrackFood(),
          '/createDiet': (context) => CreateDietChart(),
        },
      ),
    );
  }
}