// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/screens/authentication/login.dart';
import 'package:pharm_app/services/auth.dart';
import 'package:pharm_app/services/database.dart';
import 'package:pharm_app/utils/colors.dart';
import 'package:pharm_app/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKeyPharmCreation = GlobalKey<FormState>();
  String pharmName = "";
  static final ValueNotifier<List<String>> servNotifier = ValueNotifier([""]);
  static final ValueNotifier<bool> pharmCreationNotifier = ValueNotifier(false);
  List<String> servAddresses = [""];
  bool approvedPharmCreation = false;
  
  void _addCityId(String id) {
    servAddresses.add(id);
    servNotifier.value = servAddresses;
    servNotifier.notifyListeners();
  }

  void _removeCityId(String id) {
    servAddresses.removeWhere((element) => element == id);
    servNotifier.value = servAddresses;
    servNotifier.notifyListeners();
  }

  void _setApproval(bool val){
    approvedPharmCreation = true;
    pharmCreationNotifier.value = approvedPharmCreation; 
  }


  AuthService auth = AuthService();

  final _formKey = GlobalKey<FormState>();
  String newName = "";

  final _formKeyDelete = GlobalKey<FormState>();
  bool approvedDeletion = false;

  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context); //use this to check if the user is logged in
    return StreamBuilder<pharmappUser>(
      stream: DatabaseService(uid: user!.uid).userData,
      builder: (context, snapshot) {
        pharmappUser? pUser = snapshot.data;
        
        if (pUser != null) {
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
                              NetworkImage(pUser.profile_pic_url),
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
                              if (newName != "") {
                                DatabaseService(uid: pUser.id)
                                    .updateName(newName);
                                newName = "";
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Change Name and Surname',
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () async {
                              await changePasswordPopUp(
                                  context, pUser.method);
                              if (pUser.method == "manual") {
                                AuthService().sendPasswordLink(pUser.email);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Change Password',
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () async {
                              await pickImage();
                              await AuthService()
                                  .uploadImageToFirebase(pUser, _image);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Change Profile Picture',
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editDelAddr');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Edit Delivery Addresses',
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/editFavPharms');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Edit Favourite Pharmacies',
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
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editBookmarks');
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Manage Bookmarks',
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
                    SizedBox(
                      height: 5,
                    ),
                    pUser.ownership == "" ?
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () async {
                              await createPharmPopUp(context, pUser.id);
                              print("Approve is: $approvedPharmCreation");
                              if (approvedPharmCreation) {
                                await AuthService().createPharm(pUser.id, pharmName, servAddresses);
                              }
                              setState(() {
                                pharmName = "";
                                servAddresses = [];
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Create Your Pharmacy',
                                style:
                                    TextStyle(color: AppColors.titleText),
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
                    ) : 
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Manage Your Pharmacy',
                                style:
                                    TextStyle(color: AppColors.titleText),
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
                    pUser.email != "no email address" ?
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              auth.signOut();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Log Out',
                                style:
                                    TextStyle(color: AppColors.titleText),
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
                    ) :
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () {
                              auth.signOut();

                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Log In',
                                style:
                                    TextStyle(color: AppColors.titleText),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: Dimen.boxBorderRadius),
                              backgroundColor: AppColors.secondary,
                            ),
                          ),
                        ),
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
                              await deletePopUp(context);
                              if (approvedDeletion == true) {
                                await DatabaseService(uid: pUser.id).deleteuser();
                                await user.delete();
                                setState(() {
                                  approvedDeletion = false;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0),
                              child: Text(
                                'Delete Account',
                                style:
                                    TextStyle(color: AppColors.titleText),
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
                  ],
                ),
              ),
            ),
          );
        } else {
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
            body: Center(
              child: Text(
                'Connecting',
                style: TextStyle(color: AppColors.bodyText, fontSize: 30),
              ),
            ),
          );
        }
      }
    );
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
      }
    );
  }

  Future<dynamic> changePasswordPopUp(BuildContext context, String mode) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        if (mode != "manual") {
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
                          child: Center(
                              child: Text(
                            'You logged in with ${mode[0].toUpperCase()+mode.substring(1)} sign-in method, password cannot be changed',
                            textAlign: TextAlign.center,
                          ))),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return AlertDialog(
            backgroundColor: AppColors.titleText,
            content: Stack(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                            'Password reset link has been sent to your email',
                            textAlign: TextAlign.center,
                          ))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      }
    );
  }

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<dynamic> deletePopUp(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.titleText,
          content: Stack(
            children: <Widget>[
              Form(
                key: _formKeyDelete,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(children: [
                          Text(
                            'You are about to delete your account permanently. This process cannot be undone!\n\nDo you wish to continue with deletion?',
                            textAlign: TextAlign.center,
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
                                    _formKeyDelete.currentState!.save();
                                    setState(() {
                                      approvedDeletion = false;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("No", style: TextStyle(color: Colors.white),),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: Dimen.boxBorderRadius),
                                    backgroundColor: AppColors.button,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                flex: 1,
                                child: OutlinedButton(
                                  onPressed: () {
                                    _formKeyDelete.currentState!.save();
                                    setState(() {
                                      approvedDeletion = true;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: Text("Yes", style: TextStyle(color: Colors.white),),
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: Dimen.boxBorderRadius),
                                    backgroundColor: Color(0xffE13419),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ])),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  Future<dynamic> createPharmPopUp(BuildContext context, String userid) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Stack(
            children: <Widget>[
              Form(
                key: _formKeyPharmCreation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Lets start by choosing a name!", textAlign: TextAlign.center,)
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.network('http://www.aeo.org.tr/Helpers/DuyuruIcon.ashx?yayinyeri=sayfaicerik&Id=36690'),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return "Name cannot be empty";
                          } else {
                            String trimmedValue = value.trim();
                            if (trimmedValue.isEmpty) {
                              return "Name cannot be empty";
                            }
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Type Pharmacy's Name",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.secondary50percent,
                            ),
                            borderRadius: Dimen.boxBorderRadius,
                          )
                        ),
                        onSaved: (value) {
                          if (value != null) {
                            pharmName = value;
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: OutlinedButton(
                              onPressed: () async {
                                if (_formKeyPharmCreation.currentState!.validate()) {
                                  _formKeyPharmCreation.currentState!.save();
                                  Navigator.pop(context);
                                  await selectCityPopUp(context, userid);
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Text('Next',
                                  style: TextStyle(
                                    color: AppColors.buttonText
                                  ),
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
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }

  Future<dynamic> selectCityPopUp(BuildContext context, String userid) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: ValueListenableBuilder<List<String>>(
            valueListenable: servNotifier,
            builder: (context, servNotifier, __) {
              return Container(
                height: 400,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Please, choose service addresses", textAlign: TextAlign.center,),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 285,
                      width: 300,
                      child: StreamBuilder<List<pharmappAddress?>>(
                        stream: DatabaseService_address(id: "", ids: []).allAddrs,
                        builder: (context, snapshot) {
                          List<pharmappAddress?>? addrs = snapshot.data;
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: addrs!.length,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        child: ListTile(
                                          onTap: () {},
                                          title: Text(addrs[index]!.city),
                                          leading: servNotifier.contains(addrs[index]!.id) ?
                                          IconButton(
                                            onPressed: () {
                                              _removeCityId(addrs[index]!.id);
                                            },
                                            icon: Icon(Icons.check_box_outlined, color: AppColors.button,),
                                          ) :
                                          IconButton(
                                            onPressed: () {
                                              _addCityId(addrs[index]!.id);
                                            },
                                            icon: Icon(Icons.check_box_outline_blank),
                                          )
                                        ),
                                      );
                                    }
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () async {
                              Navigator.pop(context);
                              await createPharmPopUp(context, userid);
                            },
                            child: Text("Back",style: TextStyle(color: AppColors.bodyText),),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: Dimen.boxBorderRadius),
                              backgroundColor: AppColors.titleText,
                            ),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                            onPressed: () async {
                              await AuthService().createPharm(userid, pharmName, servNotifier);
                              Navigator.pop(context);
                            },
                            child: Text("Finish",style: TextStyle(color: AppColors.titleText),),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: Dimen.boxBorderRadius),
                              backgroundColor: AppColors.button,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          ),
        );
      }
    );
  }
}
