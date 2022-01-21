import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pharm_app/models/addresses/addresses.dart';
import 'package:pharm_app/models/orders/orders.dart';
import 'package:pharm_app/models/pharmacies/pharmacies.dart';
import 'package:pharm_app/models/products/products.dart';
import 'package:pharm_app/models/users/users.dart';
import 'package:intl/intl.dart';

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
        basket: doc.get('basket'),
        currentSeller: doc.get('currentSeller'),
        amount: doc.get('amount'),
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
      basket: snapshot.get('basket'),
      amount: snapshot.get('amount'),
      currentSeller: snapshot.get('currentSeller'),
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

  Future addFavPharm(String? pid, List<dynamic> liste) async {
    List<dynamic> ids = [];
    for (var i = 0; i < liste.length; i++) {
      ids.add(liste[i]);
    }
    if (!ids.contains(pid)) {
      ids.add(pid!);
    }
    return userCollection.doc(uid).update({'fav_pharms': ids});
  }

  bool favPharmExists (String? pid, List<dynamic> liste) {
    return liste.contains(pid);
  }

  Future addOrderToUser(String id, List<dynamic> pre_orders) async {
    pre_orders.add(id);
    return userCollection.doc(uid).update({'pre_orders': pre_orders});
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

  Future addToBasket(pharmappPharmacy pharm, pharmappProduct product, pharmappUser pUser, num quantity) async {
    String currentSeller = pUser.currentSeller;
    List<dynamic> basket = pUser.basket;
    List<dynamic> amount = pUser.amount;

    if (currentSeller == "") {
      currentSeller = pharm.id;
    }

    if (basket.contains(product.id)) {
      final index = basket.indexWhere((element) => element == product.id);
      amount[index] = amount[index] + quantity;
    } else {
      basket.add(product.id);
      amount.add(quantity);
    }

    return userCollection.doc(uid).update({
      'currentSeller': currentSeller,
      'basket': basket,
      'amount': amount,
    });

  }

  Future changeAmount(List<dynamic> amounts, int index, num newAmount) async {
    amounts[index] = newAmount;
    return userCollection.doc(uid).update({
      'amount': amounts
    });

  }

  Future removeSingleProductFromBasket(List<dynamic> amounts, int index, List<pharmappProduct?> products, String currentSeller) async {
    
    List<dynamic> newAmounts = [0];
    List<String> newIds = [""];
    String newSeller = currentSeller;

    for (var i = 1; i < amounts.length; i++) {
      if (i-1 != index) {
        newAmounts.add(amounts[i]);
        newIds.add(products[i-1]!.id);
      }
    }

    if (newAmounts.length == 1) {
      newSeller = "";
    }

    return userCollection.doc(uid).update({
      'currentSeller': newSeller,
      'basket': newIds,
      'amount': newAmounts
    });
  }

  Future removeAllFromBasket() async {
    return userCollection.doc(uid).update({
      'currentSeller': "",
      'amount': [0],
      'basket': [""],
    });
  }

  Future deleteuser() {
    return userCollection.doc(uid).delete();
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
        ratings: snapshot.get('ratings'),
        comments: snapshot.get('comments'));
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
                ratings: doc.get('ratings'),
                comments: doc.get('comments'));
          }
        })
        .toList()
        .where((element) => element != null));
  }

  Stream<List<pharmappPharmacy?>> get pharms {
    return pharmCollection.snapshots().map(_pharmListFromSnapshot);
  }

  List<pharmappPharmacy?> _pharmListByAddr(QuerySnapshot snapshot) {
    return List<pharmappPharmacy?>.from(snapshot.docs.map((doc) {
      if(doc.get('service_addresses').contains(id)) {
        return pharmappPharmacy(
          id: doc.id,
          name: doc.get('name'),
          service_addresses: doc.get('service_addresses'),
          products: doc.get('products'),
          ratings: doc.get('ratings'),
          comments: doc.get('comments')
        );
      }
    }).toList().where((element) => element != null));
  }

  Stream<List<pharmappPharmacy?>> get pharmsByAddr {
    return pharmCollection.snapshots().map(_pharmListByAddr);
  }

  Future addRating(List<dynamic> existing_rates, num rating) async {
    
    List<dynamic> assignRates = [];

    if(existing_rates[0] == 0) {
      assignRates.add(rating);
    } else {
      for (var i = 0; i < existing_rates.length; i++) {
        assignRates.add(existing_rates[i]);
      }
      assignRates.add(rating);
    }

    return pharmCollection.doc(id).update({
      'ratings': assignRates,
    });  
  }

  Future addComment(String commentid, List<dynamic> pre_comments) async {
    
    List<dynamic> assignComments = [];

    if(pre_comments[0] == "") {
      assignComments.add(commentid);
    } else {
      for (var i = 0; i < pre_comments.length; i++) {
        assignComments.add(pre_comments[i]);
      }
      assignComments.add(commentid);
    }
    
    return pharmCollection.doc(id).update({'comments': assignComments});
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

class DatabaseService_product {
  final String id;
  final List<dynamic> ids;

  DatabaseService_product({required this.id, required this.ids});

  final CollectionReference productsCollection = FirebaseFirestore.instance.collection('products');

  pharmappProduct _productDataFromSnapshot(DocumentSnapshot snapshot) {
    return pharmappProduct(
      id: id,
      name: snapshot.get('name'),
      category: snapshot.get('category'),
      price: double.parse(snapshot.get('price')),
      url: snapshot.get('photo'),
    );
  }

  Stream<pharmappProduct> get productData {
    return productsCollection.doc(id).snapshots().map(_productDataFromSnapshot);
  }

  List<pharmappProduct?> _productListFromSnapshot(QuerySnapshot snapshot) {
    List<pharmappProduct?> result = List<pharmappProduct?>.from(snapshot.docs.map((doc) {
      if (ids.contains(doc.id)) {
        return pharmappProduct(
          id: doc.id,
          name: doc.get('name'),
          category: doc.get('category'),
          price: double.parse(doc.get('price')),
          url: doc.get('photo'),
        );
      }
    }).toList().where((element) => element != null));

    List<pharmappProduct?> returned = [];
    for (var i = 0; i < ids.length; i++) {
      for (var j = 0; j < result.length; j++) {
        if(result[j]!.id == ids[i]) {
          returned.add(result[j]);
        }
      }
    }

    return returned;
  }

  Stream<List<pharmappProduct?>> get products {
    return productsCollection.snapshots().map(_productListFromSnapshot);
  }
  
}

class DatabaseService_order {
  final String id;
  final List<dynamic> ids;

  DatabaseService_order({required this.id, required this.ids});

  final CollectionReference orderCollection = FirebaseFirestore.instance.collection('orders');

  pharmappOrder _orderDataFromSnapshot(DocumentSnapshot snapshot){
    return pharmappOrder(
      id: id,
      pharmid: snapshot.get('pharmid'),
      pharmName: snapshot.get('pharmName'),
      amounts: snapshot.get('amounts'),
      products: snapshot.get('products'),
      prices: snapshot.get('prices'),
      date: DateFormat("dd-MM-yyyy").parse(snapshot.get('date')),
      cost: double.parse(snapshot.get('cost')),
      rated: snapshot.get('rated')
    );
  }

  Stream<pharmappOrder> get orderData {
    return orderCollection.doc(id).snapshots().map(_orderDataFromSnapshot);
  }

  List<pharmappOrder?> _orderListFromSnapshot(QuerySnapshot snapshot) {
    List<pharmappOrder?> result = List<pharmappOrder?>.from(snapshot.docs.map(
      (doc) {
        if (ids.contains(doc.id)) {
          return pharmappOrder(
            id: doc.id,
            pharmid: doc.get('pharmid'),
            pharmName: doc.get('pharmName'),
            amounts: doc.get('amounts'),
            products: doc.get('products'),
            prices: doc.get('prices'),
            date: DateFormat("dd-MM-yyyy").parse(doc.get('date')),
            cost: double.parse(doc.get('cost')),
            rated: doc.get('rated')
          );
        }
      }
    ).toList().where((element) => element != null));

    List<pharmappOrder?> returned = [];

    for (var i = ids.length-1; i > -1; i--) {
      for (var j = 0; j < result.length; j++) {
        if (result[j]!.id == ids[i]) {
          returned.add(result[j]);
        }
      }
    }

    return returned;
  }

  Stream<List<pharmappOrder?>> get orders {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Future markRated() async {
    return orderCollection.doc(id).update({
      'rated': true,
    });
  }
  
}