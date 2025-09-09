import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/presentation/screens/auth_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Find Chargers Nearby',
      description:
          'Discover available EV chargers in your area with real-time availability and detailed information.',
      icon: Icons.location_on,
      gradient: [AppTheme.primary, AppTheme.primaryLight],
    ),
    OnboardingPage(
      title: 'Share Your Charger',
      description:
          'Earn money by sharing your home charger with other EV drivers. Set your own schedule and pricing.',
      icon: Icons.share,
      gradient: [AppTheme.secondary, AppTheme.secondaryLight],
    ),
    OnboardingPage(
      title: 'Seamless Experience',
      description:
          'Book, pay, and charge with ease. Get notifications, track sessions, and manage everything from one app.',
      icon: Icons.flash_on,
      gradient: [AppTheme.accent, AppTheme.accentLight],
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToAuth();
    }
  }

  void _navigateToAuth() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AuthScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _pages[_currentPage].gradient,
              ),
            ),
          ),

          // Page content
          Column(
            children: [
              // Skip button
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(AppConstants.md),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logo
                      Container(
                        padding: const EdgeInsets.all(AppConstants.sm),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(
                            AppConstants.radiusMd,
                          ),
                        ),
                        child: const Icon(
                          Icons.electric_car,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),

                      // Skip button
                      TextButton(
                        onPressed: _navigateToAuth,
                        child: Text(
                          'Skip',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Page view
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPage(_pages[index], index);
                  },
                ),
              ),

              // Bottom section
              Container(
                padding: const EdgeInsets.all(AppConstants.lg),
                child: Column(
                  children: [
                    // Page indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.white
                                : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(
                              AppConstants.radiusFull,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: AppConstants.xl),

                    // Action buttons
                    Row(
                      children: [
                        // Previous button
                        if (_currentPage > 0)
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                _pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white),
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppConstants.md,
                                ),
                              ),
                              child: Text(
                                'Previous',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                        if (_currentPage > 0)
                          const SizedBox(width: AppConstants.md),

                        // Next/Get Started button
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: _nextPage,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: _pages[_currentPage].gradient[0],
                              padding: const EdgeInsets.symmetric(
                                vertical: AppConstants.md,
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              _currentPage == _pages.length - 1
                                  ? 'Get Started'
                                  : 'Next',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page, int index) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(AppConstants.radiusXl),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(page.icon, size: 60, color: Colors.white),
            )
                .animate(delay: Duration(milliseconds: index * 200))
                .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                .fadeIn(duration: const Duration(milliseconds: 800)),

            const SizedBox(height: AppConstants.xl),

            // Title
            Text(
              page.title,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            )
                .animate(delay: Duration(milliseconds: index * 200 + 200))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),

            const SizedBox(height: AppConstants.md),

            // Description
            Text(
              page.description,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            )
                .animate(delay: Duration(milliseconds: index * 200 + 400))
                .fadeIn(duration: const Duration(milliseconds: 600))
                .slideY(
                  begin: 0.3,
                  end: 0,
                  duration: const Duration(milliseconds: 600),
                ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}
