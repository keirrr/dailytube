import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final String uid;
  final String username;

  AddUser(this.uid, this.username);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .add({
          'uid': uid,
          'username': username,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
