import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/orders/orders.dart';
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
      if (liste[i]!.id != pid) {
        ids.add(liste[i]!.id);
      }
    }
    return userCollection.doc(uid).update({'fav_pharms': ids});
  }

  Future removeAddress(String? aid, List<pharmappAddress?> liste) async {
    List<String> ids = [""];
    for (var i = 0; i < liste.length; i++) {
      if (liste[i]!.id != aid) {
        ids.add(liste[i]!.id);
      }
    }
    return userCollection.doc(uid).update({'addresses': ids});
  }

  Future addAddress(String? aid, List<pharmappAddress?> liste) async {
    bool exist = false;
    for (var i = 0; i < liste.length; i++) {
      if (liste[i]!.id == aid) {
        exist = true;
        break;
      }
    }
    List<String> ids = [""];
    for (var i = 0; i < liste.length; i++) {
      ids.add(liste[i]!.id);
    }
    if (exist == false) {
      ids.add(aid!);
      print(ids);
    }

    return userCollection.doc(uid).update({'addresses': ids});
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
    return List<pharmappPharmacy?>.from(snapshot.docs
        .map((doc) {
          if (ids.contains(doc.id)) {
            return pharmappPharmacy(
                id: doc.id,
                name: doc.get('name'),
                service_addresses: doc.get('service_addresses'),
                products: doc.get('products'),
                ratings: doc.get('ratings'));
          }
        })
        .toList()
        .where((element) => element != null));
  }

  Stream<List<pharmappPharmacy?>> get pharms {
    return pharmCollection.snapshots().map(_pharmListFromSnapshot);
  }
}

class DatabaseService_address {
  final String id;
  final List<dynamic> ids;

  DatabaseService_address({required this.id, required this.ids});

  final CollectionReference addrsCollection =
      FirebaseFirestore.instance.collection('addresses');

  pharmappAddress _addrsDataFromSnapshot(DocumentSnapshot snapshot) {
    return pharmappAddress(
      id: id,
      city: snapshot.get('city'),
    );
  }

  Stream<pharmappAddress> get addrsData {
    return addrsCollection.doc(id).snapshots().map(_addrsDataFromSnapshot);
  }

  List<pharmappAddress?> _addrsListFromSnapshot(QuerySnapshot snapshot) {
    return List<pharmappAddress?>.from(snapshot.docs
        .map((doc) {
          if (ids.contains(doc.id)) {
            return pharmappAddress(
              id: doc.id,
              city: doc.get('city'),
            );
          }
        })
        .toList()
        .where((element) => element != null));
  }

  Stream<List<pharmappAddress?>> get addrs {
    return addrsCollection.snapshots().map(_addrsListFromSnapshot);
  }

  List<pharmappAddress> _allAddrsFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return pharmappAddress(id: doc.get('id'), city: doc.get('city'));
    }).toList();
  }

  Stream<List<pharmappAddress>> get allAddrs {
    return addrsCollection.snapshots().map(_allAddrsFromSnapshot);
  }
}
