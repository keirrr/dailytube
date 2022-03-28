import 'package:flutter/material.dart';

import './home_screen.dart';
import './movies_screen.dart';
import 'upload_video_screen.dart';
import './categories_screen.dart';
import './profile_account.dart';
import './profile_login_screen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../bartek_color_palette.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;
  final _screens = [
    const HomeScreen(),
    //const MoviesScreen(),
    const UploadVideo(),
    //const CategoriesScreen(),
    const ProfileAccount(),
  ];

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              body: Stack(
                children: _screens
                    .asMap()
                    .map((i, screen) => MapEntry(
                          i,
                          Offstage(
                            offstage: _selectedIndex != i,
                            child: screen,
                          ),
                        ))
                    .values
                    .toList(),
              ),
              extendBody: true,
              backgroundColor: BartekColorPalette.bartekGrey[900],
              bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: BartekColorPalette.bartekGrey[400],
                  selectedItemColor: Theme.of(context).colorScheme.secondary,
                  unselectedItemColor: BartekColorPalette.bartekGrey[200],
                  currentIndex: _selectedIndex,
                  onTap: (i) => setState(() => _selectedIndex = i),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Główna',
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.movie),
                    //   label: 'Filmy',
                    // ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.upload),
                      label: 'Prześlij',
                    ),
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.space_dashboard),
                    //   label: 'Kategorie',
                    // ),
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.solidUser),
                      label: 'Profil',
                    )
                  ],
                ),
              ),
            );
          } else {
            return ProfileLogin();
          }
        },
      );
}
