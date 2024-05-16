import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/screens/songScreen.dart';

Widget musicTypeListView(
    String title, int itemCount, List<Song> songs, int start) {
  return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
    //title
    Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10, left: 20),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    //type
    Container(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            width: 100,
            margin: const EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SongScreen(
                        
                          index: index+start,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: NetworkImage(songs[index + start].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(top: 10),
                  child: Text(
                    songs[index + start].title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 18),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ),
  ]);
}
