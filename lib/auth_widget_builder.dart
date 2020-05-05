import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/pages/auth_pages/sign_in_page.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('main auth widget is build');

    final _auth = Provider.of<AuthService>(context);
    return StreamBuilder(
      stream: _auth.creatingUser(),
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot){
//        print(snapshot.hasData);
        final user = snapshot.data;
        if(user != null){
          return   MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Auth(userSnapshot: snapshot,),
          );
        }
        return   MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Auth(userSnapshot: snapshot,),
        );
      },
    );
  }
}
