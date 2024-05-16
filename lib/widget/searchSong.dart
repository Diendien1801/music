import 'package:flutter/material.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/screens/songScreen.dart';
class searchSong extends SearchDelegate {
  List<Song> songs;
  searchSong({
    required this.songs,
  });
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Song> suggestionList = [];
    for (var song in songs) {
      if (song.title!.toLowerCase().contains(query.toLowerCase())) {
        suggestionList.add(song);
      }
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].title!),
          onTap: () {
            print('ok');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongScreen( index: index),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<Song> suggestionList = [];
    for (var song in songs) {
      if (song.title!.toLowerCase().contains(query.toLowerCase())) {
        suggestionList.add(song);
      }
    }
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestionList[index].title!),
          onTap: () {},
        );
      },
    );
  }
}
