// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserProfileHash() =>
    r'ed09e2f1cb35908374ac378d6f7a20fdd9e0c389';

/// See also [currentUserProfile].
@ProviderFor(currentUserProfile)
final currentUserProfileProvider = AutoDisposeProvider<UserProfile?>.internal(
  currentUserProfile,
  name: r'currentUserProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserProfileRef = AutoDisposeProviderRef<UserProfile?>;
String _$userProfileStateHash() => r'98981f48edd25eb5fae64d66f2e4e1f0c718465c';

/// See also [UserProfileState].
@ProviderFor(UserProfileState)
final userProfileStateProvider =
    AutoDisposeNotifierProvider<UserProfileState, UserProfile?>.internal(
  UserProfileState.new,
  name: r'userProfileStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userProfileStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserProfileState = AutoDisposeNotifier<UserProfile?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
