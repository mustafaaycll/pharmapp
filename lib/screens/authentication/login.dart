import 'dart:convert';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/screens/profile/profile.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>
{
  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass = "";

  AuthService auth = AuthService();

  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User?>(context);
    
    if (user == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Login',
            style: TextStyle(color: AppColors.titleText, fontSize: 26),
          ),
          backgroundColor: AppColors.primary,
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Padding(
          padding: Dimen.regularPadding,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'PharMapp',
                          style: TextStyle(
                            color: AppColors.bodyText,
                            fontWeight: FontWeight.w700,
                            fontSize: 50,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            validator: (value) {
                            if(value == null) {
                              return 'E-mail field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if(trimmedValue.isEmpty) {
                                return 'E-mail field cannot be empty';
                              }
                              if(!EmailValidator.validate(trimmedValue)) {
                                return 'Please enter a valid email';
                              }
                            }
                            return null;
                          },
                            decoration: InputDecoration(
                              fillColor: AppColors.secondary75percent,
                              filled: true,
                              hintText: 'E-mail',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondary50percent,

                                ),
                                borderRadius: Dimen.boxBorderRadius,
                              )
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (value) {
                              if(value != null) {
                                mail = value;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            validator: (value) {
                            if(value == null) {
                              return 'Password field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if(trimmedValue.isEmpty) {
                                return 'Password field cannot be empty';
                              }
                              if(trimmedValue.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                            }
                            return null;
                          },
                            decoration: InputDecoration(
                              fillColor: AppColors.secondary75percent,
                              filled: true,
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondary75percent,
                                ),
                                borderRadius: Dimen.boxBorderRadius,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            onSaved: (value) {
                              if(value != null) {
                                pass = value;
                              }
                              },
                          ),
                        )
                      ],
                    ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Sign Up',
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
                    SizedBox(width:6),
                    Expanded(
                      flex: 1,
                      child: OutlinedButton(
                        onPressed: () {
                          if(_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            auth.loginWithMailandPass(mail, pass);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Logging In...', style: TextStyle(color: AppColors.titleText),)));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Login',
                            style: TextStyle(color: AppColors.buttonText),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                          borderRadius: Dimen.boxBorderRadius
                        ),
                          backgroundColor: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60,),
                Text('TRY USING:\n\nmustafayucel@sabanciuniv.edu\n\nWITH THE PASSWORD:\n\nmustafa123A\n\nIN ORDER TO\nVIEW PROFILE\nPAGE')
                ],
              ),
            ),
        ),
          ),
        ),
      );
    }

    else {
      return Profile();
    }
  }
}