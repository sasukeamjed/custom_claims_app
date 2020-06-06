import 'package:customclaimsapp/models/shop_model.dart';
import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:flutter/cupertino.dart';

//ToDo: Create the add shop function

class ShopOwner{
  final String uid;
  final String email;
  final String claim;
  final String token;
  final String shopName;
  final String shopOwnerName;
  final String phoneNumber;
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
      this.token,});
}
