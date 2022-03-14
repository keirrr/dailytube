import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserInfo {
  final String? userId;

  GetUserInfo(this.userId);

  getUserInfo() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return documentSnapshot.get('username').toString();
      } else {
        print('Document does not exist on the database');
      }
    });
  }
}
