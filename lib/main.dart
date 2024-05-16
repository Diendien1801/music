// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:music_app/model/song.dart';
import 'package:music_app/respisitory/respisitory.dart';
import 'package:music_app/screens/introScreen.dart';
import 'package:music_app/screens/loginScreen.dart';
import 'package:music_app/screens/playlistScreen.dart';
import 'package:music_app/screens/songScreen.dart';
import 'package:music_app/source/source.dart';

void main() async {
  final Respisitory respisitory = DefaultRespisitory(RemoteDataSource());
  List<Song> songs = await respisitory.getSong() ?? [];
  print(songs.length);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => IsPlay()),
        // Add more providers here
        ChangeNotifierProvider(create: (_) => IsFav()),
      ],
      child: ManagerListSong(child: MainApp(), listSong: songs),
    ),
  );
}

class IsFav extends ChangeNotifier {
  bool isFav = false;
  void changeFav() {
    isFav = !isFav;
    notifyListeners();
  }
}

class IsPlay extends ChangeNotifier {
  bool isPlay = false;
  void changePlay() {
    isPlay = !isPlay;
    notifyListeners();
  }

  setPlay() {
    isPlay = false;
    notifyListeners();
  }
}

class ManagerListSong extends InheritedWidget {
  final List<Song> listSong;
  List<String> listFavIndex = [];
  ManagerListSong({
    required Widget child,
    required this.listSong,
  }) : super(child: child);
  static ManagerListSong? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ManagerListSong>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class MainApp extends StatelessWidget {
  MainApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
    //PlaylistScreen(songs: songs);
  }
}
