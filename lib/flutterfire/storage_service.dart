import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/cupertino.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadFile(String filePath, String fileName) async {
    File file = File(filePath);

    try {
      await storage.ref('videos/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<void> genThumbnailFile(String videoPath, String thumbName) async {
    final String? thumbnail = await VideoThumbnail.thumbnailFile(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 720,
      maxWidth: 1280,
      quality: 10,
    );

    try {
      await storage
          .ref('thumbnails/$thumbName')
          .putFile(File(thumbnail.toString()));
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> downloadUrl(String path) async {
    String downloadUrl = await storage.ref(path).getDownloadURL();

    return downloadUrl;
  }
}
