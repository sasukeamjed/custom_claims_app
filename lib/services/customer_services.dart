import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/models/users/customer_model.dart';
import 'package:flutter/foundation.dart';

class CustomerServices {
  final Customer user;

  CustomerServices({@required this.user});

  CollectionReference _db = Firestore.instance
      .collection('Custom_claims_app')
      .document('users')
      .collection('shops');


  //methods:
  //1: Fetch all products

  Stream<List<Stream<List<Product>>>> products() {
    //listen to stream of shops collection
    //and list the products in each shop
    return _db.snapshots().map((query) => query.documents).map((shopsQuery) =>
        shopsQuery.map((shop) =>
            shop.reference.collection('products').snapshots().map((
                query) => query.documents).map((snapshots) => snapshots.map((snapshot) => Product.fromFirestore(snapshot.data, snapshot.documentID)).toList())).toList());
  }
}