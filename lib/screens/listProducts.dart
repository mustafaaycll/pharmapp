import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:provider/provider.dart';

class listProductScreen extends StatefulWidget {
  const listProductScreen({Key? key}) : super(key: key);

  @override
  _listProductScreenState createState() => _listProductScreenState();
}

class _listProductScreenState extends State<listProductScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    pharmappPharmacy pharm = arguments['pharm'];
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Products',
            style: TextStyle(color: AppColors.titleText, fontSize: 26),
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(child: Text(pharm.name)));
  }
}
