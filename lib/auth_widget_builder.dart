

import 'dart:async';

import 'package:customclaimsapp/auth_widget.dart';
import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:customclaimsapp/models/users/secondery_users/admin_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/customer_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
import 'package:customclaimsapp/pages/admin_pages/main_admin_page.dart';
import 'package:customclaimsapp/pages/auth_pages/auth_page.dart';
import 'package:customclaimsapp/services/admin_services.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:customclaimsapp/pages/shop_pages/main_shop_page.dart';
import 'package:customclaimsapp/pages/customer_pages/main_customer_page.dart';
import 'package:customclaimsapp/services/customer_services.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatefulWidget {
  @override
  _AuthWidgetBuilderState createState() => _AuthWidgetBuilderState();
}

class _AuthWidgetBuilderState extends State<AuthWidgetBuilder> {
  StreamSubscription _usersSubscription;

  @override
  void initState() {
    var auth = Provider.of<AuthService>(context);
    _usersSubscription = auth.users.listen((usersServices) {
      if(usersServices == null){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> AuthPage()), (route) => false);
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Object>(context);
    final isLoggedIn = Provider.of<bool>(context);

    print('AuthWidgetBuilder is rebuild with: $user');
    if(isLoggedIn == null){
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    else if(isLoggedIn){
      if(user is AdminService){

      }else if(user is ShopOwnerServices){

      }else if(user is CustomerServices){

      }
    }
    else if(user is AdminService){
      return MainAdminPage();
    }else if(user is ShopOwnerServices){
      return MainShopPage();
    }else if(user is CustomerServices){
      return MainCustomerPage();
    }
    else{
      return AuthPage();
    }
  }

//  @override
//  Widget build(BuildContext context) {
//    print('AuthWidgetBuilder is rebuild');
//    return FutureBuilder(
//      future: getUser,
//      builder: (BuildContext context, AsyncSnapshot snapshot) {
//        if (snapshot.connectionState == ConnectionState.done) {
//          if (snapshot.data != null) {
//            if(snapshot.data is Admin){
//              return Provider<Admin>.value(
//                value: snapshot.data,
//                child: redirect(snapshot.data.claim),
//              );
//            }else if(snapshot.data is ShopOwner){
//              return Provider<ShopOwner>.value(
//                value: snapshot.data,
//                child: redirect(snapshot.data.claim),
//              );
//            }else{
//              return Provider<Customer>.value(
//                value: snapshot.data,
//                child: redirect(snapshot.data.claim),
//              );
//            }
//          }
//          return AuthPage();
//        }
//        return Scaffold(
//          body: Center(
//            child: CircularProgressIndicator(),
//          ),
//        );
//      },
//    );
//  }

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
