import 'package:flutter/material.dart';

class CardData extends StatelessWidget {
  final Widget topElement;
  final Widget middleElement;
  final Widget bottomElement;

  CardData({this.topElement, this.middleElement, this.bottomElement})
      : assert(
          topElement != null && middleElement != null && bottomElement != null,
          'Elements cannot be null',
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        this.topElement,
        this.middleElement,
        this.bottomElement,
      ],
    );
  }
}
