import 'package:customclaimsapp/models/shop_model.dart';
import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:flutter/cupertino.dart';

//ToDo: Create the add shop function

class ShopOwner extends MainUser {
  final String shopName;
  final String shopOwnerName;
  final String shopOwnerPhoneNumber;
  final String shopLocation;
  final Shop shop;

  ShopOwner(
      {@required uid,
      @required this.shopName,
      @required this.shopOwnerName,
      @required shopOwnerEmail,
      @required claim,
      @required this.shopOwnerPhoneNumber,
      @required this.shopLocation,
      @required this.shop})
      : super(uid: uid, email: shopOwnerEmail, idTokenResult: claim);
}
