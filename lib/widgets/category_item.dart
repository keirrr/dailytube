import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';
import 'package:bartek_hub/screens/categories_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryItem extends StatelessWidget {
  final String? title;
  final String? category;
  final String? thumbPath;

  const CategoryItem({Key? key, this.title, this.category, this.thumbPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(thumbPath);

    return FutureBuilder(
        future: FirebaseStorage.instance.ref(thumbPath).getDownloadURL(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return InkWell(
              child: SizedBox(
                height: 100,
                width: 150,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      clipBehavior: Clip.hardEdge,
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        snapshot.data!.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      title.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoriesScreen(
                      categoryTitle: title,
                      category: category,
                    ),
                  ),
                );
              },
            );
          }
          return Text("...");
        });
  }
}
