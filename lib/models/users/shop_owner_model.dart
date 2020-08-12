import 'package:customclaimsapp/models/product_model.dart';
import 'package:flutter/cupertino.dart';


class ShopOwner{
  final String uid;
  final String email;
  final String claim;
  final String token;
  final String shopName;
  final String shopOwnerName;
  final String phoneNumber;
  final List<Product> products;
//  final String shopLocation;
//  final Shop shop;

  ShopOwner(
      {@required this.uid,
      @required this.shopName,
      @required this.shopOwnerName,
      @required this.email,
      @required this.claim,
      @required this.phoneNumber,
//      @required this.shopLocation,
//      @required this.shop,
      @required this.products,
      this.token,});

  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'email' : email,
      'claim' : claim,
      'phoneNumber' : phoneNumber,
      'shopName' : shopName,
      'shopOwnerName' : shopOwnerName,
    };
  }
}
