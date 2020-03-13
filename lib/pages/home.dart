import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:forecast/pages/weather_animations_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              DotEnv().env['APP_NAME'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlareAnimationsPage(),
                  ),
                );
              },
              color: Colors.blueAccent,
              child: Text("View Animations"),
            ),
          ],
        ),
      ),
    );
  }
}
