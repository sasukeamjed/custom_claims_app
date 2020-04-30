import 'package:customclaimsapp/pages/admin_pages/main_admin_page.dart';
import 'package:customclaimsapp/pages/home.dart';
import 'package:customclaimsapp/pages/auth_pages/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customclaimsapp/services/auth.dart';

class Auth extends StatelessWidget {

  const Auth({Key key, @required this.userSnapshot}) : super(key: key);
  final AsyncSnapshot<FirebaseUser> userSnapshot;

  @override
  Widget build(BuildContext context) {
    if(userSnapshot.connectionState == ConnectionState.active){
      return userSnapshot.hasData ? getClaim(context, getClaims(userSnapshot)): SignInPage();
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Future<Map<dynamic, dynamic>> getClaims(AsyncSnapshot<FirebaseUser> userSnapshot) async{
    IdTokenResult result = await userSnapshot.data.getIdToken();
    return result.claims;
  }
}

Widget getClaim(BuildContext context, Future func){
  return FutureBuilder(
    future: func,
    builder: (context, snapshot){

      if(snapshot.hasData){
        print('it has data');
      }
      if(snapshot.connectionState == ConnectionState.active){
        print(snapshot.data['phone_number']);
        return MainAdminPage();
      }
      return MainAdminPage();
    },
  );
}


