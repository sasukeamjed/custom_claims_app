import 'package:customclaimsapp/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum LoginState { signIn, signUp }

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
  void dispose() {
    print('23 dispose method is called');
    textEmail.dispose();
    textPassword.dispose();
    userName.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  void initState() {
    state = LoginState.signIn;
    print('33 auth page is rebuild');
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    AuthService _auth = Provider.of<AuthService>(context);
    print('39 auth page is rebuild');
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Claim'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: Center(
          child: (state == LoginState.signIn) ? signIn(_auth) : signUp(_auth),
        ),
      ),
    );
  }

  Widget signIn(AuthService auth) {
    return SingleChildScrollView(
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
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus){
                      currentFocus.unfocus();
                    }
                    await auth.login(textEmail.text, textPassword.text);
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
    );
  }

  Widget signUp(AuthService auth) {

    return SingleChildScrollView(
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
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if(!currentFocus.hasPrimaryFocus){
                      currentFocus.unfocus();
                    }
                    try {
                      var result = await auth.register(
                        username: userName.text,
                        email: textEmail.text,
                        password: textPassword.text,
                        phoneNumber: phoneNumber.text,
                      );

                      if(result != null){
                        print('auth_page 191 result => $result');
                        textEmail.clear();
                        textPassword.clear();
                        userName.clear();
                        phoneNumber.clear();
                        setState(() {
                          state = LoginState.signIn;
                        });
                      }
                    } catch (e) {
                      print('auth_page 196 error message e => $e');
                    }
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
                      onTap: () {
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
                StreamBuilder(
                  stream: auth.registeringUser,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.data == true) {
                      return CircularProgressIndicator();
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );


//    return SingleChildScrollView(
//      child: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 16),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            TextField(
//              decoration: InputDecoration(hintText: 'Username'),
//              controller: userName,
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            TextField(
//              controller: textEmail,
//              decoration: InputDecoration(hintText: 'Email'),
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            TextField(
//              controller: textPassword,
//              decoration: InputDecoration(hintText: 'Password'),
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            TextField(
//              controller: phoneNumber,
//              decoration: InputDecoration(hintText: 'Phone Number'),
//            ),
//            SizedBox(
//              height: 20,
//            ),
//            Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                RaisedButton(
//                  child: Text('Sign Up'),
//                  onPressed: () async {
//                    FocusScopeNode currentFocus = FocusScope.of(context);
//                    if(!currentFocus.hasPrimaryFocus){
//                      currentFocus.unfocus();
//                    }
//                    try {
//                      var result = await auth.register(
//                        username: userName.text,
//                        email: textEmail.text,
//                        password: textPassword.text,
//                        phoneNumber: phoneNumber.text,
//                      );
//
//                      if(result != null){
//                        print('auth_page 186 result => $result');
//                        textEmail.clear();
//                        textPassword.clear();
//                        userName.clear();
//                        phoneNumber.clear();
////                        setState(() {
////                          print('set state function is called');
////                          state = LoginState.signIn;
////                        });
//                      }
//                      print('auth_page 194 result => $result');
//                    } catch (e) {
//                      print('auth_page 196 error message e => $e');
//                    }
//                  },
//                ),
//                SizedBox(
//                  height: 10,
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      "You Already Have An Account ? ",
//                      style: TextStyle(
//                        color: Colors.black,
//                        fontSize: 14,
//                        fontWeight: FontWeight.w500,
//                      ),
//                    ),
//                    GestureDetector(
//                      onTap: () {
//                        setState(() {
//                          state = LoginState.signIn;
//                        });
//                      },
//                      child: Text(
//                        "Sign In",
//                        style: TextStyle(
//                            color: Colors.blue,
//                            fontSize: 14,
//                            fontWeight: FontWeight.bold,
//                            decoration: TextDecoration.underline),
//                      ),
//                    ),
//                  ],
//                ),
//                StreamBuilder(
//                  stream: auth.isFetchingData,
//                  builder: (BuildContext context, snapshot) {
//                    if (snapshot.data == true) {
//                      return CircularProgressIndicator();
//                    } else {
//                      return Container();
//                    }
//                  },
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
  }
}
