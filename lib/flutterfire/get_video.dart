import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'storage_service.dart';
import 'package:better_player/better_player.dart';

class GetVideo extends StatelessWidget {
  final String? videoPath;
  const GetVideo({Key? key, @required this.videoPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    firebase_storage.FirebaseStorage videos =
        firebase_storage.FirebaseStorage.instance;

    return FutureBuilder(
        future: videos.ref(videoPath).getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data.toString());
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: BetterPlayer.network(
                snapshot.data.toString(),
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  aspectRatio: 16 / 9,
                ),
              ),
            );
          }

          return Text("...");
        });
  }
}
