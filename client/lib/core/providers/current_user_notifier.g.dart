// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_user_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(CurrentUserNotifier)
const currentUserNotifierProvider = CurrentUserNotifierProvider._();

final class CurrentUserNotifierProvider
    extends $NotifierProvider<CurrentUserNotifier, UserModel?> {
  const CurrentUserNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentUserNotifierProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentUserNotifierHash();

  @$internal
  @override
  CurrentUserNotifier create() => CurrentUserNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserModel?>(value),
    );
  }
}

String _$currentUserNotifierHash() =>
    r'002b81f154e99725514361878fb229b209e96ce9';

abstract class _$CurrentUserNotifier extends $Notifier<UserModel?> {
  UserModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserModel?, UserModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserModel?, UserModel?>,
              UserModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
