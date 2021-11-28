import 'package:flutter/material.dart';
import 'package:pharm_app/screens/basket/basket.dart';
import 'package:pharm_app/screens/categories/categories.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PharMapp',
        style: TextStyle(
            color: AppColors.titleText,
            fontSize: 26
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(child: Text('a')),
    );
  }
}
