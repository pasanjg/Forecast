import 'package:flutter/material.dart';
import 'package:forecast/widgets/current_weather/card_data.dart';

class TempDataCard extends StatelessWidget {
  final Color cardColor;
  final CardData cardData;

  TempDataCard({this.cardData, this.cardColor})
      : assert(
          cardData != null,
          'cardData cannot be null',
        );

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 0.3,
        color: this.cardColor,
        child: Container(
          height: 95.0,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: this.cardData,
          ),
        ),
      ),
    );
  }
}
