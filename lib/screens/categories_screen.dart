import 'package:dailytube/widgets/display_all_videos.dart';
import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

class CategoriesScreen extends StatefulWidget {
  final String? categoryTitle;
  final String? category;

  const CategoriesScreen({Key? key, this.categoryTitle, this.category})
      : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: BartekColorPalette.bartekGrey[900],
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 40, right: 15, bottom: 55, left: 15),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      widget.categoryTitle.toString(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  DisplayAllVideos(
                    category: widget.category,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
