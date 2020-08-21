import 'package:cloud_functions/cloud_functions.dart';
import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/models/users/admin_model.dart';

import 'package:customclaimsapp/models/users/customer_model.dart';
import 'package:customclaimsapp/models/users/shop_owner_model.dart';
import 'package:customclaimsapp/services/admin_services.dart';
import 'package:customclaimsapp/services/customer_services.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';

import 'dart:developer' as dev;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:customclaimsapp/services/firestore_services.dart';

class AuthService extends ChangeNotifier {
//  bool fetchingData = false;



  ShopOwner _shopOwner;
  Admin _admin;
  Customer _customer;

  final BehaviorSubject<Object> _users = BehaviorSubject<Object>();
  final BehaviorSubject<bool> _fetchingData = BehaviorSubject<bool>();
  final BehaviorSubject<bool> _registeringUser = BehaviorSubject<bool>();


  Stream<Object> get users => _users.stream;
  Stream<bool> get isFetchingData => _fetchingData.stream;
  Stream<bool> get registeringUser => _registeringUser.stream;



  FirebaseAuth _auth = FirebaseAuth.instance;

  ShopOwner get shop => _shopOwner;

  

  Future<void> _createInstanceForUserService(FirebaseUser firebaseUser) async{
    print('auth.dart 46 _createInstanceForUserService firebase user is => ${firebaseUser.phoneNumber}');
    FirestoreServices firestoreServices = FirestoreServices();

    IdTokenResult idTokenResult = await firebaseUser.getIdToken();

    String claim = idTokenResult.claims['claim'];

    if(claim == 'admin'){
      Admin admin = Admin(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        claim: claim,
        token: idTokenResult.token,
        phoneNumber: firebaseUser.phoneNumber,);


//      print('auth.dart 179 newly created user ${res.data['user']}');
      try{
        if(claim == 'admin'){
          await firestoreServices.createAdmin(uid: firebaseUser.uid, email: firebaseUser.email, phoneNumber: firebaseUser.phoneNumber, claim: claim);
          print('auth.dart 66 admin saved in firestore database');
        }else{
          throw "auth.dart 68 admin is not saved in firestore database, maybe it is already saved";
        }
      }catch(e){
        throw e;
      }



      AdminService adminService = AdminService(user: admin);
      _users.sink.add(adminService);

    }
    else if(claim == 'shop'){

//      DocumentSnapshot doc = await Firestore.instance
//          .collection('Shops')
//          .document(firebaseUser.displayName)
//          .get();
//
//      String shopOwnerName = doc.data['shopOwnerName'];
      //ToDo:get shop data


//        List<Product> products =
//        await shopServices.fetchAllProducts(shopName: firebaseUser.displayName);

      ShopOwner shop = ShopOwner(
        uid: firebaseUser.uid,
        shopName: firebaseUser.displayName,
        email: firebaseUser.email,
        claim: claim,
        token: idTokenResult.token,
        phoneNumber: firebaseUser.phoneNumber,
        shopOwnerName: 'shopOwner',
        products: [],
      );

      try{
        if(claim == 'shop'){
          await firestoreServices.createShop(uid: firebaseUser.uid, email: firebaseUser.email, phoneNumber: firebaseUser.phoneNumber, claim: claim, shopName: firebaseUser.displayName, shopOwnerName: "shopOwner");
          print('auth.dart 108 shop saved in firestore database');
        }else{
          throw "auth.dart 110 shop is not saved in firestore database, maybe it is already saved";
        }
      }catch(e){
        print('114 auth.dart $e');
      }

      ShopOwnerServices shopServices = ShopOwnerServices(user: shop);

      _users.sink.add(shopServices);

    }else{
      Customer customer = Customer(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        claim: claim,
        phoneNumber: firebaseUser.phoneNumber,
      );

      try{
        if(claim == 'customer'){
          await firestoreServices.createCustomer(uid: firebaseUser.uid, email: firebaseUser.email, phoneNumber: firebaseUser.phoneNumber, claim: claim);
          print('auth.dart 131 customer saved in firestore database');
        }else{
          throw "auth.dart 133 customer is not saved in firestore database, maybe it is already saved";
        }
      }catch(e){
        throw e;
      }

      CustomerServices customerServices = CustomerServices(user: customer);
      print(customerServices.user);

      _users.sink.add(customerServices);

    }
  }

  Future<bool> checkIfUserLoggedIn() async{
    _fetchingData.sink.add(true);

    FirebaseUser firebaseUser = await _auth.currentUser();

    if(firebaseUser != null){

      await _createInstanceForUserService(firebaseUser);
      _fetchingData.sink.add(false);
      return true;
    }else{
      _users.add(null);
      _fetchingData.sink.add(false);
      return false;
    }

  }

  Future<void> login(email, password) async {
    try {
      _fetchingData.sink.add(true);
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;

      await _createInstanceForUserService(firebaseUser);
      _fetchingData.sink.add(false);
    } catch (e) {
      _fetchingData.sink.add(false);
      print(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _users.sink.add(null);
  }



  //This method is used in AuthPage to register a new user
  Future<dynamic> registerNewCustomer(
      {@required String username,
      @required String email,
      @required String password,
      @required String phoneNumber}) async {

    _registeringUser.sink.add(true);


//    if (shopImage != null) {
//      StorageUploadTask uploadTask = _firebaseStorage
//          .ref()
//          .child('$shopName/$shopName' + '_image.png')
//          .putFile(shopImage);
//      shopImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
//    }
    return CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNewUser')
        .call({
      "email": email,
      "password": password,
      "displayName": username,
      "phoneNumber": phoneNumber,
    }).then((res) async {

      if(res.data['error'] != null){
        throw(res.data['error']);
      }
      FirestoreServices firestoreServices = FirestoreServices();
      print('auth.dart 179 newly created user ${res.data['user']}');
      try{
        if(res.data['claim'] == 'customer'){
          await firestoreServices.createCustomer(uid: res.data['user']['uid'], email: res.data['user']['email'], phoneNumber: res.data['user']['phoneNumber'], claim: res.data['claim']);
        }else{
          throw "Customer is not saved in firestore database";
        }
      }catch(e){
        throw e;
      }

      _registeringUser.sink.add(false);

      return res.data;
    }).catchError((e) {
      _registeringUser.sink.add(false);
      throw(e);
    });
  }


}
