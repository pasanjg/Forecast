import 'package:flutter/material.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String unitDropdownValue;
  bool isOut = false;

  @override
  void initState() {
    super.initState();
    AppSharedPreferences.getStringSharedPreferences("units").then((value) {
      setState(() {
        unitDropdownValue = CommonUtils.getTemperatureValue(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Settings"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: <Color>[
              Theme.of(context).accentColor,
              Theme.of(context).primaryColor,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Temperature unit",
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                      DropdownButton<String>(
                        value: unitDropdownValue,
                        icon: Icon(null),
                        iconSize: 15,
                        elevation: 16,
                        underline: Container(
                          height: 0.0,
                          color: Colors.grey,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            unitDropdownValue = newValue;
                            AppSharedPreferences.setStringSharedPreferences(
                                "units",
                                CommonUtils.getTemperatureAPIUnit(newValue));
                          });
                        },
                        items: <String>["Celsius", "Fahrenheit", "Kelvin"]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    "Terms of service",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.centerLeft,
                  height: 60.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Text(
                    "Privacy policy",
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 60.0,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Version 1.0",
                  style: TextStyle(
                    color: Colors.white30,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
