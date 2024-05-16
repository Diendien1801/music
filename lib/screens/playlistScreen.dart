// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/main.dart';

import 'package:music_app/model/song.dart';
import 'package:music_app/respisitory/respisitory.dart';
import 'package:music_app/source/source.dart';
import 'package:music_app/widget/artistWidget.dart';
import 'package:music_app/widget/bottom.dart';
import 'package:music_app/widget/musicTypeListView.dart';

class PlaylistScreen extends StatefulWidget {
  late List<Song> songs;
  PlaylistScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.songs = ManagerListSong.of(context)!.listSong;
    return Material(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Vip button
                      Container(
                        margin: const EdgeInsets.all(20),
                        height: 24,
                        width: 80,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.red,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Center(
                          child: Text(
                            'VIP member',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // Name screen
                      Container(
                        margin: EdgeInsets.only(left: 70),
                        child: const Text(
                          "Home",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                      // Cast to different device
                      ,
                      Container(
                        margin: const EdgeInsets.only(left: 70),
                        child: const Icon(
                          Icons.cast,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      //Upload music
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: const Icon(
                          Icons.cloud_upload,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                      // Activity
                      Container(
                        margin: const EdgeInsets.only(left: 16),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  // Artist
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(right: 180),
                          child: const Text(
                            "Artists You Should Follow",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          height: 190,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) =>
                                artistWidget(index),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Type of music
                  musicTypeListView('Trending Music', 10, widget.songs, 0),
                  musicTypeListView('New!', 10, widget.songs, 11),
                  musicTypeListView('Chill', 10, widget.songs, 21),
                  musicTypeListView('Party', 10, widget.songs, 31),
                  musicTypeListView('Workout', 10, widget.songs, 41),
                ],
              ),
            ),
          ),
          bottomNavigationBar: bottomNavigation(songs: widget.songs),
        ),
      ),
    );
  }
}
