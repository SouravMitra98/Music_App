import 'package:client/features/home/models/song_model.dart';
import 'package:client/features/home/repository/home_local_repository.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';

part 'current_song_notifier.g.dart';

@riverpod
class CurrentSongNotifier extends _$CurrentSongNotifier {
  late HomeLocalRepository _homeLocalRepository;
  AudioPlayer? audioPlayer;

  @override
  SongModel? build() {
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  // Play a new song
  Future<void> updateSong(SongModel song) async {
    await audioPlayer?.dispose();
    audioPlayer = AudioPlayer();

    // Set new audio source
    final audioSource = AudioSource.uri(
      Uri.parse(song.song_url),
      tag: MediaItem(
        id: song.id,
        title: song.song_name,
        artist: song.artist,
        artUri: Uri.parse(song.thumbnail_url),
      ),
    );
    await audioPlayer!.setAudioSource(audioSource);

    // Listen to PlayerState to update isPlaying and detect completion
    audioPlayer!.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processing = playerState.processingState;

      // Update the notifier state with current playing status
      state = song.copyWith(isPlaying: isPlaying);

      // When song finishes
      if (processing == ProcessingState.completed) {
        audioPlayer!.seek(Duration.zero);
        audioPlayer!.pause();
        state = state?.copyWith(isPlaying: false);
      }
    });

    _homeLocalRepository.uploadLocalSong(song);

    // Start playing
    await audioPlayer!.play();
    state = song.copyWith(isPlaying: true);
  }

  // Toggle play/pause
  Future<void> playPause() async {
    if (state == null || audioPlayer == null) return;

    if (audioPlayer!.playing) {
      await audioPlayer!.pause();
      state = state!.copyWith(isPlaying: false);
    } else {
      await audioPlayer!.play();
      state = state!.copyWith(isPlaying: true);
    }
  }

  // Seek to a position (0.0 - 1.0)
  void seek(double val) {
    if (audioPlayer?.duration != null) {
      audioPlayer!.seek(
        Duration(
          milliseconds: (val * audioPlayer!.duration!.inMilliseconds).toInt(),
        ),
      );
    }
  }
}
