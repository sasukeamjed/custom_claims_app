import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Product extends Equatable{
  final String uid;
  final String productName;
  final double productPrice;
  final List<String> urls;

  Product({this.uid, this.productName, this.productPrice, this.urls});

  Product.fromFirestore(Map<String, dynamic> data, String uid)
      : productName = data['productName'],
        productPrice = data['price'],
        uid = uid,
        urls = data['imagesUrls'];


  @override
  // TODO: implement props
  List<Object> get props => [uid, productName, productPrice, urls];

}

