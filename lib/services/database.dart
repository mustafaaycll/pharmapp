import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharm_app/models/users/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  //get user streams
  List<pharmappUser> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return pharmappUser(
        id: uid,
        fullname: doc.get('fullname'),
        addresses: doc.get('address'),
        email: doc.get('email'),
        password: doc.get('password'),
        profile_pic_url: doc.get('profile_pic_url'),
        fav_pharms: doc.get('fav_pharms'),
        pre_orders: doc.get('pre_orders'),
      );
    }).toList();
  }

  pharmappUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    print(snapshot.get('fullname'));
    return pharmappUser(
      id: uid,
      fullname: snapshot.get('fullname'),
      email: snapshot.get('email'),
      password: snapshot.get('password'),
      profile_pic_url: snapshot.get('profile_pic_url'),
      addresses: snapshot.get('addresses'),
      fav_pharms: snapshot.get('fav_pharms'),
      pre_orders: snapshot.get('pre_orders'),
    );
  }

  Stream<List<pharmappUser>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  Stream<pharmappUser> get userData {
    return userCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Future updateName(String name) async{
    return userCollection.doc(uid).update({'fullname': name});
  }
}
