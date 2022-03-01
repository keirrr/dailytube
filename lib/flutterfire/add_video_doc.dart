import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AddVideo extends StatefulWidget {
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
  }) : super(key: key);

  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  CollectionReference users = FirebaseFirestore.instance.collection('videos');

  Future<void> addVideo() {
    return users.add({
      'id': widget.id,
      'title': widget.title,
      'desc': widget.desc,
      'category': widget.category,
      'video_path': widget.videoPath,
      'thumb_path': widget.thumbPath,
      'author': widget.author,
      'createdAt': widget.createdAt,
    }).then((value) {
      print("done");
      setState(() {
        widget.callback!(true);
      });
    }).catchError((error) => print("Failed to add video: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
