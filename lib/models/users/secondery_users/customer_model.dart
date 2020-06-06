import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:flutter/cupertino.dart';

class Customer{
  final String uid;
  final String email;
  final String claim;
  final String phoneNumber;

  Customer({@required this.uid, @required this.email, @required this.claim,@required this.phoneNumber});

}