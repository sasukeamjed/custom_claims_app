import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/auth_widget_builder.dart';
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
        Provider<AuthService>(
          create: (_)=>AuthService(),
        ),
      ],
      child: MaterialApp(
        home: AuthWidgetBuilder(),
      ),
    );
  }
}

