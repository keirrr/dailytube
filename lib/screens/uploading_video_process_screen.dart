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
  final GlobalKey<FormState>? formKey;
  final Function? clearFormCallback;

  const UploadingVideoProcess({
    Key? key,
    this.filePath,
    this.fileName,
    this.title,
    this.description,
    this.category,
    this.formKey,
    this.clearFormCallback,
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
    setState(() {
      isAddDocDone = value;
    });
    if (isAddDocDone == true) Navigator.pop(context);
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Czy na pewno chcesz cofnąć?"),
            content: Text(
              "Anuluje to wysyłanie filmu",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: Text(
                  "Nie",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  "Tak",
                  style: TextStyle(color: BartekColorPalette.orange[900]),
                ),
              ),
            ],
            backgroundColor: BartekColorPalette.bartekGrey[50],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: _onWillPop,
        child: StreamBuilder<User?>(
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
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 300,
                              height: 100,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: LinearProgressIndicator(
                                      value: progress / 100,
                                      color: BartekColorPalette.bartekGrey[100],
                                      backgroundColor:
                                          BartekColorPalette.bartekGrey[50],
                                      minHeight: 100,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              "Przesyłanie filmu",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Text(
                                            progress.toString() +
                                                "% • " +
                                                "mniej niż minuta",
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: LinearProgressIndicator(
                                          value: progress / 100,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          backgroundColor:
                                              BartekColorPalette.orange[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return ProfileLogin();
            }
          },
        ),
      );

  Future uploadVideo() async {
    final Storage storage = Storage();

    var currentUser = FirebaseAuth.instance.currentUser;
    var userId = currentUser!.uid.toString();
    var id = DateTime.now().millisecondsSinceEpoch.toString();

    String filePath = widget.filePath.toString();
    String fileName = widget.fileName.toString();
    String title = widget.title.toString();
    String desc = widget.description.toString();
    String category = widget.category.toString();

    // Final File Name
    var fileNameSplit = fileName.split('.');
    String ext = fileNameSplit.last.toString();
    String finalFileName = fileNameSplit[0] + id + "." + ext;

    File file = File(filePath);

    UploadTask task =
        FirebaseStorage.instance.ref('videos/$finalFileName').putFile(file);

    task.snapshotEvents.listen((event) {
      setState(() {
        progress =
            ((event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                    100)
                .roundToDouble();
      });

      if (event.state == TaskState.success) {
        FocusManager.instance.primaryFocus?.unfocus();
        widget.formKey?.currentState?.reset();

        widget.clearFormCallback!();

        var thumbName = "thumb_" + id + ".jpeg";

        storage.genThumbnailFile(filePath, thumbName);

        AddVideo(
          id: id.toString(),
          title: title,
          desc: desc,
          category: category,
          videoPath: 'videos/$finalFileName',
          thumbPath: 'thumbnails/$thumbName',
          author: userId,
          createdAt: DateTime.now(),
          callback: callback,
        ).addVideo();

        Fluttertoast.showToast(msg: 'Film został przesłany');
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
