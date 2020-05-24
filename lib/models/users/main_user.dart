import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MainUser{
  final String uid;
  final String email;
  final String claim;
  final String token;

  MainUser({this.uid, this.email, this.claim, this.token}) : assert(uid != null && email != null);

}