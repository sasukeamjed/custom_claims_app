import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/auth_widget_builder.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Object>(
          create: (context) => _authService.users(),
        ),
        ProxyProvider<Object, Object>(
          update: (context, user, service){

          },
        ),
        ChangeNotifierProvider(
          create: (_)=> AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_)=> ShopOwnerServices(),
        ),
      ],
      child: MaterialApp(
        home: AuthWidgetBuilder(),
      ),
    );
  }
}