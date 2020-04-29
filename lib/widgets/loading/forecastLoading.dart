import 'package:flutter/material.dart';

class ForecastLoading extends StatelessWidget {

  Widget _loadingElement(){
    return Container(
      height: 80.0,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            height: 15.0,
            width: 50.0,
          ),
          SizedBox(height: 5.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            height: 30.0,
            width: 50.0,
          ),
          SizedBox(height: 5.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            height: 15.0,
            width: 50.0,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color _cardColor = Colors.black.withAlpha(20);
    return Container(
      child: Card(
        elevation: 0.3,
        color: _cardColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 20.0,
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _loadingElement(),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.3),
                ),
                _loadingElement(),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.3),
                ),
                _loadingElement(),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.3),
                ),
                _loadingElement(),
                VerticalDivider(
                  color: Colors.white.withOpacity(0.3),
                ),
                _loadingElement(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

