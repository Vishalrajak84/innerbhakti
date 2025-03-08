import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:innerbhakti/model/songs_model.dart';

class ProgramDetails extends StatefulWidget {
  final SongUiModel song;
  const ProgramDetails({super.key, required this.song});

  @override
  State<ProgramDetails> createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends State<ProgramDetails> {
  @override
  Widget build(BuildContext context) {
    String base64Image = widget.song.songImg ?? '';
    if (base64Image.startsWith('data:image/jpeg;base64,')) {
      base64Image = base64Image.split(',')[1];
    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.memory(
              const Base64Decoder().convert(base64Image),
              fit: BoxFit.contain,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.song.about ?? '',
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
