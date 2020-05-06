import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MainUser{
  final String uid;
  final String email;
  final String claims;

  MainUser({this.uid, this.email, this.claims}) : assert(uid != null && email != null);

}