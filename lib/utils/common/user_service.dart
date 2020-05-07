import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forecast/models/user.dart';

final CollectionReference userCollection =
    Firestore.instance.collection('users');

class UserService {
  static final UserService _instance = UserService.internal();

  factory UserService() => _instance;

  UserService.internal();

  /// Referenced from https://pub.dev/packages/cloud_firestore
  /// User create function
  Future<User> createUser(
      String firstName, String lastName, String email, String imageUrl) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document());

      final User user = User(
        ds.documentID,
        firstName,
        lastName,
        email,
        imageUrl,
      );
      final Map<String, dynamic> data = user.toMap();

      await tx.set(ds.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return User.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  /// Referenced from https://pub.dev/packages/cloud_firestore
  /// User update function
  Future<dynamic> updateUser(User user) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds =
          await tx.get(userCollection.document(user.id));

      await tx.update(ds.reference, user.toMap());
      return {'updated': true};
    };

    return Firestore.instance
        .runTransaction(updateTransaction)
        .then((result) => result['updated'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }

  /// Referenced from https://pub.dev/packages/cloud_firestore
  /// Get user by id function
  Future<dynamic> getUserById(String id) async {
    DocumentSnapshot snapshot = await userCollection.document(id).get();
    return snapshot;
  }

  /// Referenced from https://pub.dev/packages/cloud_firestore
  ///Delete user function
  Future<dynamic> deleteUser(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document(id));

      await tx.delete(ds.reference);
      return {'deleted': true};
    };

    return Firestore.instance
        .runTransaction(deleteTransaction)
        .then((result) => result['deleted'])
        .catchError((error) {
      print('error: $error');
      return false;
    });
  }
}
