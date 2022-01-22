import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import "package:firebase_auth/firebase_auth.dart";
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/orders/orders.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:pharm_app/services/database.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      
      String url = "";
      
      await FirebaseStorage.instance.ref().child('profilepics/placeholder.png').getDownloadURL().then((value) => {url = value});
      
      await addUser(user.uid, 'Anonym', 'no email address', 'anonym', url);
      return _userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future loginWithMailandPass(String mail, String pass) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User does not exist', style: TextStyle(color: AppColors.titleText),)));
        return null;
      } else if (e.code == "wrong-password") {
        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password', style: TextStyle(color: AppColors.titleText),)));
        return null;
      }
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }
  
  Future googleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = result.user;

    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    if (snapshot == null || !snapshot.exists) {
      addUser(user.uid, user.displayName, user.email, 'google', user.photoURL);
    }
    return _userFromFirebase(user);
  }

  Future facebookSignIn() async {
    final LoginResult faceUser = await FacebookAuth.instance.login();
    final OAuthCredential credential = FacebookAuthProvider.credential(faceUser.accessToken!.token);
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = result.user;
    
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    if (snapshot == null || !snapshot.exists) {
      addUser(user.uid, user.displayName, user.email, 'facebook', user.photoURL);
    }
    return _userFromFirebase(user);
  }


  Future addUser(String id, String? name, String? email, String method,
      String? photo) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    List<String> emptyList = [''];
    await users
        .doc(id)
        .set({
          'id': id,
          'fullname': name,
          'email': email,
          'method': method,
          'profile_pic_url': photo,
          'addresses': emptyList,
          'fav_pharms': emptyList,
          'pre_orders': emptyList,
          'basket': emptyList,
          'amount': [0],
          'currentSeller': "",
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Adding User Failed ${error.toString()}'));
  }

  Future addOrder(String userid, String pharmid, String pharmName, List<dynamic> amounts, List<dynamic> products, List<dynamic> prices, String date, String cost, bool rated, List<dynamic> pre_orders) async {
    
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    CollectionReference orders = FirebaseFirestore.instance.collection('orders');
    String id = await String.fromCharCodes(Iterable.generate(16, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    await orders.doc(id).set({
      'id': id,
      'pharmid': pharmid,
      'pharmName': pharmName,
      'amounts': amounts,
      'products': products,
      'prices': prices,
      'date': date,
      'cost': cost,
      'rated': rated,
    }).then((value) => print("Order Added")).catchError((error) => print('Adding order failed ${error.toString()}'));

    await DatabaseService(uid: userid).addOrderToUser(id, pre_orders);
  }

  Future addComment(String userid, String pharmid, String date, String? comment, num rate, List<dynamic> pre_comments) async {
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    CollectionReference orders = FirebaseFirestore.instance.collection('comments');
    String id = await String.fromCharCodes(Iterable.generate(16, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    await orders.doc(id).set({
      'id': id,
      'comment': comment,
      'date': date,
      'pharm': pharmid,
      'rate': rate,
      'userid': userid,
    });
    await DatabaseService_pharm(id: pharmid, ids: []).addComment(id, pre_comments);
  }

  Future signUp(
      String name, String surname, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      String url = "";
      
      await FirebaseStorage.instance.ref().child('profilepics/placeholder.png').getDownloadURL().then((value) => {url = value});


      addUser(user.uid, name + ' ' + surname, email, "manual", url);
      return 'Signed Up';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future sendPasswordLink(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }

  Future uploadImageToFirebase(pharmappUser? pUser, XFile? image) async {
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('profilepics/${pUser!.id}'); 
    String url = pUser.profile_pic_url;
    try {
      await firebaseStorageRef.putFile(File(image!.path));

      await FirebaseStorage.instance.ref().child('profilepics/${pUser.id}').getDownloadURL().then((value) => {url = value});

      await DatabaseService(uid: pUser.id).updatePP(url);
    } on FirebaseException catch (e) {
      print("${e.message}");
    } catch (e) {
      print("err2");
    }
  }
}