import 'package:customclaimsapp/models/users/main_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  bool fetchingData = false;


  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> login(email, password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e);
    }
  }

  Stream<FirebaseUser> creatingUser(){
    //ToDo: goal is to return a stream of MainUser
    //ToDo: get the firebase user
    _auth.onAuthStateChanged.map((FirebaseUser firebaseUser) async{

    });
    return _auth.onAuthStateChanged;
    //ToDo: check what claim it has
    //ToDo: return that user depending on that claim
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
  }
}

