import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainShopPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Shop Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await _auth.logout();
            },
          ),
        ],
      ),
      body: Center(
        child: Consumer<MainUser>(
          builder: (BuildContext context, value, widget){
            return Text("This is the shop of: ${value.email}");
          },
        ),
      ),
    );
  }
}
