import 'package:flutter/material.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/shared_preferences.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String unitDropdownValue;

  @override
  void initState() {
    super.initState();
    AppSharedPreferences.getStringSharedPreferences("units").then((value) {
      setState(() {
        unitDropdownValue = getTemperatureValue(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: DefaultGradient(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
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
                            style: RegularTextStyle,
                          ),
                          DropdownButton<String>(
                            value: unitDropdownValue,
                            icon: Icon(null),
                            elevation: 16,
                            underline: Container(
                              height: 0.0,
                              color: Colors.grey,
                            ),
                            style: MediumTextStyle,
                            onChanged: (String newValue) {
                              setState(() {
                                unitDropdownValue = newValue;
                                AppSharedPreferences.setStringSharedPreferences(
                                  "units",
                                  getTemperatureAPIUnit(newValue),
                                );
                              });
                            },
                            items: <String>["Celsius", "Fahrenheit", "Kelvin"]
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: SmallTextStyle,
                                ),
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
                        style: RegularTextStyle,
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
                        style: RegularTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Version 1.0.0",
                      style: SmallTextStyle.apply(
                        color: Colors.white30,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 18.0,
                      child: Image.asset(
                        "assets/images/openweathermap-logo.png",
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
