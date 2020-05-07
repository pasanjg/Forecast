import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

class SignupPage extends StatefulWidget {
  @override
  _FlareAnimationsPageState createState() => _FlareAnimationsPageState();
}

class _FlareAnimationsPageState extends State<SignupPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  final rePassword = TextEditingController();

  String _emailError;
  String _passwordError;
  String _rePasswordError;
  bool _success;
  String userEmail;
  bool isLoading = false;

  /// Referenced from https://pub.dev/packages/firebase_auth
  /// Signup function using firebase authentication
  void _signup(String email, String password) async {
    setState(() {
      isLoading = true;
    });

    try {
      final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      if (user != null) {
        setState(() {
          _success = true;
          isLoading = false;
          userEmail = user.email;

          if (_success) {
            showFlutterToast("You can login now");
            Navigator.pop(context);
          }
        });
      } else {
        _success = false;
      }
    } catch (e) {
      print(e);
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
    RegExp regExp = RegExp(patternPassword);
    return regExp.hasMatch(val);
  }

  /// Email validator
  bool _emailValidate(String val) {
    String patternEmail =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(patternEmail);
    return regExp.hasMatch(val);
  }

  /// Validate user inputs
  void _validate() {
    _success = false;
    bool pw = true;
    bool rePw = true;
    bool em = true;

    if (!_passwordValidate(password.text)) {
      _passwordError = "Please Enter 8 Character Password";
      pw = false;
      return;
    } else {
      _passwordError = null;
    }
    if (password.text.trim() != rePassword.text.trim()) {
      _rePasswordError = "Invalid Password";
      rePw = false;
      return;
    } else {
      _rePasswordError = null;
    }
    if (!_emailValidate(email.text.trim())) {
      _emailError = "Please Enter Valid Email";
      em = false;
      return;
    } else {
      _emailError = null;
    }
    if ((em == true) && (pw == true) && (rePw == true)) {
      _signup(email.text.trim(), password.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Create new Account"),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: DefaultGradient(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.79,
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    'assets/images/forecast-logo.png',
                                  ),
                                  radius: 50.0,
                                ),
                                isLoading
                                    ? Positioned(
                                        top: 30.0,
                                        left: 30.0,
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                            SizedBox(height: 50.0)
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
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0,
                                      ),
                                      child: TextFormField(
                                        controller: email,
                                        style: TextStyle(color: Colors.black),
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
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        obscureText: true,
                                        controller: password,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          hintText: "Password",
                                          errorText: _passwordError,
                                          icon: Icon(Icons.vpn_key),
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
                                        controller: rePassword,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          hintText: " Re-type Password",
                                          errorText: _rePasswordError,
                                          icon: Icon(Icons.vpn_key),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
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
                              try {
                                _validate();
                              } catch (e) {
                                print(e);
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
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
                                  "Signup",
                                  style: RegularTextStyle.apply(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
