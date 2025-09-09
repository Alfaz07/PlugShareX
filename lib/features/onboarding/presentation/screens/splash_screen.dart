import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _backgroundController;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _backgroundController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _startAnimations();
  }

  void _startAnimations() async {
    if (!mounted) return;

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted && _backgroundController.isDismissed) {
      _backgroundController.forward();
    }

    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted && _logoController.isDismissed) {
      _logoController.forward();
    }

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted && _textController.isDismissed) {
      _textController.forward();
    }

    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      _navigateToOnboarding();
    }
  }

  void _navigateToOnboarding() {
    // Don't navigate - let the auth wrapper handle navigation
    // The splash screen will be replaced by the auth wrapper
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Stack(
          children: [
            // Animated background elements
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              )
                  .animate(controller: _backgroundController)
                  .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                  .fadeIn(duration: const Duration(milliseconds: 1500)),
            ),

            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.05),
                ),
              )
                  .animate(controller: _backgroundController)
                  .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                  .fadeIn(duration: const Duration(milliseconds: 2000)),
            ),

            // Main content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusXl,
                      ),
                      boxShadow: AppConstants.shadowLg,
                    ),
                    child: const Icon(
                      Icons.electric_car,
                      size: 60,
                      color: AppTheme.primary,
                    ),
                  )
                      .animate(controller: _logoController)
                      .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                      .fadeIn(duration: const Duration(milliseconds: 1000))
                      .then()
                      .shimmer(duration: const Duration(milliseconds: 1500)),

                  const SizedBox(height: AppConstants.xl),

                  // App name
                  Text(
                    'PlugShareX',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  )
                      .animate(controller: _textController)
                      .fadeIn(duration: const Duration(milliseconds: 800))
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: const Duration(milliseconds: 800),
                      ),

                  const SizedBox(height: AppConstants.sm),

                  // Tagline
                  Text(
                    'Share your charger, power the future',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  )
                      .animate(controller: _textController)
                      .fadeIn(delay: const Duration(milliseconds: 200))
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: const Duration(milliseconds: 800),
                      ),

                  const SizedBox(height: AppConstants.xxl),

                  // Loading indicator
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white.withOpacity(0.8),
                      ),
                    ),
                  )
                      .animate(controller: _textController)
                      .fadeIn(delay: const Duration(milliseconds: 400))
                      .scale(
                        begin: const Offset(0, 0),
                        end: const Offset(1, 1),
                      ),
                ],
              ),
            ),

            // Bottom glassmorphism card
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppConstants.radiusXl),
                    topRight: Radius.circular(AppConstants.radiusXl),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                            AppConstants.radiusXl,
                          ),
                          topRight: Radius.circular(
                            AppConstants.radiusXl,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  .animate(controller: _backgroundController)
                  .slideY(
                    begin: 1,
                    end: 0,
                    duration: const Duration(milliseconds: 1500),
                  )
                  .fadeIn(duration: const Duration(milliseconds: 1500)),
            ),
          ],
        ),
      ),
    );
  }
}
