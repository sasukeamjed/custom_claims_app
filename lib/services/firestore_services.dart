import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreServices{

  var _db = Firestore.instance.collection('Custom_claims_app').document('users');


  //ToDo: Fetch all products according to shop id

  //ToDo: Register User Data according to user type
  saveUserIntoFireStore(UserType userType){
    if(userType == UserType.Admin){
      
    }
    else if(userType == UserType.Shop){

    }
    else if(userType == UserType.Customer){

    }
  }

  //ToDo: Register Product Data

  //ToDo: fetch all shops to check if shop exist or not
}

enum UserType{
  Admin,
  Shop,
  Customer
}