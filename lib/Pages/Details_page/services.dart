import 'package:innerbhakti/model/songs_model.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<void> playSong(SongUiModel song) async {
    if (_audioPlayer.playing) {
      print('Stopping current song.');
      await pauseSong(); 
    }

    if (song.songUrl != null && song.songUrl!.isNotEmpty) {
      try {
        await _audioPlayer.setUrl(song.songUrl!); 
        await _audioPlayer.play();
        print('Playing song: ${song.songName}');
      } catch (e) {
        print('Error playing song: $e');
      }
    } else {
      print('Audio URL is null or empty.');
    }
  }

  Future<void> pauseSong() async {
    print(
        'Attempting to pause song. Current playing state: ${_audioPlayer.playing}');
    try {
      await _audioPlayer.pause();
      print('Paused song. Is playing: ${_audioPlayer.playing}');
    } catch (e) {
      print('Error pausing song: $e');
    }
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}
