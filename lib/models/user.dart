/// User Model Class

class User {
  String _id;
  String _firstName;
  String _lastName;
  String _email;
  String _imageUrl;

  User(this._id, this._firstName, this._lastName, this._email, this._imageUrl);

  User.map(dynamic obj) {
    this._id = obj['id'];
    this._firstName = obj['firstName'];
    this._lastName = obj['lastName'];
    this._email = obj['email'];
    this._imageUrl = obj['imageUrl'];
  }

  String get id => _id;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get email => _email;

  String get imageUrl => _imageUrl;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['firstName'] = _firstName;
    map['lastName'] = _lastName;
    map['email'] = _email;
    map['imageUrl'] = _imageUrl;
    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._firstName = map['firstName'];
    this._lastName = map['lastName'];
    this._email = map['email'];
    this._imageUrl = map['imageUrl'];
  }
}
