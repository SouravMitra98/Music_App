// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_song_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(CurrentSongNotifier)
const currentSongNotifierProvider = CurrentSongNotifierProvider._();

final class CurrentSongNotifierProvider
    extends $NotifierProvider<CurrentSongNotifier, SongModel?> {
  const CurrentSongNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentSongNotifierProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentSongNotifierHash();

  @$internal
  @override
  CurrentSongNotifier create() => CurrentSongNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SongModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SongModel?>(value),
    );
  }
}

String _$currentSongNotifierHash() =>
    r'c76e3c9cc91a2e3ceb504d8fa4047bdef4ae4b56';

abstract class _$CurrentSongNotifier extends $Notifier<SongModel?> {
  SongModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<SongModel?, SongModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SongModel?, SongModel?>,
              SongModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
