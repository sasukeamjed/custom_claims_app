import 'package:customclaimsapp/models/shop_model.dart';
import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:flutter/cupertino.dart';

//ToDo: Create the add shop function

class ShopOwner extends MainUser {
  final String shopName;
//  final String shopOwnerName;
  final String phoneNumber;
//  final String shopLocation;
//  final Shop shop;

  ShopOwner(
      {@required uid,
      @required this.shopName,
//      @required this.shopOwnerName,
      @required email,
      @required claim,
      @required this.phoneNumber,
//      @required this.shopLocation,
//      @required this.shop,
      token,})
      : super(uid: uid, email: email, claim: claim,token: token);
}
