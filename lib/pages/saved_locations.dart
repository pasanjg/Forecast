import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/widgets/error/no_saved.dart';
import 'package:forecast/pages/home.dart';
import 'package:forecast/utils/animations/FadeAnimation.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

class SavedLocationsPage extends StatefulWidget {
  @override
  _SavedLocationsPageState createState() => _SavedLocationsPageState();
}

class _SavedLocationsPageState extends State<SavedLocationsPage> {
  String userId;
  DocumentReference documentReference;
  List savedLocations;
  String cityName, country;

  @override
  void initState() {
    super.initState();
    _getUserId();
    _getUserSavedLocations();
  }

  /// Code referred from Firebase Auth.
  /// See <https://pub.dev/packages/firebase_auth> for source.
  void _getUserId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      if (user != null) {
        this.userId = user.uid;
      }
    });
  }

  void _getUserSavedLocations() {
    documentReference =
        Firestore.instance.collection("savedLocations").document(this.userId);
  }

  Widget _buildFavouriteCard(String savedLocation) {
    List location = savedLocation.split(RegExp(",[A-Z]+\$"));
    this.cityName = location[0];

    RegExp exp = RegExp("[A-Z]+\$");
    this.country = exp.stringMatch(savedLocation).toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        elevation: 0.2,
        color: Theme.of(context).accentColor.withAlpha(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: ListTile(
            title: Text(
              cityName,
              style: RegularTextStyle,
            ),
            trailing: Container(
              height: 35.0,
              child: country != null
                  ? FadeInImage.assetNetwork(
                      placeholder: "assets/images/flag-loading.png",
                      image: "https://www.countryflags.io/$country/flat/64.png",
                    )
                  : Image.asset("assets/images/flag-loading.png"),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text("Saved Locations"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: DefaultGradient(
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection("users")
              .document(userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (this.userId == null) {
              return NoSaved();
            }
            if (snapshot.hasData) {
              savedLocations = snapshot.data["savedLocations"];
              if (savedLocations != null && savedLocations.isNotEmpty) {
                return ListView.builder(
                  itemCount: savedLocations.length,
                  itemBuilder: (context, int index) {
                    return FadeAnimation(
                      delay: index * 0.1,
                      child: InkWell(
                        onTap: () {
                          showFlutterToast("Loading location");
                          Navigator.of(context).pop();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(
                                cityName: savedLocations[index],
                              ),
                            ),
                          );
                        },
                        child: _buildFavouriteCard(
                          savedLocations[index].toString(),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return NoSaved();
              }
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
