import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:forecast/models/user.dart';
import 'package:forecast/utils/common/user_profile.dart';
import 'package:forecast/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:forecast/widgets/background/default_gradient.dart';

class ProfilePage extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserProfileService db = UserProfileService();
  File file;
  User _user;
  bool _status = true;
  bool isUploaded = true;
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

  @override
  void initState() {
    super.initState();
    _currentUser();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

//Aaction buttions widget
  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                child: RaisedButton(
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Color(0xFF4A148C),
                  onPressed: () {
                    setState(() {
                      _status = false;
                      _updateUser(_uid);
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                child: RaisedButton(
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      _status = true;
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ),
              ),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

//Edit icon widget
  Widget _getEditIcon() {
    return GestureDetector(
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

//Get the current user data function
  void _currentUser() async {
    final FirebaseUser user = (await _auth.currentUser());
    if (user != null) {
      setState(() {
        _uid = user.uid;
      });
      DocumentSnapshot snapshot = await db.getUserById(_uid);
      print(snapshot.data);
      _user = User(snapshot.data['id'], snapshot.data['firstName'],
          snapshot.data['lastName'], snapshot.data['email'], snapshot.data['imageUrl']);
      _email = _user.email;
      _fNameController = TextEditingController(text: _user.firstName);
      _lNameController = TextEditingController(text: _user.lastName);
      _getImageUrl();
    } else {
      print("Unsuccess!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

//User dat update function
  void _updateUser(String id) async {
    db
        .updateUser(
      User(
        id,
        _fNameController.text,
        _lNameController.text,
        _user.email,
        _user.imageUrl
      )
    )
        .then((onValue) {
      _status = true;
      initState();
    });
  }

//File picker function
  Future filePicker(BuildContext context) async {
    try {
      if (fileType == 'image') {
        file = await FilePicker.getFile(type: FileType.image);
        setState(() {
          fileName = _uid;
        });
        print(fileName);
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

//Profile picture upload function
  Future<void> _uploadFile(File file, String filename) async {
    StorageReference storageReference;
    if (fileType == 'image') {
      storageReference =
          FirebaseStorage.instance.ref().child("images/$filename");
    }
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    print("URL is $url");
    db.updateUser(
        User(
          _uid,
          _user.firstName,
          _user.lastName,
          _user.email,
          url
        ));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

//Image url generate function
  void _getImageUrl() async {
    StorageReference ref = FirebaseStorage.instance.ref().child("images/$_uid");
    String _url = (await ref.getDownloadURL()).toString();
    url = _url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: DefaultGradient(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 250.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Stack(
                          fit: StackFit.loose,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.transparent,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 140.0,
                                      height: 140.0,
                                      child: url == null
                                          ? Image.asset(
                                              'assets/images/forecast-logo.png')
                                          : Image.network(url),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 130.0, right: 100.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 20.0,
                                      child: Icon(
                                        Icons.photo,
                                        color: Colors.white,
                                        size: 25.0,
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        fileType = 'image';
                                      });
                                      filePicker(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25.0,
                            right: 25.0,
                            top: 2.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Personal Information',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25.0,
                            right: 25.0,
                            top: 25.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Email Address',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                _email,
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 25.0,
                            right: 25.0,
                            top: 25.0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'First Name ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _fNameController,
                                  decoration: const InputDecoration(
                                      hintText: "Enter First Name ",
                                      hintStyle: TextStyle(color: Colors.white),
                                  ),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 25.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Last Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Flexible(
                                child: TextField(
                                  controller: _lNameController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter Last Name",
                                    hintStyle: TextStyle(
                                      color: Colors.white
                                      ),
                                  ),
                                  enabled: !_status,
                                ),
                              ),
                            ],
                          ),
                        ),
                        !_status ? _getActionButtons() : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
