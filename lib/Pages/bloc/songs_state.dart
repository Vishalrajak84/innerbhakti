part of 'songs_bloc.dart';

@immutable
abstract class SongsState {}

abstract class SongsActionState extends SongsState {}

class SongsInitial extends SongsState {}

class songloading extends SongsState {}

class songloadsucess extends SongsState {
  final List<SongUiModel> songs;

  songloadsucess({required this.songs});
}

class MoveToSongsDetailsPageState extends SongsActionState {
  final SongUiModel song;

  MoveToSongsDetailsPageState({required this.song});
}

class MovetoProgramDetailsPageState extends SongsActionState {
  final SongUiModel song;

  MovetoProgramDetailsPageState({required this.song});
}
