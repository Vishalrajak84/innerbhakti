part of 'songs_bloc.dart';

@immutable
abstract class SongsEvent {}

class SongsInitialFetchEvent extends SongsEvent {}

class MoveToSongsDetailsPageEvent extends SongsEvent {
  final SongUiModel song;

  MoveToSongsDetailsPageEvent(this.song);
}

class MoveToProgramDetailsPageEvent extends SongsEvent {
  final SongUiModel song;

  MoveToProgramDetailsPageEvent({required this.song});
}
