import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/services/database.dart';
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

  final _formKey = GlobalKey<FormState>();
  String newName = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(
        context); //use this to check if the user is logged in

    if (user != null) {
      return StreamBuilder<pharmappUser>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {

            pharmappUser? pUser = snapshot.data;

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
              body: SingleChildScrollView(
                child: Padding(
                  padding: Dimen.regularPadding,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Color(0xffe8e8e8),
                            backgroundImage:
                                NetworkImage(pUser!.profile_pic_url),
                            child: user.photoURL == null
                                ? Text(
                                    user.email![0].toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 75,
                                        color: AppColors.bodyText,
                                        fontWeight: FontWeight.w300),
                                  )
                                : null,
                            radius: 60,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    pUser.fullname,
                                    style: TextStyle(
                                        color: AppColors.bodyText,
                                        fontSize: 25),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [Text(pUser.email)],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () async {
                                await changeNamePopUp(context);
                                DatabaseService(uid: pUser.id).updateName(newName);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Change Name and Surname',
                                  style: TextStyle(color: AppColors.buttonText),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: Dimen.boxBorderRadius),
                                backgroundColor: AppColors.button,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Change Password',
                                  style: TextStyle(color: AppColors.buttonText),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: Dimen.boxBorderRadius),
                                backgroundColor: AppColors.button,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Change Profile Picture',
                                  style: TextStyle(color: AppColors.buttonText),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: Dimen.boxBorderRadius),
                                backgroundColor: AppColors.button,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Edit Delivery Addresses',
                                  style: TextStyle(color: AppColors.buttonText),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: Dimen.boxBorderRadius),
                                backgroundColor: AppColors.button,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Edit Favourite Pharmacies',
                                  style: TextStyle(color: AppColors.buttonText),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: Dimen.boxBorderRadius),
                                backgroundColor: AppColors.button,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () {
                                auth.signOut();
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Text(
                                  'Log Out',
                                  style: TextStyle(color: AppColors.titleText),
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: Dimen.boxBorderRadius),
                                backgroundColor: Color(0xffE13419),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      return Login();
    }
  }

  Future<dynamic> changeNamePopUp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.titleText,
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null)
                              return "Field is empty";
                            else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return "Field is empty";
                              }
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              fillColor: AppColors.secondary75percent,
                              filled: true,
                              hintText: 'Type new name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondary50percent,
                                ),
                                borderRadius: Dimen.boxBorderRadius,
                              )),
                          onSaved: (value) {
                            if (value != null) {
                              newName = value;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Navigator.pop(context);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: Text(
                                    'Submit',
                                    style:
                                        TextStyle(color: AppColors.buttonText),
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: Dimen.boxBorderRadius),
                                  backgroundColor: AppColors.button,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
