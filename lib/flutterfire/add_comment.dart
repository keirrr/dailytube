import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddComment {
  final String videoId;
  final String userId;
  final String comment;
  final String? username;

  AddComment(this.videoId, this.userId, this.username, this.comment);

  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  User? currentUser = FirebaseAuth.instance.currentUser;

  var timestamp = new DateTime.now();

  Future<void> addComm() {
    return comments.add({
      'videoId': videoId,
      'userId': userId,
      'username': currentUser!.displayName,
      'comment': comment,
      'timestamp': timestamp
    }).then((value) => print("Comment added"));
  }
}
