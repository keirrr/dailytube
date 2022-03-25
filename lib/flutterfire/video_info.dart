import 'package:cloud_firestore/cloud_firestore.dart';

class VideoInfo {
  final String? videoId;

  VideoInfo(this.videoId);

  Future getLikes() async {
    FirebaseFirestore.instance
        .collection('videos')
        .doc(videoId)
        .get()
        .then((value) {
      int likes = value.get('likes');
      return likes;
    });
  }
}
