import 'package:customclaimsapp/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customclaimsapp/services/auth.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var auth = Provider.of<AuthService>(context);
    return StreamBuilder<FirebaseUser>(
      stream: auth.checkUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.hasData){
          print(snapshot.data);
        }else{
          print('snapshot dose not have data');
        }
        return Home();
      },
    );
  }
}
