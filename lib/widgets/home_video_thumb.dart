import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../flutterfire/storage_service.dart';

class HomeVideoThumb extends StatefulWidget {
  final QuerySnapshot? documents;
  final int? index;

  const HomeVideoThumb({Key? key, this.documents, this.index})
      : super(key: key);

  @override
  _HomeVideoThumbState createState() => _HomeVideoThumbState();
}

class _HomeVideoThumbState extends State<HomeVideoThumb> {
  final QuerySnapshot? documents;
  final int? index;

  _HomeVideoThumbState({this.documents, this.index});

  final Storage storage = new Storage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.downloadUrl(documents!.docs[index!]['video_path']),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FractionallySizedBox(
            widthFactor: 1,
            child: InkWell(
              onTap: () => {},
              borderRadius: BorderRadius.circular(20),
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(20.0),
                child: Image.network(
                  documents.toString(),
                  height: 125,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }

        return Text("...");
      },
    );
  }
}
