import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:forecast/models/user.dart';
import 'package:forecast/utils/common/common_utils.dart';
import 'package:forecast/utils/common/constants.dart';
import 'package:forecast/utils/common/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserService userService = UserService();

  File file;
  User _user;
  bool _status = true;
  bool isUploaded = true;
  bool isLoading = false;
  String _uid;
  String _email = "email";
  String fileType = '';
  String fileName = '';
  String operationText = '';
  String result = '';
  String url;
  var ref;

  TextEditingController _fNameController;
  TextEditingController _lNameController;

  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _currentUser();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    /// Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  /// Action buttons widget
  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 50.0,
              child: FlatButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  setState(() {
                    _status = false;
                    _updateUser(_uid);
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Update",
                      style: MediumTextStyle.apply(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: 50.0,
              child: FlatButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel",
                      style: MediumTextStyle.apply(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Referenced from https://pub.dev/packages/firebase_auth
  /// Get the current user data function
  Future<void> _currentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    if (user != null) {
      setState(() {
        _uid = user.uid;
      });

      DocumentSnapshot snapshot = await userService.getUserById(_uid);
      setState(() {
        this._user = User(
            snapshot.data['id'],
            snapshot.data['firstName'],
            snapshot.data['lastName'],
            snapshot.data['email'],
            snapshot.data['imageUrl']);

        _email = _user.email;
        _fNameController = TextEditingController(text: _user.firstName);
        _lNameController = TextEditingController(text: _user.lastName);
      });
    }
  }

  /// User details update function
  Future<void> _updateUser(String id) async {
    await userService
        .updateUser(
      User(
        id,
        _fNameController.text,
        _lNameController.text,
        _user.email,
        _user.imageUrl,
      ),
    )
        .then((onValue) async {
      _status = true;
      await _currentUser();
    });
    showFlutterToast("Profile updated");
  }

  /// Reference from https://pub.dev/packages/file_picker
  /// File picker function
  Future<void> filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.image);
        setState(() {
          fileName = _uid;
        });
        _uploadFile(file, fileName);
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }
  }

  /// Referenced from https://pub.dev/packages/firebase_storage
  /// Profile picture upload function
  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference =
          FirebaseStorage.instance.ref().child("images/$filename");
      setState(() {
        isLoading = true;
      });
    }

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String newUrl = (await downloadUrl.ref.getDownloadURL());
    await userService.updateUser(
      _user = User(
        _uid,
        _user.firstName,
        _user.lastName,
        _user.email,
        newUrl,
      ),
    );

    setState(() {
      this.url = newUrl;
      isLoading = false;
    });
  }

  _handleAutoScroll() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color _cardColor = Colors.black.withAlpha(20);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: DefaultGradient(
        child: ListView(
          controller: _controller,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Stack(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              setState(() {
                                fileType = 'image';
                              });
                              filePicker(context);
                            },
                            child: CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 140.0,
                                  height: 140.0,
                                  child: _user != null
                                      ? FadeInImage.assetNetwork(
                                          placeholder:
                                              "assets/images/forecast-logo.png",
                                          image: _user.imageUrl.toString(),
                                        )
                                      : Text(""),
                                ),
                              ),
                            ),
                          ),
                          isLoading
                              ? Positioned(
                                  top: 50.0,
                                  left: 50.0,
                                  child: CircularProgressIndicator(),
                                )
                              : SizedBox(width: 1.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                color: _cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Email Address',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 180.0,
                        child: Text(
                          _email != null ? _email : "",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Card(
                color: _cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'First Name ',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 180.0,
                              child: TextField(
                                controller: _fNameController,
                                decoration: InputDecoration(
                                  border: _status ? InputBorder.none : null,
                                  hintText: "Enter First Name ",
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                enabled: !_status,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Last Name',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 180.0,
                              child: TextField(
                                controller: _lNameController,
                                decoration: InputDecoration(
                                  border: _status ? InputBorder.none : null,
                                  hintText: "Enter Last Name",
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                enabled: !_status,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            !_status ? _getActionButtons() : Container(),
          ],
        ),
      ),
      floatingActionButton: _status
          ? Container(
              height: 40.0,
              width: 40.0,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _status = false;
                  });
                  Timer(
                    Duration(milliseconds: 500),
                    _handleAutoScroll,
                  );
                },
                elevation: 0.1,
                backgroundColor: Colors.white,
                child: Icon(
                  FontAwesomeIcons.userEdit,
                  size: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          : Container(),
    );
  }
}
