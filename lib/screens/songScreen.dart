// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math';
import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/widget/bottom.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:music_app/main.dart';
import 'package:music_app/model/song.dart';
import 'package:music_app/state/audio_player_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SongScreen extends StatefulWidget {
  int index;
  SongScreen({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  _SongScreenState createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> with TickerProviderStateMixin {
  late AudioPlayerManager _audioPlayerManager;
  late ValueNotifier<bool> isLoop = ValueNotifier<bool>(false);
  late AnimationController _controller;
  late ValueNotifier<bool> _isFav;

  late List<Song> songs;
  List<int> favSongsIndex = [];
  @override
  void initState() {
    super.initState();

    _isFav = ValueNotifier<bool>(false);
    _controller = AnimationController(
      duration:
          const Duration(seconds: 10), // Thời gian cho một vòng quay đầy đủ
      vsync: this,
    )..stop();
  }

  Future<void> _getFav() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    ManagerListSong.of(context)?.listFavIndex =
        prefs.getStringList('listFav1')?.map((e) => e.toString()).toList() ??
            [];
  }

  Future<void> _saveFav(List<String> s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('listFav1', s.map((e) => e.toString()).toList()) ?? [];
  }

  void setFav(List<int> favSongsIndex) {
    for (var index in favSongsIndex) {
      songs[index].isFav = true;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    songs = ManagerListSong.of(context)!.listSong;
    _audioPlayerManager =
        AudioPlayerManager(songURL: songs[widget.index].source);
    _audioPlayerManager.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayerManager.player.dispose();
    super.dispose();
  }

  double volume = 0.0;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFav(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          favSongsIndex = ManagerListSong.of(context)!
              .listFavIndex
              .map((e) => int.parse(e))
              .toList();
          setFav(favSongsIndex);
          _isFav.value = songs[widget.index].isFav;
          return Material(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(songs[widget.index].image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //header
                            Container(
                              width: 400,
                              height: 30,
                              margin: EdgeInsets.only(top: 40, left: 30),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.read<IsPlay>().setPlay();
                                      _audioPlayerManager.player.stop();

                                      Navigator.pop(context);
                                    },
                                    child: Positioned(
                                      child: Transform.rotate(
                                        angle: 540 * 3.14 / 360,
                                        child: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  //name
                                  Positioned(
                                    left: 90,
                                    child: Text(
                                      songs[widget.index].title,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // CD
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Stack(
                                children: [
                                  AnimatedBuilder(
                                    animation: _controller!,
                                    child: Container(
                                      height: 400,
                                      width: 400,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.white,
                                            blurRadius: 10.0,
                                            spreadRadius: 2.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                        border: const Border.fromBorderSide(
                                            BorderSide(
                                                color: Colors.white,
                                                width: 1.5)),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              songs[widget.index].image),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(200)),
                                      ),
                                    ),
                                    builder:
                                        (BuildContext context, Widget? child) {
                                      return Transform.rotate(
                                        angle: (_controller?.value ?? 0.0) *
                                            2.0 *
                                            pi,
                                        child: child!,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // Artist
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                songs[widget.index].artist,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            // time start time end
                            _progressBar(),
                            // play button
                            Container(
                              margin: EdgeInsets.only(top: 18),
                              height: 100,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 24, right: 20),
                                    child: const Icon(
                                      Icons.heart_broken_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Container(
                                    child: MyButton(
                                        icon: Icons.skip_previous,
                                        size: 40,
                                        color: Colors.white,
                                        function: () {
                                          setState(() {
                                            widget.index--;
                                            if (widget.index < 0) {
                                              widget.index = songs.length - 1;
                                            }
                                            _audioPlayerManager.player.stop();
                                            _audioPlayerManager =
                                                AudioPlayerManager(
                                                    songURL: songs[widget.index]
                                                        .source);
                                            _audioPlayerManager.init();
                                          });
                                        }).myButton(),
                                  ),

                                  _playButton(),
                                  Container(
                                    child: MyButton(
                                        icon: Icons.skip_next,
                                        size: 40,
                                        color: Colors.white,
                                        function: () {
                                          setState(() {
                                            widget.index++;
                                            if (widget.index == songs.length) {
                                              widget.index = 0;
                                            }
                                            _audioPlayerManager.player.stop();
                                            _audioPlayerManager =
                                                AudioPlayerManager(
                                                    songURL: songs[widget.index]
                                                        .source);
                                            _audioPlayerManager.init();
                                          });
                                        }).myButton(),
                                  ),
                                  // Consumer<IsFav>(
                                  //   builder: (context, isFav, child) {
                                  //     return IconButton(
                                  //       icon: isFav.isFav
                                  //           ? const Icon(
                                  //               Icons.favorite,
                                  //               color: Colors.red,
                                  //               size: 20,
                                  //             )
                                  //           : const Icon(
                                  //               Icons.favorite_border,
                                  //               color: Colors.white,
                                  //               size: 20,
                                  //             ),
                                  //       onPressed: () {
                                  //         isFav.changeFav();
                                  //         songs[widget.index].isFav = isFav.isFav;
                                  //         if (isFav.isFav == true) {
                                  //           ManagerListSong.of(context)!
                                  //               .listFavIndex
                                  //               .add(widget.index.toString());
                                  //           _saveFav(ManagerListSong.of(context)!
                                  //               .listFavIndex);
                                  //         } else {
                                  //           ManagerListSong.of(context)!
                                  //               .listFavIndex
                                  //               .remove(widget.index.toString());
                                  //           _saveFav(ManagerListSong.of(context)!
                                  //               .listFavIndex);
                                  //         }
                                  //       },
                                  //     );
                                  //   },
                                  // ),
                                  ValueListenableBuilder<bool>(
                                    valueListenable: _isFav,
                                    builder: (context, isFav, _) => InkWell(
                                      onTap: () {
                                        _isFav.value = !_isFav.value;
                                        songs[widget.index].isFav =
                                            _isFav.value;
                                        if (_isFav.value == true) {
                                          ManagerListSong.of(context)!
                                              .listFavIndex
                                              .add(widget.index.toString());
                                          _saveFav(ManagerListSong.of(context)!
                                              .listFavIndex);
                                        } else {
                                          ManagerListSong.of(context)!
                                              .listFavIndex
                                              .remove(widget.index.toString());
                                          _saveFav(ManagerListSong.of(context)!
                                              .listFavIndex);
                                        }
                                      },
                                      child: Container(
                                          margin:
                                              const EdgeInsets.only(left: 20),
                                          child: isFav == false
                                              ? const Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.white,
                                                  size: 20,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 20,
                                                )),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //more option
                            Row(
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: isLoop,
                                  builder: (BuildContext context, bool value,
                                      Widget? child) {
                                    return InkWell(
                                      onTap: () {
                                        isLoop.value = !isLoop.value;
                                        if (isLoop.value == true) {
                                          print("loop");
                                          _audioPlayerManager.player
                                              .setLoopMode(LoopMode.one);
                                        } else {
                                          print("noloop");
                                          _audioPlayerManager.player
                                              .setLoopMode(LoopMode.off);
                                        }
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 30),
                                        height: 20,
                                        width: 20,
                                        child: Image(
                                          image: const AssetImage(
                                              "assets/img/repeat.png"),
                                          color: isLoop.value == false
                                              ? Colors.white
                                              : Colors.red,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                InkWell(
                                  onTap: () {
                                    _audioPlayerManager.player
                                        .seek(Duration(seconds: 224));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20, left: 310),
                                    height: 22,
                                    width: 22,
                                    child: const Image(
                                      image:
                                          AssetImage("assets/img/random.png"),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //lyric
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                bottomNavigationBar: bottomNavigation(songs: songs),
              ),
            ),
          );
        }
      },
    );
  }

// play button State
  StreamBuilder<PlayerState> _playButton() {
    return StreamBuilder(
      stream: _audioPlayerManager.player.playerStateStream,
      builder: (context, snapshot) {
        final playerState = snapshot.data;
        final processingState = playerState?.processingState;
        final playing = playerState?.playing;
        bool isPlay = context.watch<IsPlay>().isPlay;
        print('isPlay $isPlay');
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          return Container(
            margin: EdgeInsets.only(left: 14, right: 16),
            child: const CircularProgressIndicator(),
          );
        } else if (playing == false) {
          return MyButton(
              icon: isPlay == false
                  ? Icons.play_circle_fill
                  : Icons.pause_circle_filled,
              size: 70,
              color: Colors.white,
              function: () {
                _audioPlayerManager.player.play();
                context.read<IsPlay>().changePlay();
                isPlay = context
                    .read<IsPlay>()
                    .isPlay; // Update isPlay with the new value from Provider
                print('1 ${isPlay}');
                if (isPlay == true) {
                  _controller.repeat();
                } else {
                  _controller.stop();
                }
              }).myButton();
        } else if (processingState == ProcessingState.completed) {
          isPlay = false;
          _controller.stop();
          return MyButton(
              icon: isPlay == false
                  ? Icons.play_circle_fill
                  : Icons.pause_circle_filled,
              size: 70,
              color: Colors.white,
              function: () {
                _audioPlayerManager.player.seek(Duration.zero);

                isPlay = true;
                if (isPlay == true) {
                  _controller.repeat();
                } else {
                  _controller.stop();
                }
                print('2 ${isPlay}');
              }).myButton();
        } else if (processingState != ProcessingState.completed) {
          return MyButton(
              icon: isPlay == false
                  ? Icons.play_circle_fill
                  : Icons.pause_circle_filled,
              size: 70,
              color: Colors.white,
              function: () {
                _audioPlayerManager.player.pause();
                context.read<IsPlay>().changePlay();
                isPlay = context
                    .read<IsPlay>()
                    .isPlay; // Update isPlay with the new value from Provider
                print('3 ${isPlay}');
                if (isPlay == true) {
                  _controller.repeat();
                } else {
                  _controller.stop();
                }
              }).myButton();
        } else {
          return MyButton(
              icon: isPlay == false
                  ? Icons.play_circle_fill
                  : Icons.pause_circle_filled,
              size: 70,
              color: Colors.white,
              function: () {
                _audioPlayerManager.player.seek(Duration.zero);
                context.read<IsPlay>().changePlay();
                isPlay = context.read<IsPlay>().isPlay;
                if (isPlay == false) {
                  _controller.repeat();
                } else {
                  _controller.stop();
                }
                print('4 ${isPlay}');
              }).myButton();
        }
      },
    );
  }

  // progress Bar
  StreamBuilder<DurationState> _progressBar() {
    return StreamBuilder(
      stream: _audioPlayerManager.durationState,
      builder: ((context, snapshot) {
        final durationState = snapshot.data;
        final progress = durationState?.progress ?? Duration.zero;
        final buffered = durationState?.buffered ?? Duration.zero;
        final total = durationState?.total ?? Duration.zero;

        return Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  '${((progress.inSeconds) / 60).toInt()}:${((progress.inSeconds) % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SliderTheme(
                data: const SliderThemeData(
                  trackHeight: 1, activeTrackColor: Colors.white,
                  disabledActiveTrackColor: Colors.white,
                  thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 0.0), // This hides the thumb
                  // ...
                ),
                child: SizedBox(
                  width: 300,
                  child: Slider(
                      value: progress.inSeconds.toDouble(),
                      min: 0,
                      max: total.inSeconds.toDouble(),
                      onChanged: (value) {
                        if (value != total.inSeconds.toDouble()) {
                          _audioPlayerManager.player
                              .seek(Duration(seconds: value.toInt()));
                        }
                      }),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text(
                  '${((total.inSeconds) / 60).toInt()}:${((total.inSeconds) % 60).toString().padLeft(2, '0')}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class MyButton {
  final IconData icon;
  final double size;
  final Color color;
  final Function function;
  MyButton({
    required this.icon,
    required this.size,
    required this.color,
    required this.function,
  });

  Widget myButton() {
    return Container(
      margin: EdgeInsets.only(left: 14, right: 16),
      child: IconButton(
        icon: Icon(
          this.icon,
          color: this.color,
          size: this.size,
        ),
        onPressed: () => this.function(),
      ),
    );
  }
}
