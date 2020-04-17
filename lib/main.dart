import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();

  FirebaseAuth _auth;


  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    super.initState();
  }

  Future<AuthResult> login() async{
    try{
      await _auth.signInWithEmailAndPassword(email: textEmail.text, password: textPassword.text);
    }catch(e){
      print(e);
    }
  }

  Future<AuthResult> register() async{
    try{
      var authResult = await _auth.createUserWithEmailAndPassword(email: textEmail.text, password: textPassword.text);
      var idToken = await authResult.user.getIdToken();
      print(idToken.claims);
      return authResult;
    }
    catch(e){
      print('There has been an error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text('Custom Claim'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
              controller: textEmail,
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: textPassword,
              decoration: InputDecoration(
                hintText: 'Password'
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () async{
                    await login();
                  },
                ),
                SizedBox(width: 20,),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () async{
                    await register();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
