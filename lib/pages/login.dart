import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _FlareAnimationsPageState createState() => _FlareAnimationsPageState();
}

class _FlareAnimationsPageState extends State<LoginPage> {
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
                        AssetImage('assets/images/shop_logo.png'),
                        radius: 25.0,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        "Forecast",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 45.0,
                          child: FlatButton(
                            color: Colors.white,
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(40.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 20.0,
                                  child: Image.asset(
                                      'assets/images/google_logo.png'),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  "Login with Google",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            Material(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Email",
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
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    hintText: "Password",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
//                            builder: (context) => ReviewsPage(),
                          ),
                        );
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
                  Text(),
                ],
              ),
            ),
          ),
        ),
    );

  }
}
