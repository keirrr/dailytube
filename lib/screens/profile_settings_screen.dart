import 'package:dailytube/bartek_color_palette.dart';
import 'package:dailytube/flutterfire/update_user_desc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final desc = TextEditingController();
    final username = TextEditingController();
    final _keyForm = GlobalKey<FormState>();

    var currentUser = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: BartekColorPalette.bartekGrey[900],
        body: Container(
          margin:
              const EdgeInsets.only(top: 40, right: 15, bottom: 55, left: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Edytuj profil",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      UpdateUserDesc(userId: currentUser!.uid, desc: desc.text)
                          .updateUser(context);
                    },
                    icon: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  child: Form(
                    key: _keyForm,
                    child: Flexible(
                      child: FractionallySizedBox(
                          widthFactor: 0.9,
                          child: FutureBuilder(
                            future: users.doc(currentUser!.uid).get(),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasData) {
                                username.text = snapshot.data!.get('username');
                                desc.text = snapshot.data!.get('description');
                                return Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Nazwa użytkownika",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline6,
                                              ),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: username,
                                            enabled: false,
                                            style: TextStyle(
                                                color: Colors.white70),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.all(10.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.0),
                                                borderSide: BorderSide(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                  width: 2.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        200.0),
                                                borderSide: BorderSide(
                                                  width: 0,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: BartekColorPalette
                                                  .bartekGrey[100],
                                              hintStyle: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Opis",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline6,
                                            ),
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            TextFormField(
                                              controller: desc,
                                              maxLines: null,
                                              maxLength: 150,
                                              style: TextStyle(
                                                  color: Colors.white),
                                              decoration: InputDecoration(
                                                isDense: true,
                                                contentPadding:
                                                    EdgeInsets.all(10.0),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: BorderSide(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .secondary,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  borderSide: BorderSide(
                                                    width: 0,
                                                  ),
                                                ),
                                                filled: true,
                                                fillColor: BartekColorPalette
                                                    .bartekGrey[100],
                                                hintStyle: TextStyle(
                                                    color: Colors.white70),
                                                counterStyle: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 50),
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          await FirebaseAuth.instance.signOut();
                                        },
                                        child: Text(
                                          "Wyloguj się",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
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
                                );
                              }
                              return Text("...");
                            },
                          )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
