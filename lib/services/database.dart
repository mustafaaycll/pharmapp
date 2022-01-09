import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/users/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  //  FUNCTIONS RELATED TO USER
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
        method: doc.get('method'),
        profile_pic_url: doc.get('profile_pic_url'),
        fav_pharms: doc.get('fav_pharms'),
        pre_orders: doc.get('pre_orders'),
      );
    }).toList();
  }

  pharmappUser _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return pharmappUser(
      id: uid,
      fullname: snapshot.get('fullname'),
      email: snapshot.get('email'),
      method: snapshot.get('method'),
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

  Future updateName(String name) async {
    return userCollection.doc(uid).update({'fullname': name});
  }

  Future updatePP(String url) async {
    return userCollection.doc(uid).update({'profile_pic_url': url});
  }

  Future removeFavPharm(String? pid, List<pharmappPharmacy?> liste) async {
    List<String> ids = [""];
    for (var i = 0; i < liste.length; i++) {
      if(liste[i]!.id != pid) {
        ids.add(liste[i]!.id);
      }
    }
    return userCollection.doc(uid).update({'fav_pharms': ids});
  }

  // END OF FUNCTIONS RELATED TO USERS
}

class DatabaseService_pharm {
  final String id;
  final List<dynamic> ids;


  DatabaseService_pharm({required this.id, required this.ids});

  final CollectionReference pharmCollection =
      FirebaseFirestore.instance.collection('pharmacies');

  pharmappPharmacy _pharmDataFromSnapshot(DocumentSnapshot snapshot) {
    return pharmappPharmacy(
        id: id,
        name: snapshot.get('name'),
        service_addresses: snapshot.get('service_addresses'),
        products: snapshot.get('products'),
        ratings: snapshot.get('ratings'));
  }

  Stream<pharmappPharmacy> get pharmData {
    return pharmCollection.doc(id).snapshots().map(_pharmDataFromSnapshot);
  }


  List<pharmappPharmacy?> _pharmListFromSnapshot(QuerySnapshot snapshot) {
    return List<pharmappPharmacy?>.from(snapshot.docs.map((doc) {
      if (ids.contains(doc.id)) {
        return pharmappPharmacy(
          id: doc.id,
          name: doc.get('name'),
          service_addresses: doc.get('service_addresses'),
          products: doc.get('products'),
          ratings: doc.get('ratings')
        );
      }
    }).toList().where((element) => element != null));
  }

  Stream<List<pharmappPharmacy?>> get pharms {
    return pharmCollection.snapshots().map(_pharmListFromSnapshot);
  }
}
