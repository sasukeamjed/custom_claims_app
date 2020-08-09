import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'file:///C:/flutter_lessons/wrood_project/custom_claims_app/lib/models/users/admin_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AdminService {

  final Admin user;


  FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://fir-auth-test-a160f.appspot.com');

  AdminService({this.user});

  Future<void> addAdmin({
    @required String idToken,
    @required String fullName,
    @required String email,
    @required String phoneNumber,
  }) {
    CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNewUser')
        .call({
      'idToken': idToken,
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'forAdmin': true,
    }).then((res) {
      print(res.data);
    }).catchError((e) {
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
      "fullName": shopOwnerName,
      "phoneNumber": shopOwnerPhoneNumber,
    }).then((res) {
      print(res.data);
    }).catchError((e) {
      print(e);
    });
  }
}
