import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

import 'package:better_player/better_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../flutterfire/get_video.dart';

class Video extends StatefulWidget {
  final String? videoPath;
  const Video({Key? key, this.videoPath}) : super(key: key);

  @override
  _VideoState createState() => _VideoState();
}

class _VideoState extends State<Video> {
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
                  children: [
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
              Column(
                children: [
                  GetVideo(videoPath: widget.videoPath),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Title",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Dodano 10.02.2022",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.thumb_up,
                                  color: BartekColorPalette.bartekGrey[50],
                                  size: 32,
                                ),
                                Text("103")
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.thumb_down,
                                  color: BartekColorPalette.bartekGrey[50],
                                  size: 32,
                                ),
                                Text("34")
                              ],
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.share,
                                  color: BartekColorPalette.bartekGrey[50],
                                  size: 32,
                                ),
                                Text("")
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FontAwesomeIcons.userCircle,
                              color: BartekColorPalette.bartekGrey[50],
                              size: 32,
                            ),
                            Text("username"),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "Komentarze 5",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 40,
                      right: 15,
                      bottom: 55,
                      left: 15,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200.0),
                              borderSide: BorderSide(
                                width: 0,
                              ),
                            ),
                            filled: true,
                            fillColor: BartekColorPalette.bartekGrey[100],
                            hintText: "Napisz komentarz",
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.userCircle,
                                  color: BartekColorPalette.bartekGrey[50],
                                  size: 32,
                                ),
                                Column(
                                  children: [
                                    Text("username"),
                                    Text("8 godzin temu"),
                                    Text("Komentarz komentarz")
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
