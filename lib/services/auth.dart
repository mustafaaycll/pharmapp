import "package:firebase_auth/firebase_auth.dart";

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
    }
    catch (e) {
      return null;
    }
  }

  Future<void> loginWithMailandPass(String mail, String pass) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
    } 
    on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {

        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User does not exist', style: TextStyle(color: AppColors.titleText),)));

      }
      else if (e.code == "wrong-password") {

        //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Wrong password', style: TextStyle(color: AppColors.titleText),)));

      }
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    }
    catch (e) {
      return null;
    }
  }


}