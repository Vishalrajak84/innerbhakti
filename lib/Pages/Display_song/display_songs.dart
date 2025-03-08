import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as getx;
import 'package:innerbhakti/Pages/Details_page/programDetails.dart';
import 'package:innerbhakti/Pages/Details_page/songs_details.dart';
import 'package:innerbhakti/Pages/bloc/songs_bloc.dart';
import 'package:innerbhakti/model/songs_model.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  final SongsBloc songsBloc = SongsBloc();
  @override
  void initState() {
    super.initState();
    context.read<SongsBloc>().add(SongsInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SongsBloc, SongsState>(
      listenWhen: (previous, current) => current is SongsActionState,
      buildWhen: (previous, current) => current is! SongsActionState,
      listener: (context, state) {
        if (state is MoveToSongsDetailsPageState) {
          Get.to(() => SongsDetails(song: state.song),
              transition: getx.Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 720));
        } else if (state is MovetoProgramDetailsPageState) {
          Get.to(() => ProgramDetails(song: state.song),
              transition: getx.Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 720));
        }
      },
      builder: (context, state) {
        if (state is songloading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (state is songloadsucess) {
          List<SongUiModel> songs = state.songs;

          if (songs.isEmpty) {
            return const Center(child: Text('No songs available'));
          }
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'Programs',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: songs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        SongUiModel song = songs[index];
                        String base64Image = song.songImg ?? '';
                        if (base64Image.startsWith('data:image/jpeg;base64,')) {
                          base64Image = base64Image.split(',')[1];
                        }
                        return InkWell(
                          onTap: () {
                            BlocProvider.of<SongsBloc>(context)
                                .add(MoveToProgramDetailsPageEvent(song: song));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Stack(
                                  fit: StackFit.passthrough,
                                  children: [
                                    Image.memory(
                                      const Base64Decoder()
                                          .convert(base64Image),
                                      fit: BoxFit.fill,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 110),
                                      child: Center(
                                        child: Text(
                                          song.songName ?? 'Song Name',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        "Trending Bhajan",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  GridView.builder(
                    itemCount: songs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      SongUiModel song = songs[index];
                      String base64Image = song.songImg ?? '';
                      if (base64Image.startsWith('data:image/jpeg;base64,')) {
                        base64Image = base64Image.split(',')[1];
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<SongsBloc>(context)
                                .add(MoveToSongsDetailsPageEvent(song));
                          },
                          child: SizedBox(
                            height: 50,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                fit: StackFit.passthrough,
                                children: [
                                  Image.memory(
                                    const Base64Decoder().convert(base64Image),
                                    fit: BoxFit.fill,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 110, left: 0),
                                    child: Center(
                                      child: Text(
                                        song.songName ?? '',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const Scaffold(
          body: Center(child: Text('Unexpected error')),
        );
      },
    );
  }
}
