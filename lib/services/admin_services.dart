import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';

class AdminService{

  Future<Map<String, dynamic>> addAdmin(@required String fullName, @required email, @required phoneNumber){
    CloudFunctions.instance.getHttpsCallable(functionName: 'createNewUser').call({
      'fullName': fullName,
      'email' : email,
      'phoneNumber' : phoneNumber,
    }).then((res){
      print(res.data);
    }).catchError((e){
      print(e);
    });
  }

  Future<Map<dynamic, dynamic>> registerNewShop({@required String shopName, @required String shopOwnerName, @required shopOwnerEmail, @required String shopOwnerPhoneNumber}){

  }

}