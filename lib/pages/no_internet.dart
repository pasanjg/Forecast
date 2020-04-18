import 'package:flutter/material.dart';

class NoInternetPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 250.0,
            width: 250.0 ,
            child: Image.asset('assets/images/no_internet.png'),
          ),
          SizedBox(height: 15.0),
          Text(
            "Whoops",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
          ),
          SizedBox(height: 10.0),
          Text(
            "Slow or no internet connection.\nPlease check your internet settings",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
