//import 'package:customclaimsapp/models/users/main_user.dart';
//import 'package:customclaimsapp/pages/admin_pages/main_admin_page.dart';
//import 'package:customclaimsapp/pages/home.dart';
//import 'package:customclaimsapp/pages/auth_pages/sign_in_page.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//import 'package:customclaimsapp/services/auth.dart';
//
//class Auth extends StatefulWidget {
//  const Auth({Key key, @required this.userSnapshot}) : super(key: key);
//  final AsyncSnapshot<MainUser> userSnapshot;
//
//  @override
//  _AuthState createState() => _AuthState();
//}
//
//class _AuthState extends State<Auth> {
//  @override
//  Widget build(BuildContext context) {
//    print('Secondery Auth Widget is Build');
//    print(widget.userSnapshot.connectionState);
//    if (widget.userSnapshot.connectionState == ConnectionState.active) {
//      return widget.userSnapshot.hasData
//          ? FutureBuilder(
//              future: widget.userSnapshot.data.getIdToken(),
//              builder: (context, snapshot) {
//                if (snapshot.connectionState == ConnectionState.done) {
//                  return MainAdminPage();
//                }
//                return Builder(
//
//                  builder: (BuildContext context){
//                    print('this is a inside builder');
//                    return Scaffold(
//                      body: Center(
//                        child: CircularProgressIndicator(),
//                      ),
//                    );
//                  },
//                );
//              },
//            )
//          : SignInPage();
//    }
//
//    return Builder(
//      builder: (BuildContext context){
//        print('this is a outside builder');
//        return Scaffold(
//          body: Center(
//            child: CircularProgressIndicator(),
//          ),
//        );
//      },
//    );
//  }
//
////  @override
////  Widget build(BuildContext context) {
////    if(widget.userSnapshot.connectionState == ConnectionState.active){
////      return widget.userSnapshot.hasData ? futureBuildFunc(context, widget.userSnapshot): SignInPage();
////    }
////    return Scaffold(
////      body: Center(
////        child: CircularProgressIndicator(),
////      ),
////    );
////  }
//
//  Future<Map<dynamic, dynamic>> getClaims(
//      AsyncSnapshot<FirebaseUser> userSnapshot) async {
//    print('get claims function');
//    IdTokenResult result = await userSnapshot.data.getIdToken();
//    return result.claims;
//  }
//
//  Widget futureBuildFunc(BuildContext context, AsyncSnapshot snapshot) {
//    return FutureBuilder(
//      future: getClaims(snapshot),
//      builder: (context, snapshot) {
//        print('Future function has been build');
//
////      if(snapshot.hasData){
////        print(snapshot.data['phone_number']);
////        print('it has data');
////      }
////      print('this the future function');
//        print(snapshot.connectionState);
//        if (snapshot.connectionState == ConnectionState.done) {
//          return MainAdminPage();
//        } else {
//          return Scaffold(
//            body: Center(
//              child: CircularProgressIndicator(),
//            ),
//          );
//        }
////      if(snapshot.connectionState == ConnectionState.active){
////
////        return MainAdminPage();
////      }
//        return MainAdminPage();
//      },
//    );
//  }
//}
