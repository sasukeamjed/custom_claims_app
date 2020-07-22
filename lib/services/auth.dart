import 'package:cloud_functions/cloud_functions.dart';
import 'package:customclaimsapp/models/product_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/admin_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/customer_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';
import 'package:customclaimsapp/services/admin_services.dart';
import 'package:customclaimsapp/services/customer_services.dart';
import 'package:customclaimsapp/services/shop_owner_services.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class AuthService extends ChangeNotifier {
  bool fetchingData = false;

  ShopOwner _shopOwner;
  Admin _admin;
  Customer _customer;

  final BehaviorSubject<Object> _users = BehaviorSubject<Object>();

  Stream<Object> get users => _users.stream;



  FirebaseAuth _auth = FirebaseAuth.instance;

  ShopOwner get shop => _shopOwner;

  Future<AuthResult> login(email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> isLoggedIn() async{
    var firebaseUser = await _auth.currentUser();

    if(firebaseUser == null){
      return false;
    }

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
      return true;
    }
    else if(claim == 'shop'){

      DocumentSnapshot doc = await Firestore.instance
          .collection('Shops')
          .document(firebaseUser.displayName)
          .get();

      String shopOwnerName = doc.data['shopOwnerName'];
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
        shopOwnerName: shopOwnerName,
        products: [],
      );


      ShopOwnerServices shopServices = ShopOwnerServices(user: shop);

      _users.sink.add(shopServices);
      return true;
    }else{
      Customer customer = Customer(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
        claim: claim,
        phoneNumber: firebaseUser.phoneNumber,
      );

      CustomerServices customerServices = CustomerServices(user: customer);

      _users.sink.add(customerServices);
      return true;
    }
  }



  //Stream of users
//  Stream<Object> users(){
//    return _auth.onAuthStateChanged.asyncMap((firebaseUser)async{
//      IdTokenResult idTokenResult = await firebaseUser.getIdToken();
//
//      Map<dynamic, dynamic> claims = idTokenResult.claims;
//
//      if (claims['claim'] == 'admin') {
//        return Admin(
//            uid: firebaseUser.uid,
//            email: firebaseUser.email,
//            claim: claims['claim'],
//            token: idTokenResult.token,
//            phoneNumber: firebaseUser.phoneNumber,);
//      } else if (claims['claim'] == 'shop') {
//
//        DocumentSnapshot doc = await Firestore.instance
//            .collection('Shops')
//            .document(firebaseUser.displayName)
//            .get();
//
//        String shopOwnerName = doc.data['shopOwnerName'];
//        //ToDo:check if this code needed
//        ShopOwnerServices shopServices = ShopOwnerServices();
//
////        List<Product> products =
////        await shopServices.fetchAllProducts(shopName: firebaseUser.displayName);
//
//        return ShopOwner(
//          uid: firebaseUser.uid,
//          shopName: firebaseUser.displayName,
//          email: firebaseUser.email,
//          claim: claims['claim'],
//          token: idTokenResult.token,
//          phoneNumber: firebaseUser.phoneNumber,
//          shopOwnerName: shopOwnerName,
//          products: [],
//        );
//      }
//      else if(claims['claim'] == 'customer'){
//        return Customer(
//          uid: firebaseUser.uid,
//          email: firebaseUser.email,
//          claim: claims['claim'],
//          phoneNumber: firebaseUser.phoneNumber,
//        );
//      }
//      return null;
//
//    });
//  }



  //This method is used in AuthWidgetBuilder to check if there is a user logged in or not
  Future<Object> getCurrentUser() async {
    print('getCurrentUser method line 95 auth.dart is fired');
    var user = await _auth.currentUser();
    IdTokenResult idTokenResult = await user.getIdToken();
    print('AuthService getCurrentUser 34 : ${idTokenResult.claims}');
    Map claims = idTokenResult.claims;
    if (claims['claim'] == 'admin') {
      return Admin(
          uid: user.uid,
          email: user.email,
          claim: claims['claim'],
          token: idTokenResult.token,
          phoneNumber: user.phoneNumber);
    } else if (claims['claim'] == 'shop') {

      DocumentSnapshot doc = await Firestore.instance
          .collection('Shops')
          .document(user.displayName)
          .get();

      String shopOwnerName = doc.data['shopOwnerName'];

      ShopOwnerServices shopServices = ShopOwnerServices();

//      List<Product> products =
//          await shopServices.fetchAllProducts(shopName: user.displayName);

      return ShopOwner(
        uid: user.uid,
        shopName: user.displayName,
        email: user.email,
        claim: claims['claim'],
        token: idTokenResult.token,
        phoneNumber: user.phoneNumber,
        shopOwnerName: shopOwnerName,
        products: [],
      );
    }
    return Customer(
      uid: user.uid,
      email: user.email,
      claim: claims['claim'],
      phoneNumber: user.phoneNumber,
    );
  }

  //This method is used in AuthPage to register a new user
  Future<AuthResult> register(
      {@required String username,
      @required String email,
      @required String password,
      @required String phoneNumber}) async {
    String shopImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/fir-auth-test-a160f.appspot.com/o/default_shop_img%2Fshop.png?alt=media&token=28f490a6-da3f-48c0-b18a-bcfd676d05f9';

//    if (shopImage != null) {
//      StorageUploadTask uploadTask = _firebaseStorage
//          .ref()
//          .child('$shopName/$shopName' + '_image.png')
//          .putFile(shopImage);
//      shopImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
//    }
    CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNewUser')
        .call({
      "email": email,
      "password": password,
      "displayName": username,
      "phoneNumber": phoneNumber,
    }).then((res) {
      print(res.data);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> logout() async {
    await _auth.signOut();
    _admin = null;
    _shopOwner = null;
    _customer = null;
    notifyListeners();
  }
}
