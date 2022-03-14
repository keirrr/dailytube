import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';

class CommentItem extends StatefulWidget {
  final String? username;
  final String? time;
  final String? comment;
  final String? userAvatarPath;

  const CommentItem(
      {Key? key, this.username, this.time, this.comment, this.userAvatarPath})
      : super(key: key);

  @override
  _CommentItemState createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: FirebaseStorage.instance
                .ref(widget.userAvatarPath)
                .getDownloadURL(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  width: 32,
                  height: 32,
                  child: Image.network(
                    snapshot.data.toString(),
                  ),
                );
              }
              return Icon(
                FontAwesomeIcons.userCircle,
                color: BartekColorPalette.bartekGrey[50],
                size: 32,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.username.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(widget.time.toString()),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Expanded(
                      child: Text(
                        widget.comment.toString(),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
