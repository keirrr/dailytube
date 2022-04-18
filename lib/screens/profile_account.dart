import 'package:dailytube/screens/profile_settings_screen.dart';
import 'package:dailytube/widgets/display_all_videos.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../bartek_color_palette.dart';
import './profile_login_screen.dart';

class ProfileAccount extends StatefulWidget {
  const ProfileAccount({Key? key}) : super(key: key);

  @override
  _ProfileAccountState createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Scaffold(
                extendBody: true,
                backgroundColor: BartekColorPalette.bartekGrey[900],
                body: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 40, right: 15, bottom: 55, left: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                "Profil",
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileSettingsScreen()),
                                );
                              },
                              icon: Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('uid',
                                            isEqualTo: currentUser!.uid)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot>
                                            userSnapshot) {
                                      if (userSnapshot.hasData) {
                                        final storageRef =
                                            FirebaseStorage.instance.ref();
                                        final avatarPath = userSnapshot
                                            .data!.docs[0]
                                            .get('avatarPath');

                                        StreamBuilder(
                                          stream: storageRef
                                              .child(avatarPath)
                                              .getDownloadURL()
                                              .asStream(),
                                          builder: (context, urlSnapshot) {
                                            print('xd');
                                            // return SizedBox(
                                            //   width: 128,
                                            //   height: 128,
                                            //   child: Container(
                                            //     decoration: BoxDecoration(
                                            //       border: Border.all(
                                            //         width: 3,
                                            //       ),
                                            //       borderRadius:
                                            //           BorderRadius.circular(
                                            //               100),
                                            //     ),
                                            //     child: Image.network(
                                            //         snapshot.data.toString()),
                                            //   ),
                                            // );
                                            return Text('XD');
                                          },
                                        );
                                      }

                                      return Text('XD');
                                    }),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: GetUserName(),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .where('uid',
                                            isEqualTo: currentUser!.uid)
                                        .snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasData) {
                                        String desc = snapshot.data!.docs[0]
                                            .get('description');
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: Text(
                                            desc,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2,
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      }

                                      return Text("description");
                                    })
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Filmów",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "34",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 2,
                                color: BartekColorPalette.bartekGrey[500],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wyświetleń",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "32.2k",
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Container(
                                height: 50,
                                width: 2,
                                color: BartekColorPalette.bartekGrey[500],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Śledzacych",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    "5.6k",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 5, top: 20),
                              child: Text(
                                "Twoje filmy",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            DisplayAllVideos(
                              videoAuthorId: currentUser!.uid,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const ProfileLogin();
          }
        },
      );
}

class GetUserName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    var username = currentUser!.displayName;

    return Text(
      username.toString(),
      style: Theme.of(context).textTheme.headline6,
    );
  }
}

// pobierz uzytkownika > wez avatarpth > wez downloadurl > generuj widget

getAvatarUrl(AsyncSnapshot<QuerySnapshot> snapshot) {
  final storageRef = FirebaseStorage.instance.ref();
  final avatarPath = snapshot.data!.docs[0].get('avatarPath');

  storageRef.child(avatarPath).getDownloadURL().then((value) {
    return value;
  });
}
