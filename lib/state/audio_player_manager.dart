import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class DurationState {
  final Duration progress;
  final Duration buffered;
  final Duration? total;

  DurationState({required this.progress, required this.buffered, this.total});
}

class AudioPlayerManager {
  AudioPlayerManager({required this.songURL});
  final player = AudioPlayer();
  Stream<DurationState>? durationState;
  String songURL;
  void init() {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent,DurationState>(
      player.positionStream,
      player.playbackEventStream,
      (position, playbackEvent) => DurationState(
        progress: position,
        buffered: playbackEvent.bufferedPosition,
        total: player.duration,
      ),
    );
    player.setUrl(songURL);
  }
}
