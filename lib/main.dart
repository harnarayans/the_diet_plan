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
        appBar: new AppBar(title: Text("The Pregnancy App"),),
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
        title: 'The Pregnancy App',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
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