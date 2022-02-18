import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentItem extends StatelessWidget {
  final String? username;
  final String? time;
  final String? comment;

  const CommentItem({Key? key, this.username, this.time, this.comment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.userCircle,
          color: BartekColorPalette.bartekGrey[50],
          size: 32,
        ),
        Column(
          children: [
            Text(username.toString()),
            Text(time.toString()),
            Text(comment.toString()),
          ],
        )
      ],
    );
  }
}
