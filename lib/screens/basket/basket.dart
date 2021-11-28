import 'package:flutter/material.dart';
import 'package:pharm_app/utils/colors.dart';


class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  _BasketState createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket',
          style: TextStyle(
              color: AppColors.titleText,
              fontSize: 26
          ),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(child: Text('Basket Here')),
    );
  }
}
