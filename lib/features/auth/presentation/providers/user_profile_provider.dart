import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/user_profile_model.dart';

part 'user_profile_provider.g.dart';

// User profile provider
@riverpod
class UserProfileState extends _$UserProfileState {
  @override
  UserProfile? build() {
    return null;
  }

  void setUserProfile(UserProfile profile) {
    state = profile;
  }

  void clearUserProfile() {
    state = null;
  }

  void updateUserProfile(UserProfile Function(UserProfile) update) {
    if (state != null) {
      state = update(state!);
    }
  }
}

// Current user profile provider
@riverpod
UserProfile? currentUserProfile(CurrentUserProfileRef ref) {
  return ref.watch(userProfileStateProvider);
}
