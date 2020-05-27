import 'package:customclaimsapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginState {signIn, signUp}

class AuthPage extends StatefulWidget {

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  LoginState state;

  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();


  @override
  void initState() {
    state = LoginState.signIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);
    if(state == LoginState.signIn){
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
                              setState(() {
                                state = LoginState.signUp;
                              });
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
                            setState(() {
                              state = LoginState.signIn;
                            });
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
