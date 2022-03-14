import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddComment {
  final String videoId;
  final String userId;
  final String comment;
  final String? username;
  final String avatarPath;

  AddComment(
      this.videoId, this.userId, this.username, this.avatarPath, this.comment);

  CollectionReference comments =
      FirebaseFirestore.instance.collection('comments');

  User? currentUser = FirebaseAuth.instance.currentUser;

  var createdAt = Timestamp.now();

  Future<void> addComm() {
    return comments.add({
      'videoId': videoId,
      'userId': userId,
      'username': currentUser!.displayName,
      'comment': comment,
      'createdAt': createdAt,
      'userAvatarPath': avatarPath
    }).then((value) => print("Comment added"));
  }
}
