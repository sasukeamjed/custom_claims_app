import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/auth_widget_builder.dart';
import 'package:customclaimsapp/models/users/secondery_users/admin_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/customer_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
import 'package:customclaimsapp/services/admin_services.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:customclaimsapp/services/customer_services.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  return runApp(MyApp());}

class MyApp extends StatelessWidget {
  AuthService _authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(
          create: (context) => _authService.isLoggedIn(),
        ),
        Provider(
          create: (context)=> _authService,
        ),
      ],
      child: MaterialApp(
        home: AuthWidgetBuilder(),
      ),
    );
  }
}
