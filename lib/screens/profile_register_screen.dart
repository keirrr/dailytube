import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';
import '../flutterfire/add_user.dart';

class ProfileRegister extends StatefulWidget {
  const ProfileRegister({Key? key}) : super(key: key);

  @override
  _ProfileRegisterState createState() => _ProfileRegisterState();
}

class _ProfileRegisterState extends State<ProfileRegister> {
  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Rejestracja",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 40,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        BartekColorPalette.bartekGrey[100],
                                    hintText: "Nazwa użytkownika",
                                    hintStyle: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 40,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        BartekColorPalette.bartekGrey[100],
                                    hintText: "Hasło",
                                    hintStyle: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              height: 40,
                              child: FractionallySizedBox(
                                widthFactor: 0.9,
                                child: TextFormField(
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10.0),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                      borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        width: 2.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(200.0),
                                      borderSide: BorderSide(
                                        width: 0,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        BartekColorPalette.bartekGrey[100],
                                    hintText: "Powtórz hasło",
                                    hintStyle: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () => {
                                AddUser("Johny", "Spalony").addUser(),
                              },
                              child: Text(
                                "Załóż konto",
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Theme.of(context).colorScheme.secondary),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
