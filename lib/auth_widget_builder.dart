import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:customclaimsapp/pages/admin_pages/main_admin_page.dart';
import 'package:customclaimsapp/pages/auth_pages/auth_page.dart';
import 'package:customclaimsapp/pages/auth_pages/sign_in_page.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatefulWidget {
  @override
  _AuthWidgetBuilderState createState() => _AuthWidgetBuilderState();
}

class _AuthWidgetBuilderState extends State<AuthWidgetBuilder> {
  AuthService authService;
  Future getUser;

  @override
  void initState() {
//    authService = Provider.of<AuthService>(context);
//    getUser = authService.getCurrentUser();
    print('init state of AuthWidgetBuilder is fired');

    super.initState();
  }

  @override
  void didChangeDependencies() {
    authService = Provider.of<AuthService>(context);
    getUser = authService.getCurrentUser();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('AuthWidgetBuilder is rebuild');
    return FutureBuilder(
      future: getUser,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (authService.currentUser != null) {
            print(authService.currentUser.claim);
            return Provider.value(
              value: authService.currentUser,
              child: MainAdminPage(),
            );
          }
          return AuthPage();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
