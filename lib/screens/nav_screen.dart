import 'package:flutter/material.dart';

import './home_screen.dart';
import './movies_screen.dart';
import './categories_screen.dart';
import './profile_login_screen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    const MoviesScreen(),
    const CategoriesScreen(),
    const ProfileLogin()
  ];

  @override
  Widget build(BuildContext context) {
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
              label: 'Strona główna',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.movie),
              label: 'Filmy',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.space_dashboard),
              label: 'Kategorie',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.solidUser),
              label: 'Profil',
            )
          ],
        ),
      ),
    );
  }
}
