import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser {
  final String username;
  final String password;

  AddUser(this.username, this.password);

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    return users
        .add({
          'username': username,
          'password': password,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
