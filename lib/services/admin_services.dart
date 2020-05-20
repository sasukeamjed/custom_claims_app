import 'dart:io';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class AdminService {

  FirebaseStorage _firebaseStorage = FirebaseStorage(storageBucket: 'gs://fir-auth-test-a160f.appspot.com');

  Future<Map<String, dynamic>> addAdmin(
      @required String fullName, @required email, @required phoneNumber) {
    CloudFunctions.instance
        .getHttpsCallable(functionName: 'createNewUser')
        .call({
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
    }).then((res) {
      print(res.data);
    }).catchError((e) {
      print(e);
    });
  }

  Future<Map<dynamic, dynamic>> registerNewShop({
    @required String shopName,
    @required String shopOwnerName,
    @required shopOwnerEmail,
    @required String shopOwnerPhoneNumber,
    File shopImage,
  }) {

    if(shopImage != null){
      StorageUploadTask task = _firebaseStorage.ref().putFile(file);
    }

    CloudFunctions.instance
        .getHttpsCallable(functionName: 'createShopOwner')
        .call({

    });
  }
}
