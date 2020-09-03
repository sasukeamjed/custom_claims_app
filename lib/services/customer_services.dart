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
    print('customer services 23 => products function is fired');
    return _db.snapshots().map((query) {
      print('customer services 25 => ${query.documents}');
      return query.documents;}).map((shopsQuery) =>
        shopsQuery.map((shop) {
          print('customer services 28 => ${shop.data}');
          return
            shop.reference.collection('products').snapshots().map((
                query) => query.documents).map((snapshots) => snapshots.map((snapshot) {
                  print('customer services 32 => ${snapshot.data}');
                  return Product.fromFirestore(snapshot.data, snapshot.documentID);}).toList());}).toList());
  }
}