import 'package:customclaimsapp/pages/home.dart';
import 'package:customclaimsapp/pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customclaimsapp/services/auth.dart';

class Auth extends StatelessWidget {

  const Auth({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<FirebaseUser> userSnapshot;

  @override
  Widget build(BuildContext context) {
    print('AuthWidget is build');
    if(userSnapshot.connectionState == ConnectionState.active){
      return userSnapshot.hasData ? Home(): SignInPage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
