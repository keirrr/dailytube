import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../flutterfire/get_video.dart';
import '../flutterfire/add_comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/get_all_comments.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../widgets/get_comments_count.dart';

class Video extends StatefulWidget {
  final String? videoPath;
  final String? videoId;
  const Video({Key? key, this.videoPath, this.videoId}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
  final _formKey = GlobalKey<FormState>();

  final comment = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  final commentValidator = MultiValidator([
    RequiredValidator(errorText: 'Nie można wysłać pustego komentarza'),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: BartekColorPalette.bartekGrey[900],
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 40, right: 15, bottom: 55, left: 15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        height: 32,
                        image: AssetImage('assets/images/bartekhub-logo.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  GetVideo(videoPath: widget.videoPath),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Title",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Dodano 10.02.2022",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // bool isPostLiked;
                                  // Future<QuerySnapshot> docSnapshot =
                                  //     FirebaseFirestore.instance
                                  //         .collection('videos')
                                  //         .where("videoId", isEqualTo: "2")
                                  //         .get();
                                  // QuerySnapshot doc = await docSnapshot;
                                  // if (doc.docs[0]['likes']
                                  //     .contains(currentUser!.uid)) {
                                  //   isPostLiked = true;
                                  // } else {
                                  //   print(doc.docs[0].data());
                                  //   isPostLiked = false;
                                  // }
                                },
                                splashRadius: 25,
                                icon: const Icon(Icons.thumb_up,
                                    color: Color.fromARGB(255, 122, 128, 132),
                                    size: 32),
                              ),
                              Text(
                                "103",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // bool isPostLiked;
                                  // Future<QuerySnapshot> docSnapshot =
                                  //     FirebaseFirestore.instance
                                  //         .collection('videos')
                                  //         .where("videoId", isEqualTo: "2")
                                  //         .get();
                                  // QuerySnapshot doc = await docSnapshot;
                                  // if (doc.docs[0]['likes']
                                  //     .contains(currentUser!.uid)) {
                                  //   isPostLiked = true;
                                  // } else {
                                  //   print(doc.docs[0].data());
                                  //   isPostLiked = false;
                                  // }
                                },
                                splashRadius: 25,
                                icon: const Icon(Icons.thumb_down,
                                    color: Color.fromARGB(255, 122, 128, 132),
                                    size: 32),
                              ),
                              Text(
                                "103",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          IconButton(
                            onPressed: () async {},
                            splashRadius: 25,
                            icon: const Icon(Icons.share,
                                color: Color.fromARGB(255, 122, 128, 132),
                                size: 32),
                          ),
                        ],
                      ),
                      Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                FontAwesomeIcons.userCircle,
                                color: BartekColorPalette.bartekGrey[50],
                                size: 42,
                              ),
                            ),
                            Text("username"),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GetCommentsCount(
                        videoId: widget.videoId,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        right: 15,
                        bottom: 20,
                        left: 15,
                      ),
                      child: Column(
                        children: [
                          Form(
                            key: _formKey,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: comment,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: EdgeInsets.all(10.0),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200.0),
                                        borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          width: 2.0,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor:
                                          BartekColorPalette.bartekGrey[100],
                                      hintText: "Napisz komentarz",
                                      hintStyle:
                                          TextStyle(color: Colors.white70),
                                    ),
                                    validator: commentValidator,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      child: IconButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              AddComment(
                                                      widget.videoId.toString(),
                                                      currentUser!.uid,
                                                      currentUser!.displayName,
                                                      comment.text)
                                                  .addComm();
                                            }
                                          },
                                          icon: Icon(
                                            Icons.send,
                                            size: 24,
                                            color: Colors.white,
                                          )),
                                    ),
                                    // child: ElevatedButton(
                                    //   onPressed: () {
                                    //     AddComment(
                                    //             widget.videoId.toString(),
                                    //             currentUser!.uid,
                                    //             currentUser!.displayName,
                                    //             comment.text)
                                    //         .addComm();
                                    //   },
                                    //   child: const Icon(Icons.send, size: 24),
                                    //   style: ButtonStyle(
                                    //     backgroundColor:
                                    //         MaterialStateProperty.all(
                                    //             Theme.of(context)
                                    //                 .colorScheme
                                    //                 .secondary),
                                    //     shape: MaterialStateProperty.all<
                                    //         RoundedRectangleBorder>(
                                    //       RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(100.0),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GetAllComments(
                            videoId: widget.videoId,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
