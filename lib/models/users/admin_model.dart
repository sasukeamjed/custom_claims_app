import 'package:flutter/cupertino.dart';

class Admin{
  final String uid;
  final String email;
  final String phoneNumber;

  Admin({@required this.uid, @required this.email, @required this.phoneNumber}): assert(uid != null && email != null && phoneNumber != null);

}