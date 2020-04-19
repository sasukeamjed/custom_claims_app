import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> login(email, password) async{
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    }catch(e){
      print(e);
    }
  }

  Stream<FirebaseUser> checkUser(){
    return _auth.onAuthStateChanged;
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

