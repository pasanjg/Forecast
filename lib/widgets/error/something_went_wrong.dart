import 'package:flutter/material.dart';
import 'package:forecast/utils/common/constants.dart';

class SomethingWentWrong extends StatelessWidget {
  final message;

  SomethingWentWrong({this.message});

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
            child: Image.asset('assets/images/something_wrong.png'),
          ),
          SizedBox(height: 15.0),
          Text(
            "Something went wrong!",
            style: HeadingTextStyle.apply(
              letterSpacingFactor: 0,
              heightFactor: 0.5,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            this.message != null
                ? this.message
                : "Please try again, sorry",
            textAlign: TextAlign.center,
            style: RegularTextStyle.apply(heightFactor: 1.2),
          ),
        ],
      ),
    );
  }
}
