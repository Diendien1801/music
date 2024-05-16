import 'dart:convert';

import 'package:music_app/model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
  Future<List<Song>?> getSources();
}

class RemoteDataSource extends DataSource {
  @override
  Future<List<Song>?> getSources() async {
    final response = await http.get(
        Uri.parse('https://thantrieu.com/resources/braniumapis/songs.json'));
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(bodyContent) as Map;
      var songList = jsonData['songs'];
      List<Song> songs =
          songList.map((song) => Song.fromJson(song)).toList().cast<Song>();
      print(songs.length);
      return songs;
    } else {
      return null;
    }
  }
}
