import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import '../bartek_color_palette.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../flutterfire/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home_video_thumb.dart';
import '../screens/video_player_screen.dart';

class DisplayAllVideos extends StatelessWidget {
  final Storage storage = new Storage();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference videos =
        FirebaseFirestore.instance.collection('videos');

    return FutureBuilder<QuerySnapshot>(
      future: videos.orderBy('timestamp').get(),
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
                                    print(snapshot.data);
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
                                                        .toString()),
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
