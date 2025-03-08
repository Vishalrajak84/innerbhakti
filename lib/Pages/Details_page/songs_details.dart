import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:innerbhakti/Pages/Details_page/services.dart';
import 'package:innerbhakti/model/songs_model.dart';

class SongsDetails extends StatefulWidget {
  final SongUiModel song;
  const SongsDetails({Key? key, required this.song}) : super(key: key);

  @override
  State<SongsDetails> createState() => _SongsDetailsState();
}

class _SongsDetailsState extends State<SongsDetails> {
  late bool playPause = true;
  final PageStorageKey _pageStorageKey = const PageStorageKey('song_details');

  @override
  void initState() {
    super.initState();
    // Load the persisted state, or default to true
    playPause = PageStorage.of(context)
            .readState(context, identifier: _pageStorageKey) as bool? ??
        true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    playPause = PageStorage.of(context)
            .readState(context, identifier: _pageStorageKey) as bool? ??
        true;
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayerService _audioplayservices = AudioPlayerService();

    String base64Image = widget.song.songImg ?? '';
    if (base64Image.startsWith('data:image/jpeg;base64,')) {
      base64Image = base64Image.split(',')[1];
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.memory(
            const Base64Decoder().convert(base64Image),
            fit: BoxFit.fitHeight,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                widget.song.songName ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous,
                          size: 50, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(playPause ? Icons.play_arrow : Icons.pause,
                          size: 50, color: Colors.white),
                      onPressed: () async {
                        setState(() {
                          playPause = !playPause;
                        });

                        if (!playPause) {
                          await _audioplayservices.playSong(widget.song);
                        } else {
                          await _audioplayservices.pauseSong();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next,
                          size: 50, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
