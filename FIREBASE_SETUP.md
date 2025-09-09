# Firebase Setup Guide for PlugShareX

## Current Status
✅ **App is working with mock authentication**
✅ **All compilation errors fixed**
✅ **Web app running successfully**

## Firebase Integration Steps

### 1. Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project"
3. Enter project name: `plugsharex`
4. Enable Google Analytics (optional)
5. Click "Create project"

### 2. Enable Authentication
1. In Firebase Console, go to "Authentication"
2. Click "Get started"
3. Go to "Sign-in method" tab
4. Enable "Email/Password"
5. Click "Save"

### 3. Enable Firestore Database
1. In Firebase Console, go to "Firestore Database"
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location close to your users
5. Click "Done"

### 4. Configure FlutterFire CLI
```bash
# Install FlutterFire CLI (if not already installed)
dart pub global activate flutterfire_cli

# Configure Firebase for your project
flutterfire configure --project=plugsharex
```

### 5. Enable Firebase in the App
1. **Uncomment Firebase dependencies in `pubspec.yaml`:**
```yaml
# Firebase Integration
firebase_core: ^2.32.0
firebase_auth: ^4.16.0
cloud_firestore: ^4.17.5
firebase_storage: ^11.6.5
firebase_messaging: ^14.7.10
firebase_analytics: ^10.10.7
```

2. **Update `lib/main.dart`:**
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Initialize Hive for local storage
  await Hive.initFlutter();
  
  runApp(const ProviderScope(child: PlugShareXApp()));
}
```

3. **Update `lib/features/auth/data/services/auth_service.dart`:**
```dart
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Get current user
  User? get currentUser => _auth.currentUser;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Create user with email and password
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  // Update user profile
  Future<void> updateProfile({
    String? displayName,
    String? photoURL,
  }) async {
    await _auth.currentUser?.updateDisplayName(displayName);
    await _auth.currentUser?.updatePhotoURL(photoURL);
  }
}
```

4. **Update `lib/features/auth/presentation/providers/auth_provider.dart`:**
```dart
import 'package:firebase_auth/firebase_auth.dart';
```

### 6. Install Dependencies
```bash
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 7. Test Firebase Integration
```bash
flutter run -d chrome --web-port=8080
```

## Features Working with Mock Authentication

### ✅ Authentication Features
- **Sign Up**: Create new user accounts with email/password
- **Sign In**: Login with existing credentials
- **Password Reset**: Request password reset email
- **Profile Management**: Update user profile information
- **Sign Out**: Logout functionality

### ✅ UI Features
- **Modern Design**: Card-based layout with smooth animations
- **Responsive**: Works on different screen sizes
- **Theme Support**: Light/dark theme with system preference
- **Loading States**: Proper loading indicators
- **Error Handling**: User-friendly error messages

### ✅ Navigation
- **Bottom Navigation**: Home, Map, Profile, Settings
- **Authentication Flow**: Proper auth state management
- **Splash Screen**: Loading screen with app branding

### ✅ Map Features
- **Interactive Map**: Placeholder with dummy charger data
- **Charger Markers**: Clickable charger locations
- **Search Functionality**: Search bar (placeholder)
- **Charger Details**: Detailed charger information cards

## Next Steps for Full Firebase Integration

1. **Complete Firebase Setup**: Follow the steps above
2. **Add Real Data**: Replace mock data with Firestore
3. **Implement Maps**: Add real Google Maps or Mapbox integration
4. **Add Push Notifications**: Configure Firebase Messaging
5. **Add Analytics**: Track user behavior with Firebase Analytics
6. **Add Storage**: Upload user profile images to Firebase Storage

## Troubleshooting

### If Firebase web compilation fails:
1. Make sure you're using compatible Firebase package versions
2. Try updating the `js` package: `flutter pub upgrade js`
3. Clear cache: `flutter clean && flutter pub get`
4. Check Firebase Console for proper configuration

### If authentication doesn't work:
1. Verify Firebase project is properly configured
2. Check that Email/Password auth is enabled
3. Ensure `firebase_options.dart` has correct values
4. Test with a simple email/password combination

## Current Working Features

The app currently works with a mock authentication system that simulates Firebase behavior. Users can:
- Sign up with email/password
- Sign in with credentials
- Reset passwords
- Update profiles
- Navigate through the app
- View the interactive map placeholder
- Access all UI features

All compilation errors have been resolved and the app runs successfully on web platforms. 