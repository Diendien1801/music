import 'package:music_app/model/song.dart';
import 'package:music_app/source/source.dart';

abstract interface class Respisitory {
  Future<List<Song>?> getSong();
}

class DefaultRespisitory implements Respisitory {
  final RemoteDataSource dataSource;
  DefaultRespisitory(this.dataSource);
  @override
  Future<List<Song>?> getSong() async {
    List<Song> songs = [];
    await dataSource.getSources().then((value) {
      songs.addAll(value!);
    });
    return songs;
  }
}
