import 'package:flutter/material.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/styles.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    Key? key,
    required this.isClicked,
    required this.name,
  }) : super(key: key);

  final bool isClicked;
  final String name;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            width: 1,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(
          isClicked ? AppColors.primary : AppColors.primary,
        ),
      ),
      onPressed: () {},
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
