

import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:customclaimsapp/models/users/secondery_users/admin_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/customer_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
import 'package:customclaimsapp/pages/admin_pages/main_admin_page.dart';
import 'package:customclaimsapp/pages/auth_pages/auth_page.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:customclaimsapp/pages/shop_pages/main_shop_page.dart';
import 'package:customclaimsapp/pages/customer_pages/main_customer_page.dart';


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
          print(snapshot.data is ShopOwner);
          if (snapshot.data != null) {
            print('This is the claim: ${snapshot.data.claim}');
            if(snapshot.data is Admin){
              return Provider<Admin>.value(
                value: snapshot.data,
                child: redirect(snapshot.data.claim),
              );
            }else if(snapshot.data is ShopOwner){
              return Provider<ShopOwner>.value(
                value: snapshot.data,
                child: redirect(snapshot.data.claim),
              );
            }else{
              return Provider<Customer>.value(
                value: snapshot.data,
                child: redirect(snapshot.data.claim),
              );
            }
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

  Widget redirect(String claim){
    if(claim == 'admin'){
      return MainAdminPage();
    }
    else if(claim == 'shop'){
      return MainShopPage();
    }
    return MainCustomerPage();
  }
}
