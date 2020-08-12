import 'package:flutter/cupertino.dart';

@immutable

class Admin {
  final String uid;
  final String email;
  final String claim;
  final token;
  final String phoneNumber;

  Admin({@required this.uid, @required this.email, @required this.claim, @required this.phoneNumber, this.token});

  Map<String, dynamic> toMap(){
    return {
      'uid' : uid,
      'email' : email,
      'claim' : claim,
      'phoneNumber' : phoneNumber,
    };
  }
}
