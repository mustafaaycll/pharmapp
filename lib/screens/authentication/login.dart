import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pharm_app/utils/colors.dart';


/*class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}*/

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String mail = "";
  String pass = "";
  late int count;

  void initState() {
    // TODO: implement initState
    super.initState();
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN',
          style: TextStyle(color: AppColors.titleText),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
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
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary75percent,
                            filled: true,
                            hintText: 'E-mail',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondary50percent,

                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
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
                          decoration: InputDecoration(
                            fillColor: AppColors.secondary75percent,
                            filled: true,
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.secondary75percent,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: AppColors.buttonText),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
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
                          print('Mail: '+mail+"\nPass: "+pass);
                          _formKey.currentState!.save();
                          print('Mail: '+mail+"\nPass: "+pass);
                          setState(() {
                            count+=1;
                          });
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
                        backgroundColor: AppColors.secondary,
                      ),
                    ),
                  )
                ],
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