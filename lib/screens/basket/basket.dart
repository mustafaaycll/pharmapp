import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user != null) {
      return StreamBuilder<pharmappUser>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            pharmappUser? pUser = snapshot.data;
            if (pUser != null) {
              List<dynamic> basket = pUser.basket;

              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Basket',
                    style: TextStyle(
                      color: AppColors.titleText,
                      fontSize: 26,
                    ),
                  ),
                  centerTitle: true,
                  backgroundColor: AppColors.primary,
                  elevation: 0.0,
                ),
                body: null,
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Basket',
                    style: TextStyle(color: AppColors.titleText, fontSize: 26),
                  ),
                  centerTitle: true,
                  backgroundColor: AppColors.primary,
                  elevation: 0.0,
                ),
                body: Center(
                  child: Text(
                    'Connecting',
                    style: TextStyle(color: AppColors.bodyText, fontSize: 30),
                  ),
                ),
              );
            }
          });
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Basket',
            style: TextStyle(color: AppColors.titleText, fontSize: 26),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0.0,
        ),
        body: Center(
          child: Text(
            'No User Logged In',
            style: TextStyle(color: AppColors.bodyText, fontSize: 30),
          ),
        ),
      );
    }
  }
}
