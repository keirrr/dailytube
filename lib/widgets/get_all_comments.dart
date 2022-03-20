import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'comment_item.dart';

class GetAllComments extends StatelessWidget {
  final String? videoId;
  const GetAllComments({
    Key? key,
    this.videoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('comments')
          .where('videoId', isEqualTo: videoId)
          .orderBy('createdAt', descending: true)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: snapshot.data!.docs.length,
              physics: AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var username =
                    snapshot.data!.docs[index]['username'].toString();

                var time = snapshot.data!.docs[index]['createdAt'].toDate();
                var comment = snapshot.data!.docs[index]['comment'];

                var userAvatarPath =
                    snapshot.data!.docs[index]['userAvatarPath'];

                var timeNow = new DateTime.now();
                var difference = timeNow.difference(time);

                var timeDiffMinutes = difference.inMinutes;
                var timeDiffHours = difference.inHours;
                var timeDiffDays = difference.inDays;

                var timeDiff;

                if (timeDiffDays > 0) {
                  if (timeDiffHours == 1) {
                    timeDiff = timeDiffDays.toString() + " dzień temu";
                  } else {
                    timeDiff = timeDiffDays.toString() + " dni temu";
                  }
                } else if (timeDiffHours > 0) {
                  if (timeDiffHours == 1) {
                    timeDiff = "Godzinę temu";
                  } else {
                    timeDiff = timeDiffHours.toString() + " godzin temu";
                  }
                } else if (timeDiffMinutes > 0) {
                  if (timeDiffHours == 1) {
                    timeDiff = "Minutę temu";
                  } else {
                    timeDiff = timeDiffMinutes.toString() + " minut temu";
                  }
                } else if (timeDiffMinutes == 0) {
                  timeDiff = "Teraz";
                }

                return CommentItem(
                  username: username,
                  time: timeDiff,
                  comment: comment,
                  userAvatarPath: userAvatarPath,
                );
              },
            ),
          );
        }
        return Text("..");
      },
    );
  }
}
