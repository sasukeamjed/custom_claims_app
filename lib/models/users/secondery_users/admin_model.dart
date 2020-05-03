import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:flutter/cupertino.dart';

class Admin extends MainUser {

  final String phoneNumber;

  Admin({@required uid, @required email, @required claim, @required this.phoneNumber}) : super(uid: uid, email: email, idTokenResult: claim);

}
