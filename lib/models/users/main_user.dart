import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

@immutable
class MainUser{
  final String uid;
  final String email;
  final Future<IdTokenResult> getIdTokenResult;
  Map<dynamic, dynamic> map;

  MainUser({this.uid, this.email, this.getIdTokenResult}) : assert(uid != null && email != null);

  Future<Map<dynamic, dynamic>> getClaim() async{
    final idTokenResult = await getIdTokenResult;
    map = idTokenResult.claims;
  }
}