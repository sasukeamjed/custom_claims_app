import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('This is home page'),
            SizedBox(
              height: 25,
            ),
            RaisedButton(
              child: Text('Signout'),
              onPressed: () async{
                await _auth.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
