import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddVideo {
  final String? id;
  final String? title;
  final String? desc;
  final String? category;
  final String? videoPath;
  final String? thumbPath;
  final String? author;
  final DateTime? createdAt;
  Function? callback;

  AddVideo({
    Key? key,
    this.id,
    this.title,
    this.desc,
    this.category,
    this.videoPath,
    this.thumbPath,
    this.author,
    this.createdAt,
    this.callback,
  });

  CollectionReference users = FirebaseFirestore.instance.collection('videos');

  Future<void> addVideo() async {
    return await users.add({
      'id': id,
      'title': title,
      'desc': desc,
      'category': category,
      'video_path': videoPath,
      'thumb_path': thumbPath,
      'author': author,
      'createdAt': createdAt,
    }).then((value) {
      callback!(true);
    }).catchError((error) => print("Failed to add video: $error"));
  }
}
