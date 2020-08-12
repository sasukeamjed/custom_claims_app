import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:customclaimsapp/services/firestore_services.dart';
import 'file:///C:/flutter_lessons/wrood_project/custom_claims_app/lib/models/users/admin_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class AdminService {

  final Admin user;
  final BehaviorSubject<bool> _registeringUser = BehaviorSubject<bool>();

  Stream<bool> get registeringUser => _registeringUser.stream;


  FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://fir-auth-test-a160f.appspot.com');

  AdminService({this.user});

  Future<void> registerNewAdmin({
    @required String idToken,
    @required String fullName,
    @required String email,
    @required String phoneNumber,
  }) {
    _registeringUser.sink.add(true);
    return CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNewUser')
        .call({
      'idToken': idToken,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
    }).then((res) async {
      if(res.data['error'] != null){
        _registeringUser.sink.add(false);
        throw(res.data['error']);
      }

      FirestoreServices firestoreServices = FirestoreServices();
      print('admin_services.dart 44 newly created user ${res.data['user']}');
      try{
        if(res.data['claim'] == 'admin'){
          await firestoreServices.createAdmin(uid: res.data['user']['uid'], email: res.data['user']['email'], phoneNumber: res.data['user']['phoneNumber'], claim: res.data['claim']);
        }
        else{
          _registeringUser.sink.add(false);
          throw "Admin is not saved in firestore database";
        }
      }catch(e){
        _registeringUser.sink.add(false);
        throw e;
      }

      _registeringUser.sink.add(false);

      return res.data;

    }).catchError((e) {
      _registeringUser.sink.add(false);
      print(e);
    });
  }

  Future<void> registerNewShop({
    @required String idToken,
    @required String shopName,
    @required String shopOwnerName,
    @required shopOwnerEmail,
    @required String shopOwnerPhoneNumber,
    File shopImage,
  }) async {
    _registeringUser.sink.add(true);
    String shopImageUrl =
        'https://firebasestorage.googleapis.com/v0/b/fir-auth-test-a160f.appspot.com/o/default_shop_img%2Fshop.png?alt=media&token=28f490a6-da3f-48c0-b18a-bcfd676d05f9';

    if (shopImage != null) {
      StorageUploadTask uploadTask = _firebaseStorage
          .ref()
          .child('$shopName/$shopName' + '_image.png')
          .putFile(shopImage);
      shopImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    }
    CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNewUser')
        .call({
      "idToken": idToken,
      "displayName": shopName,
      "shopName" : shopName,
      "email": shopOwnerEmail,
      "shopImageUrl": shopImageUrl,
      "shopOwnerName": shopOwnerName,
      "phoneNumber": shopOwnerPhoneNumber,
    }).then((res) async {

      if(res.data['error'] != null){
        _registeringUser.sink.add(false);
        throw(res.data['error']);
      }
      FirestoreServices firestoreServices = FirestoreServices();
      print('admin_services.dart 104 newly created user ${res.data['user']}');
      try{
        print('admin_services.dart 106 => created user claim is : ${res.data['claim']}');
        if(res.data['claim'] == 'shop'){
          await firestoreServices.createShop(uid: res.data['user']['uid'], email: res.data['user']['email'], phoneNumber: res.data['user']['phoneNumber'], shopName: shopName, shopOwnerName: shopOwnerName, claim: res.data['claim']);
        }
        else{
          _registeringUser.sink.add(false);
          throw "Shop is not saved in firestore database";
        }
      }catch(e){
        _registeringUser.sink.add(false);
        throw e;
      }

      _registeringUser.sink.add(false);

      return res.data;
    }).catchError((e) {
      _registeringUser.sink.add(false);
      print(e);
    });
  }
}
