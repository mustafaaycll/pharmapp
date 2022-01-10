// ignore_for_file: file_names, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/screens/authentication/sign_up.dart';
import 'package:pharm_app/screens/basket/basket.dart';
import 'package:pharm_app/screens/categories/categories.dart';
import 'package:pharm_app/screens/home.dart';
import 'package:pharm_app/screens/listPharms.dart';
import 'package:pharm_app/screens/listProducts.dart';
import 'package:pharm_app/screens/profile/editDelAddrScreen.dart';
import 'package:pharm_app/screens/profile/editFavPharmScreen.dart';
import 'package:pharm_app/screens/profile/profile.dart';
import 'package:pharm_app/screens/walkthrough.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/utils/colors.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:introduction_screen/introduction_screen.dart'; // onboarding screen


int? initScreen;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
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
                  'No Firebase Connection\n'+'${snapshot.error.toString()}',
                  style: TextStyle(color: AppColors.titleText, fontSize: 30),
                ),
              ),
            backgroundColor: AppColors.primary,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return PharMapp();
        }
        
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: Text(
                'Connecting',
                style: TextStyle(color: AppColors.titleText, fontSize: 30),
              ),
            ),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    );
  }
}


class PharMapp extends StatelessWidget {
  const PharMapp({ Key? key }) : super(key: key);

  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
      value: AuthService().user,
      initialData: null,
      child: new MaterialApp(
        navigatorObservers: <NavigatorObserver>[observer],
        home: MyBottomNavigationBar(analytics: analytics, observer: observer,),
        routes: {
          '/WalkThrough': (context) => WalkThrough(analytics: analytics, observer: observer,),
          '/navigationBar': (context) =>  MyBottomNavigationBar(analytics: analytics, observer: observer,),
          '/home': (context) => Home(),
          '/profile': (context) => Profile(),
          '/categories': (context) => Categories(),
          '/basket': (context) => Basket(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/editFavPharms': (context) => editFavPharmScreen(),
          '/editDelAddr': (context) => editDelAddrScreen(),
          '/listPharms': (context) => listPharmsScreen(),
          '/listProducts': (context) => listProductScreen(),
        },
        initialRoute: initScreen == 0 || initScreen == null ? '/WalkThrough' : "/navigationBar",
      ),
    );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key, required this.analytics, required this.observer}) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar>
{
  int _currentIndex = 0;

  List<String> pages = <String>['Home Page', 'Categories', 'Basket', 'Account'];


  final List<Widget> _children = [
    Home(),
    Categories(),
    Basket(),
    Profile(),
  ];

  Future<void> _setCurrentScreen(String page, User? user) async {
    await widget.analytics.setCurrentScreen(screenName: page, screenClassOverride: page.toUpperCase());

    if (user != null) {
      await widget.analytics.setUserId('${user.getIdToken()}');
    }
    else {
      await widget.analytics.setUserId('Anonymous');
    }
  }

  void onTappedBar(int index)
  {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.secondary,
        selectedIconTheme: IconThemeData(color: AppColors.secondary),
        unselectedItemColor: AppColors.bodyText,
        unselectedFontSize: 14.0,
        showUnselectedLabels: true,
        onTap: (int index) {
          onTappedBar(index);
          _setCurrentScreen(pages[index], user);
        },
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
