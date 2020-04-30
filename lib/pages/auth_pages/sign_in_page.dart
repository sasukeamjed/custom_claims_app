import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customclaimsapp/services/auth.dart';


class SignInPage extends StatelessWidget {

  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();


  @override
  Widget build(BuildContext context) {
    print('Sign_in_page is build');
    AuthService _auth = Provider.of<AuthService>(context);
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
                    await _auth.login(textEmail.text, textPassword.text);
                  },
                ),
                SizedBox(width: 20,),
                RaisedButton(
                  child: Text('Register'),
                  onPressed: () async{
                    await _auth.register(textEmail.text, textPassword.text);
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
