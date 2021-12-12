import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User?>(context); //use this to check if the user is logged in

    if (user != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
            style: TextStyle(color: AppColors.titleText, fontSize: 26),
          ),
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0.0,
        ),
        body: Padding(
          padding: Dimen.regularPadding,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: null,
                    radius: 60,
                  ),
                  SizedBox(width: 15,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text('${user.displayName}',
                          style: TextStyle(
                            color: AppColors.bodyText,
                            fontSize: 40
                          ),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('${user.email}')
                        ],
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 50,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Change Name and Surname',
                          style: TextStyle(color: AppColors.buttonText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        backgroundColor: AppColors.button,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Change E-mail Address',
                          style: TextStyle(color: AppColors.buttonText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        backgroundColor: AppColors.button,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Change Password',
                          style: TextStyle(color: AppColors.buttonText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        backgroundColor: AppColors.button,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Change Profile Picture',
                          style: TextStyle(color: AppColors.buttonText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        backgroundColor: AppColors.button,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Edit Delivery Addresses',
                          style: TextStyle(color: AppColors.buttonText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        backgroundColor: AppColors.button,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Edit Favourite Pharmacies',
                          style: TextStyle(color: AppColors.buttonText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        backgroundColor: AppColors.button,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: OutlinedButton(
                      onPressed: () {
                        auth.signOut();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Log Out',
                          style: TextStyle(color: AppColors.titleText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                        backgroundColor: Color(0xffE13419),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),),
      );
    }
    else {
      return Login();
    }
  }
}

