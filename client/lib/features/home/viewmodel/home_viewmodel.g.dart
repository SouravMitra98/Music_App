// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// ---------------- Providers ----------------
@ProviderFor(getAllSongs)
const getAllSongsProvider = GetAllSongsProvider._();

/// ---------------- Providers ----------------
final class GetAllSongsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SongModel>>,
          List<SongModel>,
          FutureOr<List<SongModel>>
        >
    with $FutureModifier<List<SongModel>>, $FutureProvider<List<SongModel>> {
  /// ---------------- Providers ----------------
  const GetAllSongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getAllSongsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getAllSongsHash();

  @$internal
  @override
  $FutureProviderElement<List<SongModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SongModel>> create(Ref ref) {
    return getAllSongs(ref);
  }
}

String _$getAllSongsHash() => r'b02d40c78112a53d28004ce3ae4130eb7f62bdcd';

@ProviderFor(getFavSongs)
const getFavSongsProvider = GetFavSongsProvider._();

final class GetFavSongsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SongModel>>,
          List<SongModel>,
          FutureOr<List<SongModel>>
        >
    with $FutureModifier<List<SongModel>>, $FutureProvider<List<SongModel>> {
  const GetFavSongsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFavSongsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFavSongsHash();

  @$internal
  @override
  $FutureProviderElement<List<SongModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SongModel>> create(Ref ref) {
    return getFavSongs(ref);
  }
}

String _$getFavSongsHash() => r'ef90b2dc389cf1e68ab77f3e58fe03d7dc23eb47';

/// ---------------- ViewModel ----------------
@ProviderFor(HomeViewModel)
const homeViewModelProvider = HomeViewModelProvider._();

/// ---------------- ViewModel ----------------
final class HomeViewModelProvider
    extends $NotifierProvider<HomeViewModel, AsyncValue?> {
  /// ---------------- ViewModel ----------------
  const HomeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeViewModelHash();

  @$internal
  @override
  HomeViewModel create() => HomeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue?>(value),
    );
  }
}

String _$homeViewModelHash() => r'bbd55ae87f4274684ca88f5e81adc5b778473cf9';

abstract class _$HomeViewModel extends $Notifier<AsyncValue?> {
  AsyncValue? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue?, AsyncValue?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue?, AsyncValue?>,
              AsyncValue?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
