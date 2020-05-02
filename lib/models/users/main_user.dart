import 'package:flutter/cupertino.dart';

@immutable
class MainUser{
  final String uid;
  final String email;
  final String claim;

  MainUser({this.uid, this.email, this.claim}) : assert(uid != null && email != null);
}