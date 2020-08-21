import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirestoreServices{

  var _db = Firestore.instance.collection('Custom_claims_app').document('users');


  //ToDo: Fetch all products according to shop id

  //ToDo: Register user data in firestore if not exit
  Future<bool> checkIfUserDataExit(String userId, String claim) async{
    DocumentSnapshot doc;
    print('firestore_services.dart 14 claim => $claim');
    if(claim == 'admin'){
      doc = await _db.collection('admins').document(userId).get();
      print('firestore_services.dart 17 userDat => ${doc.data}.');
      if(doc.data != null){
        return true;
      }else{
        return false;
      }
    }else if(claim == 'shop'){
      //Note: the userId in shops are thire names
      doc = await _db.collection('shops').document(userId).get();
      if(doc.data != null){
        return true;
      }else{
        return false;
      }
    }else if(claim == 'customer'){
      doc = await _db.collection('customers').document(userId).get();
      if(doc.data != null){
        return true;
      }else{
        return false;
      }
    }else{
      doc = null;
      throw "firestore services error claim is not found";
    }
  }

  Future<void> createAdmin({@required String uid, @required String email, @required String phoneNumber, @required String claim}) async{
    bool userData = await checkIfUserDataExit(uid, claim);
    print('firestore_services.dart 45 userData => $userData');
    if(userData){
      return null;
    }
    Map<String, dynamic> data = {'uid' : uid, 'email' : email, 'phoneNumber' : phoneNumber};
    return _db.collection('admins').document(uid).setData(data);
  }

  Future<void> createShop({@required String uid, @required String email, @required String shopName, @required String shopOwnerName, @required String phoneNumber, @required String claim}) async{
    bool userData = await checkIfUserDataExit(uid, claim);
    if(userData){
      return null;
    }
    Map<String, dynamic> data = {'uid' : uid, 'email' : email, 'shopName' : shopName, 'shopOwnerNme' : shopOwnerName,'phoneNumber' : phoneNumber};
    return _db.collection('shops').document(shopName).get().then((snapshot) {
      if(snapshot.exists){
        print("62 firestore_services shop name is already created");
      }else{
        return snapshot.reference.setData(data);
      }
    });
  }

  Future<void> createCustomer({@required String uid, @required String email, @required String phoneNumber, @required String claim}) async{
    bool userData = await checkIfUserDataExit(uid, claim);
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