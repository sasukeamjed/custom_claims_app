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
    @required String idToken,
    @required String shopName,
    @required String shopOwnerName,
    @required shopOwnerEmail,
    @required String shopOwnerPhoneNumber,
    File shopImage,
  }) async{

    String shopImageUrl;

    if(shopImage != null){
      StorageUploadTask uploadTask = _firebaseStorage.ref().child('$shopName/$shopName'+ '_image.png').putFile(shopImage);
      shopImageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    }

    CloudFunctions.instance
        .getHttpsCallable(functionName: 'createShopOwner')
        .call({
      "idToken" : idToken,
      "shopName" : shopName,
      "shopOwnerEmail" : shopOwnerEmail,
      "shopImageUrl" : shopImageUrl,
      "shopOwnerName" : shopOwnerName,
      "shopOwnerPhoneNumber" : shopOwnerPhoneNumber,
    }).then((res) {
      print(res.data);
    }).catchError((e){
      print(e);
    });
  }
}
