import 'package:flutter/cupertino.dart';

class Customer{
  final String uid;
  final String email;
  final String claim;
  final String phoneNumber;

  Customer({@required this.uid, @required this.email, @required this.claim,@required this.phoneNumber});

  @override
  String toString() {
    return 'Customer Instance {uid: $uid, email: $email, claim: $claim, phoneNumber: $phoneNumber}';
  }
}