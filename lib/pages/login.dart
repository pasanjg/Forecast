import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forecast/pages/signup.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();

  bool _loadingVisible = false;
  bool _autoValidate = false;
  String _emailError;
  String _passwordError;
  bool _success;
  String _userEmail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text("Forecast Login"),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/forecast-logo.png'),
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 50.0,
                    )
                  ],
                ),
                Center(
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Material(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                controller: email,
                                style: new TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  errorText: _emailError,
                                  icon: Icon(
                                    Icons.mail,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Material(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                obscureText: true,
                                controller: password,
                                style: new TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  errorText: _passwordError,
                                  icon: Icon(Icons.vpn_key),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50.0,
                  child: FlatButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                      print(email.text.toString().trim());
                      print(password.text.toString().trim());
                      try {
                        _validate();
//                          if(_success) {
//                            Navigator.pushReplacement(
//                              context,
//                              MaterialPageRoute(
//                                builder: (context) => HomePage(),
//                              ),
//                            );
//                          }
                      } catch (e) {
                        print(e);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(40.0),
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFF311B92), Color(0xFF4A148C)],
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      new InkWell(
                        child: new Text("Forget Password"),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomePage(),
                          //   ),
                          // );
                        },
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      new InkWell(
                        child: new Text("Signup"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _currentUser() async {
    final FirebaseUser user = (await _auth.currentUser());
    if (user != null) {
      setState(() {
        _userEmail = user.email;
        var _uid = user.uid;
        print("User Email  curr $_userEmail");
        print("User UID curr $_uid");
      });
    } else {
      print("Unsuccess!");
    }
  }

  void _signin(String email, String password) async {
    final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;
    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        var _uid = user.uid;
        print("User Email $_userEmail");
        print("User UID $_uid");

        if (_success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      });
    } else {
      _success = false;
    }
  }

  bool _passwordValidate(String value) {
    String pattern = r'^[a-zA-Z0-9]{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool _emailValidate(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void _validate() async {
    bool pw = true;
    bool em = true;

    if (!_passwordValidate(password.text)) {
      _passwordError = "Please Enter 8 Character Password";
      pw = false;
      return;
    } else {
      _passwordError = null;
    }

    if (!_emailValidate(email.text.trim())) {
      _emailError = "Please Enter Valid Email";
      em = false;
      return;
    } else {
      _emailError = null;
    }
    if ((em == true) && (pw == true)) {
      _signin(email.text.trim(), password.text.trim());
    }
  }
}
