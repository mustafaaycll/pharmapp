import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/services/google_sign_in.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass = "";
  String passagain = "";
  String name = "";
  String surname = "";
  late int count;

  AuthService auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text('SignUp'),
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
                            if (value!.isEmpty) {
                              return 'Name cannot be empty!';
                            }
                          },
                          decoration: InputDecoration(
                              fillColor: AppColors.secondary75percent,
                              filled: true,
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondary50percent,
                                ),
                                borderRadius: Dimen.boxBorderRadius,
                              )),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            if (value != null) {
                              name = value;
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
                            if (value!.isEmpty) {
                              return 'Surname cannot be empty';
                            }
                          },
                          decoration: InputDecoration(
                              fillColor: AppColors.secondary75percent,
                              filled: true,
                              hintText: 'Surname',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: AppColors.secondary50percent,
                                ),
                                borderRadius: Dimen.boxBorderRadius,
                              )),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            if (value != null) {
                              surname = value;
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
                            if (value == null) {
                              return 'E-mail field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'E-mail field cannot be empty';
                              }
                              if (!EmailValidator.validate(trimmedValue)) {
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
                              )),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            if (value != null) {
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
                            if (value == null) {
                              return 'Password field cannot be empty';
                            } else {
                              String trimmedValue = value.trim();
                              if (trimmedValue.isEmpty) {
                                return 'Password field cannot be empty';
                              }
                              if (trimmedValue.length < 6) {
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
                            if (value != null) {
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
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.length < 6) {
                              return 'Password length cannot be less than 6.';
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary75percent,
                            filled: true,
                            hintText: 'Password again',
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
                            if (value != null) {
                              passagain = value;
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
                            if (_formKey.currentState!.validate()) {
                              if (pass == passagain) {
                                _formKey.currentState!.save();
                                print('Mail: ' +
                                    mail +
                                    "\nPass: " +
                                    pass +
                                    '\nPass Again: ' +
                                    passagain +
                                    '\nName: ' +
                                    name +
                                    '\nSurname: ' +
                                    surname);
                                auth.signUp(mail, pass);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                        content: Text(
                                  'Successfully signed up.',
                                  style: TextStyle(color: AppColors.titleText),
                                )));
                              } else if (pass != passagain) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Passwords must match!',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                );
                              }
                            }
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
                                borderRadius: Dimen.boxBorderRadius),
                            backgroundColor: AppColors.button,
                          ),
                        ),
                      ),
                      SizedBox(width: 6),
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
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
                                borderRadius: Dimen.boxBorderRadius),
                            backgroundColor: AppColors.secondary,
                          ),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogIn();
                    },
                    icon: FaIcon(FontAwesomeIcons.google),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
