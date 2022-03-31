import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import '../bartek_color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../flutterfire/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/video_player_screen.dart';

class DisplayAllVideos extends StatelessWidget {
  final Storage storage = new Storage();
  final User? user = FirebaseAuth.instance.currentUser;

  final String? category;

  DisplayAllVideos({Key? key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CollectionReference videos =
        FirebaseFirestore.instance.collection('videos');

    print(category);

    return FutureBuilder<QuerySnapshot>(
      future: category == null
          ? videos.orderBy('createdAt').get()
          : videos
              .where('category', isEqualTo: category)
              .orderBy('createdAt')
              .get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          var documents = snapshot.data!;
          return Column(
            children: [
              for (var i = 0; i < documents.docs.length; i += 2)
                if (i < documents.docs.length - 1)
                  Row(
                    children: [
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            margin:
                                const EdgeInsets.only(right: 5.0, bottom: 10),
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: storage.downloadUrl(
                                      snapshot.data!.docs[i]['thumb_path']),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return FractionallySizedBox(
                                        widthFactor: 1,
                                        child: InkWell(
                                          onTap: () => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Video(
                                                  videoPath: documents.docs[i]
                                                          ['video_path']
                                                      .toString(),
                                                  videoId: documents.docs[i]
                                                          ['id']
                                                      .toString(),
                                                  videoTitle: documents.docs[i]
                                                          ['title']
                                                      .toString(),
                                                  videoDesc: documents.docs[i]
                                                          ['desc']
                                                      .toString(),
                                                  videoCreatedAt: documents
                                                      .docs[i]['createdAt']
                                                      .toDate(),
                                                  author: documents.docs[i]
                                                          ['author']
                                                      .toString(),
                                                  authorAvatarPath: documents
                                                      .docs[i]
                                                          ['authorAvatarPath']
                                                      .toString(),
                                                  likes: documents.docs[i]
                                                      ['likes'],
                                                  dislikes: documents.docs[i]
                                                      ['dislikes'],
                                                ),
                                              ),
                                            )
                                          },
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: ClipRRect(
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            child: Image.network(
                                              snapshot.data!.toString(),
                                              height: 125,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      );
                                    }

                                    return FractionallySizedBox(
                                      widthFactor: 1,
                                      child: Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: BartekColorPalette
                                              .bartekGrey[100],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data!.docs[i]['title'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text((() {
                                          var time = documents.docs[i]
                                                  ['createdAt']
                                              .toDate();

                                          var timeNow = new DateTime.now();
                                          var difference =
                                              timeNow.difference(time);

                                          var timeDiffMinutes =
                                              difference.inMinutes;
                                          var timeDiffHours =
                                              difference.inHours;
                                          var timeDiffDays = difference.inDays;

                                          var timeDiff;

                                          if (timeDiffDays > 0) {
                                            if (timeDiffHours == 1) {
                                              timeDiff =
                                                  timeDiffDays.toString() +
                                                      " dzień temu";
                                            } else {
                                              timeDiff =
                                                  timeDiffDays.toString() +
                                                      " dni temu";
                                            }
                                          } else if (timeDiffHours > 0) {
                                            if (timeDiffHours == 1) {
                                              timeDiff = "Godzinę temu";
                                            } else {
                                              timeDiff =
                                                  timeDiffHours.toString() +
                                                      " godzin temu";
                                            }
                                          } else if (timeDiffMinutes > 0) {
                                            if (timeDiffHours == 1) {
                                              timeDiff = "Minutę temu";
                                            } else {
                                              timeDiff =
                                                  timeDiffMinutes.toString() +
                                                      " minut temu";
                                            }
                                          } else if (timeDiffMinutes == 0) {
                                            timeDiff = "Teraz";
                                          }

                                          return timeDiff;
                                        }()))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            margin: const EdgeInsets.only(left: 5, bottom: 10),
                            child: Column(
                              children: [
                                FutureBuilder(
                                  future: storage.downloadUrl(
                                      snapshot.data!.docs[i + 1]['thumb_path']),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return FractionallySizedBox(
                                        widthFactor: 1,
                                        child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            snapshot.data.toString(),
                                            height: 125,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }

                                    return FractionallySizedBox(
                                      widthFactor: 1,
                                      child: Container(
                                        height: 125,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: BartekColorPalette
                                              .bartekGrey[100],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data!.docs[i + 1]['title'],
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text((() {
                                          var time = documents.docs[i + 1]
                                                  ['createdAt']
                                              .toDate();

                                          var timeNow = new DateTime.now();
                                          var difference =
                                              timeNow.difference(time);

                                          var timeDiffMinutes =
                                              difference.inMinutes;
                                          var timeDiffHours =
                                              difference.inHours;
                                          var timeDiffDays = difference.inDays;

                                          var timeDiff;

                                          if (timeDiffDays > 0) {
                                            if (timeDiffHours == 1) {
                                              timeDiff =
                                                  timeDiffDays.toString() +
                                                      " dzień temu";
                                            } else {
                                              timeDiff =
                                                  timeDiffDays.toString() +
                                                      " dni temu";
                                            }
                                          } else if (timeDiffHours > 0) {
                                            if (timeDiffHours == 1) {
                                              timeDiff = "Godzinę temu";
                                            } else {
                                              timeDiff =
                                                  timeDiffHours.toString() +
                                                      " godzin temu";
                                            }
                                          } else if (timeDiffMinutes > 0) {
                                            if (timeDiffHours == 1) {
                                              timeDiff = "Minutę temu";
                                            } else {
                                              timeDiff =
                                                  timeDiffMinutes.toString() +
                                                      " minut temu";
                                            }
                                          } else if (timeDiffMinutes == 0) {
                                            timeDiff = "Teraz";
                                          }

                                          return timeDiff;
                                        }()))
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
            ],
          );
        }

        return Text("loading");
      },
    );
  }
}
