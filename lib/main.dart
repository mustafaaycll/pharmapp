// ignore_for_file: file_names, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/screens/authentication/sign_up.dart';
import 'package:pharm_app/screens/basket/basket.dart';
import 'package:pharm_app/screens/categories/categories.dart';
import 'package:pharm_app/screens/home.dart';
import 'package:pharm_app/screens/profile/profile.dart';
import 'package:pharm_app/utils/colors.dart';

void main()
{
  //kod ekle 
  runApp(
    PharMapp()
  );
}

class PharMapp extends StatelessWidget {
  const PharMapp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: MyBottomNavigationBar(),
      routes: {
        '/home': (context) => Home(),
        '/profile': (context) => Profile(),
        '/categories': (context) => Categories(),
        '/basket': (context) => Basket(),
        '/login': (context) => Login(),
        '/signup': (context) => SignUp(),
      },
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