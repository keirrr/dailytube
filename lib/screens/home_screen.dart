import 'package:flutter/material.dart';

import 'package:flag/flag.dart';
import '../bartek_color_palette.dart';

import '../widgets/display_all_videos.dart';
import '../widgets/category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _categoriesList = [
    ["Muzyka", "music", "categories_thumbnails/music.jpeg"],
    ["Na żywo", "live", "categories_thumbnails/live.jpg"],
    ["Gry", "games", "categories_thumbnails/games.jpg"],
    ["Wiadomości", "news", "categories_thumbnails/news.jpg"],
    ["Sport", "sport", "categories_thumbnails/sport.jpg"]
  ];

  List a = List.filled(3, List.filled(3, 0));

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
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        height: 32,
                        image: AssetImage('assets/images/bartekhub-logo.png'),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        "Popularne kategorie",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < _categoriesList.length; i++)
                            i == 0
                                ? CategoryItem(
                                    title: _categoriesList[i][0],
                                    category: _categoriesList[i][1],
                                    thumbPath: _categoriesList[i][2],
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: CategoryItem(
                                      title: _categoriesList[i][0],
                                      category: _categoriesList[i][1],
                                      thumbPath: _categoriesList[i][2],
                                    ),
                                  )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          "Na czasie 🔥",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
                  DisplayAllVideos(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
