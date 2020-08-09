import 'package:cloud_functions/cloud_functions.dart';
import 'package:customclaimsapp/models/product_model.dart';
import 'file:///C:/flutter_lessons/wrood_project/custom_claims_app/lib/models/users/admin_model.dart';
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

  

  Future<void> _createUser(FirebaseUser firebaseUser) async{

    IdTokenResult idTokenResult = await firebaseUser.getIdToken();

    String claim = idTokenResult.claims['claim'];

    if(claim == 'admin'){
      Admin admin = Admin(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        claim: claim,
        token: idTokenResult.token,
        phoneNumber: firebaseUser.phoneNumber,);

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
      //ToDo:check if this code needed


//        List<Product> products =
//        await shopServices.fetchAllProducts(shopName: firebaseUser.displayName);

      ShopOwner shop = ShopOwner(
        uid: firebaseUser.uid,
        shopName: firebaseUser.displayName,
        email: firebaseUser.email,
        claim: claim,
        token: idTokenResult.token,
        phoneNumber: firebaseUser.phoneNumber,
        shopOwnerName: 'shopOwnerName',
        products: [],
      );

      ShopOwnerServices shopServices = ShopOwnerServices(user: shop);

      _users.sink.add(shopServices);

    }else{
      Customer customer = Customer(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        claim: claim,
        phoneNumber: firebaseUser.phoneNumber,
      );

      CustomerServices customerServices = CustomerServices(user: customer);
      print(customerServices.user);

      _users.sink.add(customerServices);

    }
  }

  Future<bool> checkIfUserLoggedIn() async{
    _fetchingData.sink.add(true);

    FirebaseUser firebaseUser = await _auth.currentUser();

    if(firebaseUser != null){

      await _createUser(firebaseUser);
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

      await _createUser(firebaseUser);
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
  Future<dynamic> register(
      {@required String username,
      @required String email,
      @required String password,
      @required String phoneNumber}) async {
    _registeringUser.sink.add(true);
    String shopImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/fir-auth-test-a160f.appspot.com/o/default_shop_img%2Fshop.png?alt=media&token=28f490a6-da3f-48c0-b18a-bcfd676d05f9';

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
    }).then((res) {
      print('auth.dart 164 newly created user ${res.data}');
      _registeringUser.sink.add(false);
      if(res.data['error'] != null){
        throw(res.data['error']);
      }
      return res.data;
    }).catchError((e) {
      _registeringUser.sink.add(false);
      throw(e);
    });
  }


}
