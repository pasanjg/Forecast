import 'package:flutter/material.dart';
import 'package:forecast/utils/common/constants.dart';

class NoSaved extends StatelessWidget {
  final snackBar = SnackBar(
    content: Text(
      'Save locations by double tapping on the Home screen or pressing the favourite icon',
    ),
    action: SnackBarAction(
      textColor: Colors.white,
      label: 'Okay',
      onPressed: () {},
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 250.0,
              child: Image.asset('assets/images/no_saved.png'),
            ),
            SizedBox(height: 15.0),
            Text(
              "Nothing here",
              style: HeadingTextStyle.apply(
                letterSpacingFactor: 0,
                heightFactor: 0.5,
              ),
            ),
            SizedBox(height: 15.0),
            Text(
              "Save locations that you want to check quickly.\n"
              "All your saved locations will be listed here",
              textAlign: TextAlign.center,
              style: RegularTextStyle.apply(heightFactor: 1.2),
            ),
          ],
        ),
      ),
    );
  }
}
