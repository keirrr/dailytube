import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdateUserDesc {
  final String? userId;
  final String? desc;

  UpdateUserDesc({this.desc, this.userId});

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future updateUser(BuildContext context) {
    return users.doc(userId).update({'description': desc}).then((value) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'Opis został zaktualizowany');
    });
  }
}
