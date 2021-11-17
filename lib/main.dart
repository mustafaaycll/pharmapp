import 'package:flutter/material.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/screens/authentication/sign_up.dart';
import 'package:pharm_app/screens/basket/basket.dart';
import 'package:pharm_app/screens/categories/categories.dart';
import 'package:pharm_app/screens/home.dart';
import 'package:pharm_app/screens/profile/profile.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'PharMapp',
      debugShowCheckedModeBanner: false,
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/categories': (context) => Categories(),
        '/basket': (context) => Basket(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
      },
    ),
  );
}
