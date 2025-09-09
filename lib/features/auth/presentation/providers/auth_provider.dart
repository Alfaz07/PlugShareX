import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// Stream of current user
final authStateProvider = StreamProvider((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final authErrorProvider = StateProvider<String?>((ref) => null);

// Loading state provider
final authLoadingProvider = StateProvider<bool>((ref) => false);

class AuthStateNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthService _authService;
  final Ref _ref;

  AuthStateNotifier(this._authService, this._ref)
      : super(const AsyncValue.data(null)) {
    _authService.authStateChanges.listen((user) {
      state = AsyncValue.data(user);
    });
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;

      await _authService.signInWithEmailAndPassword(email, password);
    } catch (e, st) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
      state = AsyncValue.error(e, st);
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;

      await _authService.createUserWithEmailAndPassword(email, password);
    } catch (e, st) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
      state = AsyncValue.error(e, st);
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> signOut() async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      await _authService.signOut();
    } catch (e, st) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
      state = AsyncValue.error(e, st);
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      _ref.read(authLoadingProvider.notifier).state = true;
      _ref.read(authErrorProvider.notifier).state = null;

      await _authService.sendPasswordResetEmail(email);
    } catch (e, st) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
      rethrow;
    } finally {
      _ref.read(authLoadingProvider.notifier).state = false;
    }
  }

  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    try {
      await _authService.updateProfile(
          displayName: displayName, photoURL: photoURL);
    } catch (e, st) {
      _ref.read(authErrorProvider.notifier).state = e.toString();
      rethrow;
    }
  }
}

final authStateNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<User?>>((ref) {
  final service = ref.watch(authServiceProvider);
  return AuthStateNotifier(service, ref);
});
