import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<void> uploadFile(
      String filePath, String fileName, double progress) async {
    File file = File(filePath);

    UploadTask task =
        FirebaseStorage.instance.ref('videos/$fileName').putFile(file);

    task.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Task state: ${snapshot.state}');
      print(
          'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
      progress = (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
    }, onError: (e) {
      print(task.snapshot);

      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    // We can still optionally use the Future alongside the stream.
    try {
      await task;
      print('Upload complete.');
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
      // ...
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
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  Future<String> downloadUrl(String path) async {
    String downloadUrl = await storage.ref(path).getDownloadURL();

    return downloadUrl;
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}