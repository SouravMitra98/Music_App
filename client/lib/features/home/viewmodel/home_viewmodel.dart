import 'dart:io';
import 'dart:ui';
import 'package:client/core/providers/current_user_notifier.dart';
import 'package:client/core/utils.dart';
import 'package:client/features/home/models/fav_song_model.dart';
import 'package:client/features/home/models/song_model.dart';
import 'package:client/features/home/repository/home_local_repository.dart';
import 'package:client/features/home/repository/home_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_viewmodel.g.dart';

/// ---------------- Providers ----------------

@riverpod
Future<List<SongModel>> getAllSongs(Ref ref) async {
  final token = ref.watch(
    currentUserNotifierProvider.select((user) => user!.token),
  );
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<SongModel>> getFavSongs(Ref ref) async {
  final token = ref.watch(
    currentUserNotifierProvider.select((user) => user!.token),
  );
  final res = await ref.watch(homeRepositoryProvider).getFavSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

/// ---------------- ViewModel ----------------

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late final HomeRepository _homeRepository;
  late final HomeLocalRepository _homeLocalRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();

    final token = ref.read(currentUserNotifierProvider)!.token;

    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: rgbToHex(selectedColor),
      token: token,
    );

    state = switch (res) {
      Left(value: final l) => AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => AsyncValue.data(r),
    };
  }

  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalRepository.loadSongs();
  }

  Future<void> favSong({required String songId}) async {
    final userNotifier = ref.read(currentUserNotifierProvider.notifier);
    final user = ref.read(currentUserNotifierProvider)!;
    final token = user.token;

    final isAlreadyFav = user.favorites.any((fav) => fav.song_id == songId);

    if (isAlreadyFav) {
      userNotifier.addUser(
        user.copyWith(
          favorites: user.favorites
              .where((fav) => fav.song_id != songId)
              .toList(),
        ),
      );
    } else {
      userNotifier.addUser(
        user.copyWith(
          favorites: [
            ...user.favorites,
            FavSongModel(id: '', song_id: songId, user_id: ''),
          ],
        ),
      );
    }

    // Call API
    final res = await _homeRepository.favSong(songId: songId, token: token);

    if (!ref.mounted) return;

    switch (res) {
      case Left(value: final l):
        if (isAlreadyFav) {
          userNotifier.addUser(
            user.copyWith(
              favorites: [
                ...user.favorites,
                FavSongModel(id: '', song_id: songId, user_id: ''),
              ],
            ),
          );
        } else {
          userNotifier.addUser(
            user.copyWith(
              favorites: user.favorites
                  .where((fav) => fav.song_id != songId)
                  .toList(),
            ),
          );
        }
        state = AsyncValue.error(l.message, StackTrace.current);

      case Right(value: final isFavorited):
        if (ref.mounted) {
          ref.invalidate(getFavSongsProvider);
          ref.invalidate(getAllSongsProvider);
        }

        state = AsyncValue.data(isFavorited);
    }
  }
}
