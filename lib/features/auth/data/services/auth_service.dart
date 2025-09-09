import 'dart:async';

class User {
  final String uid;
  final String? email;
  String? displayName;
  String? photoURL;

  User({required this.uid, this.email, this.displayName, this.photoURL});

  Future<void> updateDisplayName(String? value) async {
    displayName = value;
  }

  Future<void> updatePhotoURL(String? value) async {
    photoURL = value;
  }
}

class UserCredential {
  final User user;
  UserCredential(this.user);
}

class AuthService {
  final StreamController<User?> _controller =
      StreamController<User?>.broadcast();
  User? _currentUser;
  bool _isLoading = false;

  AuthService() {
    // Emit initial value (null) immediately
    print('AuthService: Initializing with null user');
    _controller.add(null);
  }

  // Get current user
  User? get currentUser => _currentUser;

  // Get loading state
  bool get isLoading => _isLoading;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _controller.stream;

  // Sign in with email and password (mock)
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    _isLoading = true;
    print('AuthService: Starting sign in for $email');

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Mock successful authentication
      _currentUser = User(
        uid: 'uid_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: email.split('@').first,
      );

      print('AuthService: Sign in successful for ${_currentUser!.email}');
      _controller.add(_currentUser);
      return UserCredential(_currentUser!);
    } catch (e) {
      print('AuthService: Sign in failed: $e');
      _isLoading = false;
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  // Create user with email and password (mock)
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    _isLoading = true;

    try {
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock validation
      if (email.isEmpty || password.isEmpty) {
        throw Exception('Email and password are required');
      }

      if (password.length < 6) {
        throw Exception('Password must be at least 6 characters');
      }

      // Mock successful user creation
      _currentUser = User(
        uid: 'uid_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        displayName: email.split('@').first,
      );

      _controller.add(_currentUser);
      return UserCredential(_currentUser!);
    } catch (e) {
      _isLoading = false;
      rethrow;
    } finally {
      _isLoading = false;
    }
  }

  // Sign out (mock)
  Future<void> signOut() async {
    _isLoading = true;

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      _currentUser = null;
      _controller.add(null);
    } finally {
      _isLoading = false;
    }
  }

  // Send password reset email (mock)
  Future<void> sendPasswordResetEmail(String email) async {
    _isLoading = true;

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (email.isEmpty) {
        throw Exception('Email is required');
      }

      // Mock successful email sent
    } finally {
      _isLoading = false;
    }
  }

  // Update user profile (mock)
  Future<void> updateProfile({String? displayName, String? photoURL}) async {
    if (_currentUser != null) {
      await _currentUser!.updateDisplayName(displayName);
      await _currentUser!.updatePhotoURL(photoURL);
      _controller.add(_currentUser);
    }
  }

  // Dispose the controller
  void dispose() {
    _controller.close();
  }
}
