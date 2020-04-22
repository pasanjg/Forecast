import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:forecast/pages/login.dart';


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text("Forecast Signup"),
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
                                controller: rePassword,
                                style: new TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: " Re-type Password",
                                  errorText: _rePasswordError,
                                  icon: Icon(Icons.vpn_key),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
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
                      try {
                        _validate();
                      } catch(e) {
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
                          "Signup",
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signup(String email, String password) async {
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
        if(_success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
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
    String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void _validate() {
    _success = false;
    bool pw = true;
    bool rePw = true;
    bool em = true;

    if(!_passwordValidate(password.text)){
      _passwordError = "Please Enter 8 Character Password";
      pw = false;
      return;
    } else {
      _passwordError = null;
    }
    if(password.text.trim() != rePassword.text.trim()) {
      _rePasswordError = "Invalid Password";
      rePw = false;
      return;
    } else {
      _rePasswordError = null;
    }
    if(!_emailValidate(email.text.trim())) {
      _emailError = "Please Enter Valid Email";
      em = false;
      return;
    } else {
      _emailError = null;
    }
    if((em == true) && (pw == true) && (rePw == true)) {
      _signup(email.text.trim(), password.text.trim());
    }
  }
}
