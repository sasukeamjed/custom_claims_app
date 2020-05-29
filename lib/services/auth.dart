import 'package:cloud_functions/cloud_functions.dart';
import 'package:customclaimsapp/models/shop_model.dart';
import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:customclaimsapp/models/users/secondery_users/admin_model.dart';
import 'package:customclaimsapp/models/users/secondery_users/shop_owner_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class AuthService extends ChangeNotifier{

  bool fetchingData = false;

  MainUser currentUser;


  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> login(email, password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      notifyListeners();
    }catch(e){
      print(e);
    }
  }

  Future<void> getCurrentUser() async{
    var user = await _auth.currentUser();
    IdTokenResult idTokenResult = await user.getIdToken();
    print('getCurrentUser: ${idTokenResult.claims}');
    Map claims = idTokenResult.claims;
    if(claims['claim'] == 'admin'){
      currentUser = Admin(uid: user.uid, email: user.email, claim: claims['claim'], token: idTokenResult.token, phoneNumber: user.phoneNumber);
      return;
    }
    else if(claims['claim'] == 'shop'){
      currentUser = ShopOwner(uid: user.uid, email: user.email, claim: claims['claim'], token: idTokenResult.token, phoneNumber: user.phoneNumber);
      return;
    }
    currentUser = MainUser(uid: user.uid, email: user.email, claim: claims['claim'], token: idTokenResult.token);
  }


  Future<Map> getClaim(FirebaseUser firebaseUser) async{
    IdTokenResult idTokenResult = await firebaseUser.getIdToken();
    return idTokenResult.claims;
  }




  Future<AuthResult> register({@required String username, @required String email, @required String password, @required String phoneNumber}) async{
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



  Future<void> logout() async{
    await _auth.signOut();
    currentUser = null;
    notifyListeners();
  }
}

