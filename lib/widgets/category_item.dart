import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

class CategoryItem extends StatelessWidget {
  final String? title;

  const CategoryItem({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              color: BartekColorPalette.bartekGrey[100],
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          Text(title.toString())
        ],
      ),
    );
  }
}
