import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddVideo {
  final String title;
  final String desc;
  final String category;
  final String videoPath;
  final String thumbPath;
  final String author;
  final DateTime timestamp;

  AddVideo(this.title, this.desc, this.category, this.videoPath, this.thumbPath,
      this.author, this.timestamp);
  CollectionReference users = FirebaseFirestore.instance.collection('videos');

  Future<void> addVideo() {
    return users
        .add({
          'title': title,
          'desc': desc,
          'category': category,
          'video_path': videoPath,
          'thumb_path': thumbPath,
          'author': author,
          'timestamp': timestamp,
        })
        .then((value) => print("Video Added"))
        .catchError((error) => print("Failed to add video: $error"));
  }
}
