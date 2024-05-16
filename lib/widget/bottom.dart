// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:music_app/model/song.dart';
import 'package:music_app/screens/songScreen.dart';
import 'package:music_app/widget/searchSong.dart';
import 'package:music_app/screens/favouriteSong.dart';

class bottomNavigation extends StatelessWidget {
  List<Song> songs;
  bottomNavigation({
    Key? key,
    required this.songs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BottomNavigationBar(
          backgroundColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white,
          onTap: (index) {
            if (index == 1) {
              print('ok');
              showSearch(context: context, delegate: searchSong(songs: songs));
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavouriteSong(),
                ),
              );
            }
          },
        ),
        Container(
          height: 0.5,
          width: double.infinity,
          color: Colors.white,
        ),
      ],
    );
  }
}
