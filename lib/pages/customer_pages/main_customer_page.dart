import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainCustomerPage extends StatelessWidget {

  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Customer Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await _authService.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Text("Main Customer Page"),
      ),
    );
  }
}
