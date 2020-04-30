import 'package:customclaimsapp/models/shop_model.dart';
import 'package:flutter/cupertino.dart';

//ToDo: Create the add shop function

class ShopOwner{
  final String uid;
  final String shopName;
  final String shopOwnerName;
  final String shopOwnerEmail;
  final String shopOwnerPhoneNumber;
  final String shopLocation;
  final Shop shop;

  ShopOwner({@required this.uid, @required this.shopName, @required this.shopOwnerName, @required this.shopOwnerEmail, @required this.shopOwnerPhoneNumber,@required this.shopLocation, @required this.shop});
}