import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:flutter/cupertino.dart';

class Customer extends MainUser{

  final String phoneNumber;

  Customer({@required uid, @required email, @required claim,@required this.phoneNumber}): super(uid: uid, email: email, claim: claim);

}