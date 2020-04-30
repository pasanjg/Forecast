import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  String _userEmail;
  bool isLoading = false;

// Signup function using firebse authentication
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
          _userEmail = user.email;
          print("User Email $_userEmail");
          if (_success) {
            _showFlutterToast("You can login now");
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

  void _showError(String errorCode) {
    switch (errorCode) {
      case 'ERROR_INVALID_EMAIL':
        _showFlutterToast("Invalid email format");

        break;
      case 'ERROR_USER_NOT_FOUND':
        _showFlutterToast("Invalid email or password");

        break;
      case 'ERROR_WRONG_PASSWORD':
        _showFlutterToast("Invalid email or password");

        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        _showFlutterToast("Email is already in use");

        break;
      case 'ERROR_WEAK_PASSWORD':
        _showFlutterToast("Password must be atleast 8 characters");

        break;
      default:
        _showFlutterToast("Something went wrong");
    }
  }

  void _showFlutterToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black87,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
    );
  }

//Password validator
  bool _passwordValidate(String value) {
    String pattern = r'^[a-zA-Z0-9]{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

//Email validator
  bool _emailValidate(String value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

//Validate user inputs
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
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                isLoading
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
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
                          SizedBox(
                            height: 15.0,
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
                          SizedBox(
                            height: 15.0,
                          ),
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
          ),
        ),
      ),
    );
  }
}
