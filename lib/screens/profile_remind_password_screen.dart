import 'package:dailytube/screens/profile_remind_password_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

class ProfileRemindPassword extends StatefulWidget {
  const ProfileRemindPassword({Key? key}) : super(key: key);

  @override
  _ProfileRemindPasswordState createState() => _ProfileRemindPasswordState();
}

class _ProfileRemindPasswordState extends State<ProfileRemindPassword> {
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 80,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: Image(
            height: 48,
            image: AssetImage('assets/images/dailytube-logo.png'),
          ),
        ),
        extendBody: true,
        backgroundColor: BartekColorPalette.bartekGrey[900],
        body: Container(
          margin:
              const EdgeInsets.only(top: 40, right: 15, bottom: 55, left: 15),
          child: Column(
            children: [
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
                              "Przypomnij hasło",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: SizedBox(
                            width: 300,
                            height: 40,
                            child: TextFormField(
                              controller: email,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(200.0),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                                hintText: "Adres e-mail",
                                hintStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                resetPassword();
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileRemindPasswordInfo(),
                                  ),
                                );
                              },
                              child: Text(
                                "Przypomnij hasło",
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

  Future resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email.text.trim());
  }
}
