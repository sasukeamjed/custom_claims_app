import 'package:flutter/cupertino.dart';

class Customer{
  final String uid;
  final String email;
  final String phoneNumber;

  Customer({@required this.uid, @required this.email, @required this.phoneNumber}): assert(uid != null && email != null && phoneNumber != null);

}