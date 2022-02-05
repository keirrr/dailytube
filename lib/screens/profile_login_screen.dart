import 'package:flutter/material.dart';

import './profile_remind_password_screen.dart';
import './profile_register_screen.dart';
import './profile_account.dart';

import '../bartek_color_palette.dart';

class ProfileLogin extends StatefulWidget {
  const ProfileLogin({Key? key}) : super(key: key);

  @override
  _ProfileLoginState createState() => _ProfileLoginState();
}

class _ProfileLoginState extends State<ProfileLogin> {
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
                              "Logowanie",
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
                                    hintText: "Nazwa użytkownika lub e-mail",
                                    hintStyle: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: SizedBox(
                            height: 40,
                            child: FractionallySizedBox(
                              widthFactor: 0.9,
                              child: TextFormField(
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                  hintText: "Hasło",
                                  hintStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: FractionallySizedBox(
                            widthFactor: 0.9,
                            heightFactor: 0.3,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 35,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileRemindPassword(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    splashFactory: NoSplash.splashFactory,
                                  ),
                                  child: Text(
                                    "Przypomnij hasło",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ProfileAccount(),
                                  ),
                                )
                              },
                              child: Text(
                                "Zaloguj się",
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
                        Column(
                          children: [
                            const Text(
                              "Nie masz konta?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 30,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ProfileRegister(),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                child: Text(
                                  "Załóż konto",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
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
