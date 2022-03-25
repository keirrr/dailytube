import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VideoLikesButtonInfo extends StatefulWidget {
  final String? videoId;

  const VideoLikesButtonInfo({Key? key, this.videoId}) : super(key: key);

  @override
  _VideoLikesButtonInfoState createState() => _VideoLikesButtonInfoState();
}

class _VideoLikesButtonInfoState extends State<VideoLikesButtonInfo> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  bool isLiked = false;
  bool isDisliked = false;
  bool areLikesChecked = false;
  int videoLikes = -1;
  int videoDislikes = -1;

  @override
  void initState() {
    super.initState();

    // Get video likes
    FirebaseFirestore.instance
        .collection('videos')
        .doc(widget.videoId)
        .get()
        .then((value) {
      int likes = value.get('likes');
      setState(() {
        videoLikes = likes;
      });
    });

    // Get video dislikes
    FirebaseFirestore.instance
        .collection('videos')
        .doc(widget.videoId)
        .get()
        .then((value) {
      int dislikes = value.get('dislikes');
      setState(() {
        videoDislikes = dislikes;
      });
    });

    // Check if user like this video
    FirebaseFirestore.instance
        .collection('liked-videos')
        .doc(currentUser!.uid)
        .get()
        .then((value) {
      List likedVideos = value.get('likedVideosList');
      setState(() {
        if (likedVideos.contains(widget.videoId)) {
          isLiked = true;
        } else {
          isLiked = false;
        }
      });
    });

    // Check if user dislike this video
    FirebaseFirestore.instance
        .collection('disliked-videos')
        .doc(currentUser!.uid)
        .get()
        .then((value) {
      List dislikedVideos = value.get('dislikedVideosList');
      setState(() {
        if (dislikedVideos.contains(widget.videoId)) {
          isDisliked = true;
        } else {
          isDisliked = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(children: [
          IconButton(
              onPressed: () async {
                CollectionReference likedVideos =
                    FirebaseFirestore.instance.collection('liked-videos');

                CollectionReference videos =
                    FirebaseFirestore.instance.collection('videos');

                // Check if user like this video
                likedVideos.doc(currentUser!.uid).get().then((userLikedVideos) {
                  if (userLikedVideos.exists) {
                    List likedVideosList =
                        userLikedVideos.get('likedVideosList');

                    if (likedVideosList.contains(widget.videoId)) {
                      likedVideosList.remove(widget.videoId);

                      likedVideos
                          .doc(currentUser!.uid)
                          .update({'likedVideosList': likedVideosList}).then(
                              (value) => print("Like updated"));

                      videos.doc(widget.videoId).get().then((value) {
                        int likes = value.get('likes');
                        likes--;
                        print(likes);
                        videos.doc(widget.videoId).update({'likes': likes});
                      });

                      setState(() {
                        isLiked = false;
                        videoLikes--;
                      });
                    } else {
                      // If video is disliked
                      if (isDisliked) {
                        CollectionReference dislikedVideos = FirebaseFirestore
                            .instance
                            .collection('disliked-videos');
                        dislikedVideos
                            .doc(currentUser!.uid)
                            .get()
                            .then((userDislikedVideos) {
                          List dislikedVideosList =
                              userDislikedVideos.get('dislikedVideosList');
                          dislikedVideosList.remove(widget.videoId);

                          dislikedVideos.doc(currentUser!.uid).update({
                            'dislikedVideosList': dislikedVideosList
                          }).then((value) => print("Dislike updated"));

                          videos.doc(widget.videoId).get().then((value) {
                            int dislikes = value.get('dislikes');
                            dislikes--;
                            print(dislikes);
                            videos
                                .doc(widget.videoId)
                                .update({'dislikes': dislikes});
                          });

                          setState(() {
                            isDisliked = false;
                            videoDislikes--;
                          });
                        });
                      }
                      likedVideosList.add(widget.videoId);

                      likedVideos
                          .doc(currentUser!.uid)
                          .update({'likedVideosList': likedVideosList}).then(
                              (value) => print("Like updated"));

                      videos.doc(widget.videoId).get().then((value) {
                        int likes = value.get('likes');
                        likes++;
                        videos.doc(widget.videoId).update({'likes': likes});
                      });

                      setState(() {
                        isLiked = true;
                        videoLikes++;
                      });
                    }
                  } else {
                    List<String> likedVideosList = [];
                    likedVideosList.add(widget.videoId.toString());

                    likedVideos
                        .doc(currentUser!.uid)
                        .set({'likedVideosList': likedVideosList}).then(
                            (value) => print("Like added"));

                    videos.doc(widget.videoId).get().then((value) {
                      int likes = value.get('likes');
                      likes++;
                      videos.doc(widget.videoId).update({'likes': likes});
                    });

                    setState(() {
                      isLiked = true;
                      videoLikes++;
                    });
                  }
                });
              },
              splashRadius: 25,
              icon: isLiked
                  ? const Icon(Icons.thumb_up,
                      color: Color.fromARGB(255, 197, 200, 212), size: 32)
                  : const Icon(Icons.thumb_up,
                      color: Color.fromARGB(255, 122, 128, 132), size: 32)),
          Text(
            videoLikes.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ]),
        Column(children: [
          IconButton(
              onPressed: () async {
                CollectionReference dislikedVideos =
                    FirebaseFirestore.instance.collection('disliked-videos');

                CollectionReference videos =
                    FirebaseFirestore.instance.collection('videos');

                // Check if user dislike this video
                dislikedVideos
                    .doc(currentUser!.uid)
                    .get()
                    .then((userDislikedVideos) {
                  if (userDislikedVideos.exists) {
                    List dislikedVideosList =
                        userDislikedVideos.get('dislikedVideosList');

                    if (dislikedVideosList.contains(widget.videoId)) {
                      dislikedVideosList.remove(widget.videoId);

                      dislikedVideos.doc(currentUser!.uid).update({
                        'dislikedVideosList': dislikedVideosList
                      }).then((value) => print("Dislike updated"));

                      videos.doc(widget.videoId).get().then((value) {
                        int dislikes = value.get('dislikes');
                        dislikes--;
                        print(dislikes);
                        videos
                            .doc(widget.videoId)
                            .update({'dislikes': dislikes});
                      });

                      setState(() {
                        isDisliked = false;
                        videoDislikes--;
                      });
                    } else {
                      // If video is disliked
                      if (isLiked) {
                        CollectionReference likedVideos = FirebaseFirestore
                            .instance
                            .collection('liked-videos');
                        likedVideos
                            .doc(currentUser!.uid)
                            .get()
                            .then((userLikedVideos) {
                          List likedVideosList =
                              userLikedVideos.get('likedVideosList');
                          likedVideosList.remove(widget.videoId);

                          likedVideos.doc(currentUser!.uid).update({
                            'likedVideosList': likedVideosList
                          }).then((value) => print("Like updated"));

                          videos.doc(widget.videoId).get().then((value) {
                            int likes = value.get('likes');
                            likes--;
                            print(likes);
                            videos.doc(widget.videoId).update({'likes': likes});
                          });

                          setState(() {
                            isLiked = false;
                            videoLikes--;
                          });
                        });
                      }

                      dislikedVideosList.add(widget.videoId);

                      dislikedVideos.doc(currentUser!.uid).update({
                        'dislikedVideosList': dislikedVideosList
                      }).then((value) => print("Disike updated"));

                      videos.doc(widget.videoId).get().then((value) {
                        int dislikes = value.get('dislikes');
                        dislikes++;
                        videos
                            .doc(widget.videoId)
                            .update({'dislikes': dislikes});
                      });

                      setState(() {
                        isDisliked = true;
                        videoDislikes++;
                      });
                    }
                  } else {
                    List<String> dislikedVideosList = [];
                    dislikedVideosList.add(widget.videoId.toString());

                    dislikedVideos
                        .doc(currentUser!.uid)
                        .set({'dislikedVideosList': dislikedVideosList}).then(
                            (value) => print("Dislike added"));

                    videos.doc(widget.videoId).get().then((value) {
                      int dislikes = value.get('dislikes');
                      dislikes++;
                      videos.doc(widget.videoId).update({'dislikes': dislikes});
                    });

                    setState(() {
                      isDisliked = true;
                      videoDislikes++;
                    });
                  }
                });
              },
              splashRadius: 25,
              icon: isDisliked
                  ? const Icon(Icons.thumb_down,
                      color: Color.fromARGB(255, 197, 200, 212), size: 32)
                  : const Icon(Icons.thumb_down,
                      color: Color.fromARGB(255, 122, 128, 132), size: 32)),
          Text(
            videoDislikes.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ])
      ],
    );
  }
}
