import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/models/users/customer_model.dart';
import 'package:flutter/foundation.dart';

class CustomerServices {
  final Customer user;

  CustomerServices({@required this.user}) {
    _streamOfShops().listen((shops) {
      shops.map((shop) {
        shop.reference.collection('products').snapshots().map((query) {
          return query.documents;
        }).map((snapshots) => snapshots.map((snapshot) {
          print('customer services cunstrocter 15');
              Product product = Product.fromFirestore(data: snapshot.data, uid: snapshot.documentID);
              products.add(product);
            }));
      });
    });
  }

  List<Product> products;

  CollectionReference _db = Firestore.instance
      .collection('Custom_claims_app')
      .document('users')
      .collection('shops');

  //methods:
  //1: Fetch all products

  Stream<List<DocumentSnapshot>> _streamOfShops() {
    //listen to stream of shops collection
    //and list the products in each shop
    print('customer services 22 => products function is fired');
    return _db.snapshots().map((query) {
      print('customer services 24 => ${query.documents}');
      return query.documents;
    });
  }
}
