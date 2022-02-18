import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class GetCommentsCount extends StatelessWidget {
  const GetCommentsCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('comments')
          .where('videoId', isEqualTo: '2')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(
            "Komentarze " + snapshot.data!.docs.length.toString(),
            style: Theme.of(context).textTheme.headline6,
          );
        }
        return Text("..");
      },
    );
  }
}
