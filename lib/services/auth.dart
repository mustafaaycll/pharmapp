import 'dart:ffi';

import "package:firebase_auth/firebase_auth.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/orders/orders.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';

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
      addUser(user!.uid, user.displayName, user.email, 'google', user.photoURL);
    }
    return _userFromFirebase(user);
  }

  Future addUser(String id, String? name, String? email, String method,
      String? photo) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    List<String> a = [''];
    List<String> fp = [''];
    List<String> po = [''];
    await users
        .doc(id)
        .set({
          'id': id,
          'fullname': name,
          'email': email,
          'method': method,
          'profile_pic_url': photo,
          'addresses': a,
          'fav_pharms': fp,
          'pre_orders': po,
        })
        .then((value) => print('User Added'))
        .catchError((error) => print('Adding User Failed ${error.toString()}'));
  }

  Future signUp(
      String name, String surname, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      addUser(user.uid, name + ' ' + surname, email, "manual", '');
      return 'Signed Up';
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future sendPasswordLink(String email) async {
    return await _auth.sendPasswordResetEmail(email: email);
  }
}
