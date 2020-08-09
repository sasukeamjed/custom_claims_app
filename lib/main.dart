import 'package:customclaimsapp/auth_widget_builder.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
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
        Provider(
          create: (context)=> _authService,
        ),
        FutureProvider<bool>(
          create: (context) => _authService.checkIfUserLoggedIn(),
        ),
        StreamProvider<Object>(
          create: (context)=> _authService.users,

        ),
      ],
      child: MaterialApp(
        home: AuthWidgetBuilder(),
      ),
    );
  }
}
