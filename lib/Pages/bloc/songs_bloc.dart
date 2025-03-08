import 'dart:async';
import 'dart:convert';

// import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:innerbhakti/model/songs_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'songs_event.dart';
part 'songs_state.dart';

class SongsBloc extends Bloc<SongsEvent, SongsState> {
  SongsBloc() : super(SongsInitial()) {
    on<SongsInitialFetchEvent>(songsInitialFetchEvent);
    on<MoveToSongsDetailsPageEvent>(moveToSongsDetailsPageEvent);
    on<MoveToProgramDetailsPageEvent>(moveToProgramDetailsPageEvent);
  }

  Future<FutureOr<void>> songsInitialFetchEvent(
      SongsInitialFetchEvent event, Emitter<SongsState> emit) async {
    // log('Event fired');
    emit(songloading());
    List<SongUiModel> songs = [];
    try {
      var uri = Uri.parse('https://innerserver.onrender.com/fetchsong');
      var response = await http.get(uri);

      if (response.statusCode == 200) {
        List data = jsonDecode(response.body);
        // print(data);
        for (var item in data) {
          if (item is Map<String, dynamic>) {
            SongUiModel song = SongUiModel.fromJson(item);
            songs.add(song);
            // print(song.about);
          } else {
            // print('Error');
          }
        }
        // print('Parsed Songs: $songs');
        emit(songloadsucess(songs: songs));
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  FutureOr<void> moveToSongsDetailsPageEvent(
      MoveToSongsDetailsPageEvent event, Emitter<SongsState> emit) {
    emit(MoveToSongsDetailsPageState(song: event.song));
  }

  FutureOr<void> moveToProgramDetailsPageEvent(
      MoveToProgramDetailsPageEvent event, Emitter<SongsState> emit) {
    emit(MovetoProgramDetailsPageState(song: event.song));
  }
}
