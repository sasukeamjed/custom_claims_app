import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/auth_widget_builder.dart';
import 'package:customclaimsapp/pages/auth_pages/sign_in_page.dart';
import 'package:customclaimsapp/pages/auth_pages/sign_up_page.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_)=> AuthService(),
        ),
      ],
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/login_screen': (BuildContext context) => SignInPage(),
          '/signup_screen': (BuildContext context)=> SignUpPage(),
        },
        home: AuthWidgetBuilder(),
      ),
    );
  }
}