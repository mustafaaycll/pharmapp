import 'package:flutter/material.dart';
import 'package:pharm_app/screens/profile/components/app_text_field.dart';
import 'package:pharm_app/utils/dimensions.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.padding / 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Profile Page',
              ),
              AppTextFormField(),
              AppTextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
