import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../flutterfire/get_video.dart';
import '../flutterfire/add_comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/get_all_comments.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/get_comments_count.dart';
import '../widgets/video_likes_buttons_info.dart';

class Video extends StatefulWidget {
  final String? videoPath;
  final String? videoId;
  final String? videoTitle;
  final String? videoDesc;
  final DateTime? videoCreatedAt;
  final String? author;
  final String? authorAvatarPath;
  final int? likes;
  final int? dislikes;

  const Video({
    Key? key,
    this.videoPath,
    this.videoId,
    this.videoTitle,
    this.videoDesc,
    this.videoCreatedAt,
    this.author,
    this.authorAvatarPath,
    this.likes,
    this.dislikes,
  }) : super(key: key);

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

  var months = [
    "sty",
    "lut",
    "mar",
    "kwi",
    "maj",
    "cze",
    "lip",
    "sie",
    "paź",
    "lis",
    "gru",
  ];

  var isLiked;
  int videoLikes = -1;
  int videoDislikes = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: BartekColorPalette.bartekGrey[900],
      body: Container(
        margin: const EdgeInsets.only(top: 40, right: 15, bottom: 15, left: 15),
        child: Column(
          children: [
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
                          widget.videoTitle!,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.videoCreatedAt!.day.toString() +
                              " " +
                              months[widget.videoCreatedAt!.month - 1] +
                              " " +
                              widget.videoCreatedAt!.year.toString(),
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
                        VideoLikesButtonInfo(videoId: widget.videoId),
                      ],
                    ),
                    Container(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: FutureBuilder(
                              future: FirebaseStorage.instance
                                  .ref(widget.authorAvatarPath)
                                  .getDownloadURL(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Image.network(
                                    snapshot.data.toString(),
                                    width: 42,
                                    height: 42,
                                  );
                                }
                                return Icon(
                                  FontAwesomeIcons.userCircle,
                                  color: BartekColorPalette.bartekGrey[50],
                                  size: 42,
                                );
                              },
                            ),
                          ),
                          Text(
                            widget.author.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GetCommentsCount(
                        videoId: widget.videoId,
                      ),
                    ),
                    Expanded(
                      child: Container(
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
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(currentUser!.uid)
                                                    .get()
                                                    .then((DocumentSnapshot
                                                        documentSnapshot) {
                                                  if (documentSnapshot.exists) {
                                                    String avatarPath =
                                                        documentSnapshot
                                                            .get('avatarPath')
                                                            .toString();
                                                    AddComment(
                                                            widget.videoId
                                                                .toString(),
                                                            currentUser!.uid,
                                                            currentUser!
                                                                .displayName,
                                                            avatarPath,
                                                            comment.text)
                                                        .addComm();
                                                  } else {
                                                    print(
                                                        'Document does not exist on the database');
                                                  }
                                                });
                                              }
                                            },
                                            icon: Icon(
                                              Icons.send,
                                              size: 24,
                                              color: Colors.white,
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: GetAllComments(
                                videoId: widget.videoId,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
