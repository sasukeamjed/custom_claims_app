import 'dart:async';

import 'package:customclaimsapp/pages/admin_pages/main_admin_page.dart';
import 'package:customclaimsapp/pages/auth_pages/auth_page.dart';
import 'package:customclaimsapp/services/admin_services.dart';
import 'package:customclaimsapp/services/auth.dart';
import 'package:customclaimsapp/pages/shop_pages/main_shop_page.dart';
import 'package:customclaimsapp/pages/customer_pages/main_customer_page.dart';
import 'package:customclaimsapp/services/customer_services.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthWidgetBuilder extends StatefulWidget {
  @override
  _AuthWidgetBuilderState createState() => _AuthWidgetBuilderState();
}

class _AuthWidgetBuilderState extends State<AuthWidgetBuilder> {
  StreamSubscription _usersSubscription;
  AuthService authService;

  @override
  void initState() {
//    authService = Provider.of<AuthService>(context, listen: false);
//    _usersSubscription = authService.users.listen((usersServices) {
//      if(usersServices == null){
//        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=> AuthPage()), (route) => false);
//      }
//    });
    super.initState();
  }

  @override
  void dispose() {
    print('dispose method is called auth widget builder 43');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);
    bool ifUser = Provider.of<bool>(context);
//    print('auth widget builder is build');
//    print('this is the data of the ifUser: $ifUser');

    return StreamBuilder<bool>(
        stream: _auth.isFetchingData,
        builder: (context, snapshot) {
          print('auth_widget_builder 57 Stream snapshot data: ${snapshot.data}');
          if(snapshot.data == true){
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          return StreamBuilder(
            stream: _auth.users,
            builder: (BuildContext context, snapshot) {

//              print('Stream snapshot data: ${snapshot.data}');
              print('auth widget builder 70 Stream connection state => ${snapshot.connectionState}');
              if(ConnectionState.active == snapshot.connectionState){
                if (snapshot.data is AdminService) {
                  return MainAdminPage();
                } else if (snapshot.data is ShopOwnerServices) {
                  return MainShopPage();
                } else if (snapshot.data is CustomerServices) {
                  return MainCustomerPage();
                }
                else{
                  return AuthPage();
                }
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            },
          );

        }
    );


//    if(ifUser == null){
//      return Scaffold(
//        body: Center(
//          child: CircularProgressIndicator(),
//        ),
//      );
//
//    }else if(ifUser){
//      return StreamBuilder(
//        stream: _auth.users,
//        builder: (context, snapshot) {
//          if(!snapshot.hasData){
//            print('snapshot don\'t have a data');
//          }
//          print('this is the data of the stream 58: ${snapshot.data}');
//          print('this is the data of the stream: ${snapshot.data.user}');
//          if(snapshot.data == true){
//            return Scaffold(
//              body: Center(
//                child: CircularProgressIndicator(),
//              ),
//            );
//          }
//
//          if (snapshot.data is AdminService) {
//            return MainAdminPage();
//          } else if (snapshot.data is ShopOwnerServices) {
//            return MainShopPage();
//          } else if (snapshot.data is CustomerServices) {
//            return MainCustomerPage();
//          }
//
//          return AuthPage();
//        },
//      );
//    }else{
//      return AuthPage();
//    }

//    final isLoggedIn = Provider.of<bool>(context);
    final users = Provider.of<Object>(context);
//    print('this is is isLoggedIn value: $isLoggedIn');
    print('this is is users value: $users');

    if (users == null) {
      return AuthPage();
//      return Scaffold(
//        body: Center(
//          child: CircularProgressIndicator(),
//        ),
//      );
    } else {
      if (users != null) {
        if (users is AdminService) {
          return MainAdminPage();
        } else if (users is ShopOwnerServices) {
          return MainShopPage();
        } else if (users is CustomerServices) {
          return MainCustomerPage();
        }
      } else {
        return AuthPage();
      }
    }

//    return StreamBuilder(
//      stream: authService.users,
//      builder: (BuildContext context, userService){
//        print('stream builder is rebuilt');
//        print(isLoggedIn);
//        if(isLoggedIn == null){
//          return Scaffold(
//            body: Center(
//              child: CircularProgressIndicator(),
//            ),
//          );
//        }else if(isLoggedIn){
//          print(userService.data);
//          if(userService.data is AdminService){
//            return MainAdminPage();
//          }
//          else if(userService.data is ShopOwnerServices){
//            return MainShopPage();
//          }
//          else if(userService.data is CustomerServices){
//            return MainCustomerPage();
//          }
//          else{
//            return AuthPage();
//          }
//        }
//        return AuthPage();
//      },
//    );
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

  Widget redirect(String claim) {
    if (claim == 'admin') {
      return MainAdminPage();
    } else if (claim == 'shop') {
      return MainShopPage();
    }
    return MainCustomerPage();
  }
}
