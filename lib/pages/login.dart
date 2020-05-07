import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/pages/signup.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();

  String _emailError;
  String _passwordError;
  bool _success;
  String _userEmail;
  bool isLoading = false;
  FirebaseUser firebaseUser;

  /// Referenced from https://pub.dev/packages/firebase_auth
  /// Login function using firebase authentication
  void _login(String email, String password) async {
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        setState(() {
          firebaseUser = user;
          _success = true;
          _userEmail = user.email;
          var _uid = user.uid;

          if (_success) {
            setState(() {
              isLoading = false;
            });
            Navigator.pop(context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        });
      }
    } catch (e) {
      _success = false;
      isLoading = false;
      _showError(e.code.toString());
    }
  }

  /// Error message display function
  void _showError(String errorCode) {
    switch (errorCode) {
      case 'ERROR_INVALID_EMAIL':
        showFlutterToast("Invalid email format");

        break;
      case 'ERROR_USER_NOT_FOUND':
        showFlutterToast("Invalid email or password");

        break;
      case 'ERROR_WRONG_PASSWORD':
        showFlutterToast("Invalid email or password");

        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        showFlutterToast("Email is already in use");

        break;
      case 'ERROR_WEAK_PASSWORD':
        showFlutterToast("Password must be atleast 8 characters");

        break;
      default:
        showFlutterToast("Something went wrong");
    }
  }

  /// Password validator
  bool _passwordValidate(String val) {
    String patternPassword = r'^[a-zA-Z0-9]{8,}$';
    RegExp regExp = new RegExp(patternPassword);
    return regExp.hasMatch(val);
  }

  /// Email validator
  bool _emailValidate(String val) {
    String patternEmail =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(patternEmail);
    return regExp.hasMatch(val);
  }

  /// Validate user inputs
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
      _login(email.text.trim(), password.text.trim());
      setState(() {
        isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Welcome back"),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: DefaultGradient(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                isLoading
                    ? CircularProgressIndicator(
                        backgroundColor: Theme.of(context).primaryColor,
                      )
                    : SizedBox(
                        width: 1.0,
                      ),
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
                                  icon: Icon(Icons.mail),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Material(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
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
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: 50.0,
                      child: FlatButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          try {
                            _validate();
                          } catch (e) {
                            print(e);
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: MediumTextStyle.apply(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Container(
                      height: 50.0,
                      child: FlatButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPage(),
                            ),
                          );
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Theme.of(context).accentColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                SizedBox(width: 27.0),
                                Text(
                                  "Signup",
                                  style: MediumTextStyle.apply(
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.angleRight,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      new InkWell(
                        child: new Text("Forget Password"),
                        onTap: () {},
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
}
