import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Product extends Equatable{
  final String uid;
  final String productName;
  final double productPrice;
  final List<String> urls;

  Product({this.uid, this.productName, this.productPrice, this.urls});

  Product.fromFirestore(Map<String, dynamic> firestore, String uid)
      : productName = firestore['productName'],
        productPrice = firestore['price'],
        uid = uid,
        urls = firestore['imageUrl'];


  @override
  // TODO: implement props
  List<Object> get props => [uid, productName, productPrice, urls];

}

class DummyProduct{
  final String productName;
  final String unitType;
  final double unitPrice;
  final int availableUnits;
  final String vendorId;
  final String productId;
  final String imageUrl;
  final bool approved;
  final String note;

  DummyProduct({@required this.productName,
    this.unitType,
    this.unitPrice,
    @required this.availableUnits,
    @required this.vendorId,
    @required this.productId,
    this.imageUrl = "",
    @required this.approved,
    this.note = ""});

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'unitType': unitType,
      'unitPrice': unitPrice,
      'availableUnits': availableUnits,
      'approved': approved,
      'imageUrl': imageUrl,
      'note': note,
      'productId': productId,
      'vendorId': vendorId,
    };
  }

  DummyProduct.fromFirestore(Map<String, dynamic> firestore)
      : productName = firestore['productName'],
        unitType = firestore['unitType'],
        unitPrice = firestore['unitPrice'],
        availableUnits = firestore['availableUnits'],
        vendorId = firestore['vendorId'],
        productId = firestore['productId'],
        imageUrl = firestore['imageUrl'],
        approved = firestore['approved'],
        note = firestore['note'];

}