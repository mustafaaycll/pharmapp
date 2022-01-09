import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:provider/provider.dart';

class listPharmsScreen extends StatefulWidget {
  const listPharmsScreen({Key? key}) : super(key: key);

  @override
  _listPharmsScreenState createState() => _listPharmsScreenState();
}

class _listPharmsScreenState extends State<listPharmsScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pharmacies',
          style: TextStyle(color: AppColors.titleText, fontSize: 26),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(child: Text(arguments['aid'])),
    );
  }
}
