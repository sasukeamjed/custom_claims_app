import 'package:customclaimsapp/pages/auth_pages/sign_up_page.dart';
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: 'Email'),
                  controller: textEmail,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: textPassword,
                  decoration: InputDecoration(hintText: 'Password'),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Login'),
                      onPressed: () async {
                        await _auth.login(textEmail.text, textPassword.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "You Don't Have An Account ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
