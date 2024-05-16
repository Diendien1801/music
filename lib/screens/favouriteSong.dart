import 'package:flutter/material.dart';
import 'package:music_app/main.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/screens/songScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteSong extends StatefulWidget {
  FavouriteSong({
    Key? key,
  }) : super(key: key);
  @override
  _FavouriteSongState createState() => _FavouriteSongState();
}

class _FavouriteSongState extends State<FavouriteSong> {
  late List<Song> songs;
  Future<void> _getFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ManagerListSong.of(context)?.listFavIndex =
        prefs.getStringList('listFav1')?.map((e) => e.toString()).toList() ??
            [];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFav(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Show loading spinner while waiting
        } else if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); // Show error if something went wrong
        } else {
          songs = ManagerListSong.of(context)!
              .listFavIndex
              .map((e) => ManagerListSong.of(context)!.listSong[int.parse(e)])
              .toList();
          return Material(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 50, left: 20, bottom: 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                            const Text(
                              'Favourite Song',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: songs.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                songs[index].title!,
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SongScreen(
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
