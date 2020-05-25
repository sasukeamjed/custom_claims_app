import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AdminService {
  FirebaseStorage _firebaseStorage =
      FirebaseStorage(storageBucket: 'gs://fir-auth-test-a160f.appspot.com');

  Future<Map<String, dynamic>> addAdmin({
    @required String idToken,
    @required String fullName,
    @required String email,
    @required String phoneNumber,
  }) {
    CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNewUser')
        .call({
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
        .getHttpsCallable(functionName: 'createShopOwner')
        .call({
      "idToken": idToken,
      "shopName": shopName,
      "shopOwnerEmail": shopOwnerEmail,
      "shopImageUrl": shopImageUrl,
      "shopOwnerName": shopOwnerName,
      "shopOwnerPhoneNumber": shopOwnerPhoneNumber,
      "forAdmin": false,
    }).then((res) {
      print(res.data);
    }).catchError((e) {
      print(e);
    });
  }
}
