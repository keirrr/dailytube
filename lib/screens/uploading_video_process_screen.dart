import 'dart:io';

import 'package:bartek_hub/flutterfire/add_video_doc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../flutterfire/storage_service.dart';

import '../bartek_color_palette.dart';
import './profile_login_screen.dart';

import 'package:fluttertoast/fluttertoast.dart';

class UploadingVideoProcess extends StatefulWidget {
  final String? filePath;
  final String? fileName;
  final String? title;
  final String? description;
  final String? category;

  const UploadingVideoProcess({
    Key? key,
    this.filePath,
    this.fileName,
    this.title,
    this.description,
    this.category,
  }) : super(key: key);

  @override
  _UploadingVideoProcessState createState() => _UploadingVideoProcessState();
}

class _UploadingVideoProcessState extends State<UploadingVideoProcess> {
  double progress = 0;
  bool isAddDocDone = false;

  @override
  void initState() {
    super.initState();
    uploadVideo();
  }

  callback(value) {
    print("callback");
    setState(() {
      isAddDocDone = value;
    });
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                extendBody: true,
                backgroundColor: BartekColorPalette.bartekGrey[900],
                body: Container(
                  margin: const EdgeInsets.only(
                      top: 40, right: 15, bottom: 55, left: 15),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [
                            Align(
                              alignment: Alignment.center,
                              child: Image(
                                height: 32,
                                image: AssetImage(
                                    'assets/images/bartekhub-logo.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: LinearProgressIndicator(
                          value: progress / 100,
                        ),
                      ),
                      Text(isAddDocDone.toString()),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return ProfileLogin();
          }
        },
      );

  Future uploadVideo() async {
    final Storage storage = Storage();

    var currentUser = FirebaseAuth.instance.currentUser;
    var userId = currentUser!.uid.toString();
    var id = new DateTime.now().millisecondsSinceEpoch;

    String filePath = widget.filePath.toString();
    String fileName = widget.fileName.toString();
    String title = widget.title.toString();
    String desc = widget.description.toString();
    String category = widget.category.toString();

    File file = File(filePath);

    UploadTask task =
        FirebaseStorage.instance.ref('videos/$fileName').putFile(file);

    task.snapshotEvents.listen((event) {
      setState(() {
        progress =
            ((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                    100)
                .roundToDouble();
      });

      if (event.state == TaskState.success) {
        Fluttertoast.showToast(msg: 'Film został przesłany');

        var random = new DateTime.now();

        var thumbName = "thumb_" + random.toString() + ".jpeg";

        storage.genThumbnailFile(filePath, thumbName);

        AddVideo(
          id: id.toString(),
          title: title,
          desc: desc,
          category: category,
          videoPath: 'videos/$fileName',
          thumbPath: 'thumbnails/$thumbName',
          author: userId,
          createdAt: DateTime.now(),
          callback: callback,
        );
      }
    }, onError: (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    });

    try {
      await task;
      print('Upload complete.');
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        print('User does not have permission to upload to this reference.');
      }
    }
  }
}
