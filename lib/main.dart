// ignore_for_file: file_names, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/screens/authentication/sign_up.dart';
import 'package:pharm_app/screens/basket/basket.dart';
import 'package:pharm_app/screens/categories/categories.dart';
import 'package:pharm_app/screens/home.dart';
import 'package:pharm_app/screens/profile/profile.dart';
import 'package:pharm_app/screens/walkthrough.dart';
import 'package:pharm_app/utils/colors.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:introduction_screen/introduction_screen.dart'; // onboarding screen


//int? isviewed;
void main() async {

  //WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferences.setMockInitialValues({});
  //SharedPreferences prefs = await SharedPreferences.getInstance();
  //isviewed = prefs.getInt('WalkThrough');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    FirebaseInit()
  );
}

class FirebaseInit extends StatefulWidget {
  const FirebaseInit({ Key? key }) : super(key: key);

  @override
  _FirebaseInitState createState() => _FirebaseInitState();
}

class _FirebaseInitState extends State<FirebaseInit> {
  
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError){
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text(
                  'No Firebase Connection: ${snapshot.error.toString()}',
                ),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return PharMapp();
        }
        
        return MaterialApp(
          home: Center(
            child: Text('Connecting'),
          )
        );
      }
    );
  }
}


class PharMapp extends StatelessWidget {
  const PharMapp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyBottomNavigationBar(),
      routes: {
        '/WalkThrough': (context) => WalkThrough(),
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/categories': (context) => Categories(),
        '/basket': (context) => Basket(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
      },
      initialRoute: '/WalkThrough',
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>
{
  int _currentIndex = 0;
  final List<Widget> _children = [
    Home(),
    Categories(),
    Basket(),
    Login()
  ];

  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.secondary,
        selectedIconTheme: IconThemeData(color: AppColors.secondary),
        unselectedItemColor: AppColors.bodyText,
        unselectedFontSize: 14.0,
        showUnselectedLabels: true,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.shopping_basket),
            label: 'Basket',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.manage_accounts),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
