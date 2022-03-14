import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final String uid;
  final String username;

  AddUser(this.uid, this.username);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'username': username,
          'avatarPath': 'avatars/default-avatar.jpg',
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
