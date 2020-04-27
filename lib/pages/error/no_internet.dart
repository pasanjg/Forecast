import 'package:flutter/material.dart';
import 'package:forecast/utils/common/constants.dart';

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
            width: 250.0,
            child: Image.asset('assets/images/no_internet.png'),
          ),
          SizedBox(height: 15.0),
          Text(
            "Whoops!",
            style: HeadingTextStyle.apply(
              letterSpacingFactor: 0,
              heightFactor: 0.5,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "Slow or no internet connection.\n"
            "Please check your internet settings",
            textAlign: TextAlign.center,
            style: RegularTextStyle.apply(heightFactor: 1.2),
          ),
        ],
      ),
    );
  }
}
