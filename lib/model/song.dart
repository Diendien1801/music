import 'package:flutter/foundation.dart';

class Song {
  String id;
  String title;
  String album;
  String artist;
  String source;
  String image;
  int duration;
  bool isFav;
  Song({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.source,
    required this.image,
    required this.duration,
    this.isFav = false,
  });
  set setFav(bool value) {
    isFav = value;
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      album: json['album'],
      artist: json['artist'],
      source: json['source'],
      image: json['image'],
      duration: json['duration'],
    );
  }
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Song && runtimeType == other.runtimeType && id == other.id;
  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
