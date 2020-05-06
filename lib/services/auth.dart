import 'package:customclaimsapp/models/users/main_user.dart';
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
    Map claims = idTokenResult.claims;
    currentUser = MainUser(uid: user.uid, email: user.email, claims: claims['claim']);
  }


  Future<Map> getClaim(FirebaseUser firebaseUser) async{
    IdTokenResult idTokenResult = await firebaseUser.getIdToken();
    return idTokenResult.claims;
  }




  Future<AuthResult> register(email, password) async{
    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//      var idToken = await authResult.user.getIdToken();
//      print(idToken.claims);
      return authResult;
    }
    catch(e){
      print('There has been an error: $e');
    }
  }



  Future<void> logout() async{
    await _auth.signOut();
    currentUser = null;
    notifyListeners();
  }
}

