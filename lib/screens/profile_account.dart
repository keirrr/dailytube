import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

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
                body: Container(
                  margin: const EdgeInsets.only(
                      top: 40, right: 15, bottom: 55, left: 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35),
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 3,
                                    ),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Image.network(
                                      'https://icon-library.com/images/avatar-icon-png/avatar-icon-png-8.jpg'),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: (currentUser != null)
                                      ? Text(
                                          currentUser!.uid,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        )
                                      : Text(
                                          "User not logged in",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        )),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  "Nullam tristique varius ipsum auctor scelerisque. Morbi hendrerit justo ipsum. Cras justo dolor, congue quis odio sed, volutpat euismod erat. Ut sed mi diam. Fusce at libero ornare, tristique nisl vitae, pharetra augue.",
                                  style: Theme.of(context).textTheme.bodyText2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 50),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseAuth.instance.signOut();
                                  },
                                  child: Text(
                                    "Wyloguj się",
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
