import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bartek_color_palette.dart';

class ProfileRemindPasswordInfo extends StatefulWidget {
  const ProfileRemindPasswordInfo({Key? key}) : super(key: key);

  @override
  _ProfileRemindPasswordInfoState createState() =>
      _ProfileRemindPasswordInfoState();
}

class _ProfileRemindPasswordInfoState extends State<ProfileRemindPasswordInfo> {
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
                              "Link został wysłany",
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                        ),
                        Text(
                            "Link umożliwiający zmianę hasła został wysłany na podany adres email.")
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
