import 'package:customclaimsapp/pages/auth_pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customclaimsapp/services/auth.dart';

class SignUpPage extends StatelessWidget {
  TextEditingController userName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('Sign_up_page is build');
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
                  decoration: InputDecoration(hintText: 'Username'),
                  controller: userName,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: textEmail,
                  decoration: InputDecoration(hintText: 'Email'),
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
                TextField(
                  controller: phoneNumber,
                  decoration: InputDecoration(hintText: 'Phone Number'),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Sign Up'),
                      onPressed: () async {
                        await _auth.register(
                            username: userName.text,
                            email: textEmail.text,
                            password: textPassword.text,
                            phoneNumber: phoneNumber.text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "You Already Have An Account ? ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context)=> SignInPage(),
                            ),);
                          },
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
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
