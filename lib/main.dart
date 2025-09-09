import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:firebase_core/firebase_core.dart'; // Temporarily disabled

import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'features/onboarding/presentation/screens/simple_splash_screen.dart';
import 'features/onboarding/presentation/screens/premium_onboarding_screen.dart';
import 'features/auth/presentation/screens/auth_screen.dart';
import 'features/auth/presentation/providers/auth_provider.dart';
import 'features/navigation/presentation/screens/main_navigation.dart';
// import 'firebase_options.dart'; // Temporarily disabled

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase (temporarily disabled)
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Initialize Hive for local storage
  await Hive.initFlutter();

  runApp(const ProviderScope(child: PlugShareXApp()));
}

class PlugShareXApp extends ConsumerWidget {
  const PlugShareXApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('PlugShareXApp: Building app');
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Auto switch based on system preference
      home: const SimpleSplashScreen(), // Start with splash screen
    );
  }
}

class AppRouter extends ConsumerWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (user) {
        if (user != null) {
          // User is authenticated, show main app
          return const MainNavigation();
        } else {
          // User is not authenticated, show onboarding flow
          return const SimpleSplashScreen();
        }
      },
      loading: () {
        // Show loading screen while checking auth state
        return const LoadingScreen();
      },
      error: (error, stack) {
        // Show error screen or fallback to auth screen
        return const AuthScreen();
      },
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primary,
              AppTheme.primaryLight,
              AppTheme.secondary,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusXl),
                  boxShadow: AppConstants.shadowLg,
                ),
                child: const Icon(
                  Icons.electric_car,
                  size: 50,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(height: AppConstants.xl),

              // Loading indicator
              const SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
