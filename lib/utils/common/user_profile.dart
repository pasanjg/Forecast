import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:forecast/models/user.dart';

final CollectionReference userCollection = Firestore.instance.collection('users');

class UserProfileService {

  static final UserProfileService _instance = new UserProfileService.internal();

  factory UserProfileService() => _instance;

  UserProfileService.internal();

  Future<User> createUser(String firstName, String lastName, String email) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document());

      final User user = new User(ds.documentID, firstName, lastName, email);
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

  Stream<QuerySnapshot> getUserList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = userCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }

    if (limit != null) {
      snapshots = snapshots.take(limit);
    }

    return snapshots;
  }

  Future<dynamic> updateUser(User user) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(userCollection.document(user.id));

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
  Future<dynamic> getUserById(String id) async {
    DocumentSnapshot snapshot = await userCollection.document(id).get();
    return snapshot;
  }

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
