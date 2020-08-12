import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreServices{

  var _db = Firestore.instance.collection('Custom_claims_app').document('users');


  //ToDo: Fetch all products according to shop id

  //ToDo: Register user data in firestore if not exit
  Future<bool> _checkIfUserDataExit(String userId, String claim) async{
    var userCollection;

    if(claim == 'admin'){
      userCollection = await _db.collection('admins').document(userId).get();
      if(userCollection != null){
        return true;
      }else{
        return false;
      }
    }else if(claim == 'shop'){
      userCollection = await _db.collection('shops').document(userId).get();
      if(userCollection != null){
        return true;
      }else{
        return false;
      }
    }else if(claim == 'customer'){
      userCollection = await _db.collection('customers').document(userId).get();
      if(userCollection != null){
        return true;
      }else{
        return false;
      }
    }else{
      userCollection = null;
      throw "firestore services error claim is not found";
    }
  }

  Future<void> createAdmin({@required String uid, @required String email, @required String phoneNumber, @required String claim}) async{
    bool userData = await _checkIfUserDataExit(uid, claim);
    if(userData){
      return null;
    }
    Map<String, dynamic> data = {'uid' : uid, 'email' : email, 'phoneNumber' : phoneNumber};
    return _db.collection('admins').document(uid).setData(data);
  }

  Future<void> createShop({@required String uid, @required String email, @required String shopName, @required String shopOwnerName, @required String phoneNumber, @required String claim}) async{
    bool userData = await _checkIfUserDataExit(uid, claim);
    if(userData){
      return null;
    }
    Map<String, dynamic> data = {'uid' : uid, 'email' : email, 'shopName' : shopName, 'shopOwnerNme' : shopOwnerName,'phoneNumber' : phoneNumber};
    return _db.collection('shops').document(uid).setData(data);
  }

  Future<void> createCustomer({@required String uid, @required String email, @required String phoneNumber, @required String claim}) async{
    bool userData = await _checkIfUserDataExit(uid, claim);
    if(userData){
      return null;
    }
    Map<String, dynamic> data = {'uid' : uid, 'email' : email, 'phoneNumber' : phoneNumber};
    return _db.collection('customers').document(uid).setData(data);
  }


//ToDo: Register Product Data

  //ToDo: fetch all shops to check if shop exist or not
}

enum UserType{
  Admin,
  Shop,
  Customer
}