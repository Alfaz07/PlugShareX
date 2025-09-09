import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../navigation/presentation/screens/main_navigation.dart';
import '../providers/auth_provider.dart';
import '../../data/services/auth_service.dart' show User;
import 'registration_screen.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _obscurePassword = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isSignUp = !_isSignUp;
      _acceptTerms = false; // Reset terms acceptance when switching modes
    });
    // Clear any previous errors when switching modes
    ref.read(authErrorProvider.notifier).state = null;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleTermsAcceptance() {
    setState(() {
      _acceptTerms = !_acceptTerms;
    });
  }

  Future<void> _handleEmailAuth() async {
    if (!_formKey.currentState!.validate()) return;

    if (_isSignUp && !_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms and conditions'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      if (_isSignUp) {
        // Navigate to registration screen for sign up
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RegistrationScreen(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            ),
          ),
        );
      } else {
        await ref
            .read(authStateNotifierProvider.notifier)
            .signInWithEmailAndPassword(
              _emailController.text.trim(),
              _passwordController.text,
            );
      }
    } catch (e) {
      // Error is handled by the provider
    }
  }

  Future<void> _handleForgotPassword() async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address first'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      await ref.read(authStateNotifierProvider.notifier).sendPasswordResetEmail(
            _emailController.text.trim(),
          );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset email sent! Check your inbox.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to send reset email: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToMain() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MainNavigation(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  // Password strength indicator
  double _getPasswordStrength() {
    final password = _passwordController.text;
    if (password.isEmpty) return 0.0;

    double strength = 0.0;
    if (password.length >= 8) strength += 0.25;
    if (password.contains(RegExp(r'[a-z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[A-Z]'))) strength += 0.25;
    if (password.contains(RegExp(r'[0-9]'))) strength += 0.25;

    return strength;
  }

  Color _getPasswordStrengthColor() {
    final strength = _getPasswordStrength();
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return Colors.yellow;
    return Colors.green;
  }

  String _getPasswordStrengthText() {
    final strength = _getPasswordStrength();
    if (strength <= 0.25) return 'Weak';
    if (strength <= 0.5) return 'Fair';
    if (strength <= 0.75) return 'Good';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final authError = ref.watch(authErrorProvider);
    final isLoading = ref.watch(authLoadingProvider);

    // Listen for successful authentication
    ref.listen<AsyncValue<User?>>(authStateProvider, (previous, next) {
      next.whenData((user) {
        if (user != null) {
          // Navigate to main app when authenticated
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const MainNavigation(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        }
      });
    });

    // Show error messages
    if (authError != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(authError),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
        ref.read(authErrorProvider.notifier).state = null;
      });
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    (AppConstants.lg * 2),
              ),
              child: Column(
                children: [
                  const SizedBox(height: AppConstants.xl),

                  // Logo and title
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusXl,
                      ),
                      boxShadow: AppConstants.shadowLg,
                    ),
                    child: const Icon(
                      Icons.electric_car,
                      size: 50,
                      color: AppTheme.primary,
                    ),
                  )
                      .animate()
                      .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
                      .fadeIn(duration: const Duration(milliseconds: 800)),

                  const SizedBox(height: AppConstants.lg),

                  Text(
                    'PlugShareX',
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 200))
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: const Duration(milliseconds: 600),
                      ),

                  const SizedBox(height: AppConstants.sm),

                  Text(
                    _isSignUp ? 'Create your account' : 'Welcome back',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 400))
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: const Duration(milliseconds: 600),
                      ),

                  const SizedBox(height: AppConstants.xl),

                  // Auth form
                  Container(
                    padding: const EdgeInsets.all(AppConstants.lg),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(
                        AppConstants.radiusLg,
                      ),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email field
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: GoogleFonts.inter(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.white70,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMd,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.white30,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMd,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.white30,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMd,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: AppConstants.md),

                          // Password field
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            style: GoogleFonts.inter(color: Colors.white),
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.inter(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.white70,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white70,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMd,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.white30,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMd,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.white30,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  AppConstants.radiusMd,
                                ),
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),

                          // Password strength indicator (only for sign up)
                          if (_isSignUp &&
                              _passwordController.text.isNotEmpty) ...[
                            const SizedBox(height: AppConstants.sm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: _getPasswordStrength(),
                                        backgroundColor:
                                            Colors.white.withValues(alpha: 0.3),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          _getPasswordStrengthColor(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppConstants.sm),
                                    Text(
                                      _getPasswordStrengthText(),
                                      style: GoogleFonts.inter(
                                        color: _getPasswordStrengthColor(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppConstants.xs),
                                Text(
                                  'Password must be at least 8 characters with uppercase, lowercase, and numbers',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withValues(alpha: 0.7),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ],

                          // Forgot password link (only for sign in)
                          if (!_isSignUp) ...[
                            const SizedBox(height: AppConstants.sm),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: _handleForgotPassword,
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.inter(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],

                          // Terms acceptance checkbox (only for sign up)
                          if (_isSignUp) ...[
                            const SizedBox(height: AppConstants.md),
                            Row(
                              children: [
                                Checkbox(
                                  value: _acceptTerms,
                                  onChanged: (value) =>
                                      _toggleTermsAcceptance(),
                                  fillColor: WidgetStateProperty.resolveWith(
                                    (states) =>
                                        states.contains(WidgetState.selected)
                                            ? Colors.white
                                            : Colors.transparent,
                                  ),
                                  checkColor: AppTheme.primary,
                                  side: const BorderSide(color: Colors.white70),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: _toggleTermsAcceptance,
                                    child: Text(
                                      'I agree to the Terms of Service and Privacy Policy',
                                      style: GoogleFonts.inter(
                                        color:
                                            Colors.white.withValues(alpha: 0.8),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],

                          const SizedBox(height: AppConstants.lg),

                          // Sign in/up button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: isLoading ? null : _handleEmailAuth,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: AppTheme.primary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppConstants.md,
                                ),
                                elevation: 0,
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          AppTheme.primary,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      _isSignUp ? 'Sign Up' : 'Sign In',
                                      style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                            ),
                          ),

                          const SizedBox(height: AppConstants.md),

                          // Toggle auth mode
                          TextButton(
                            onPressed: _toggleAuthMode,
                            child: Text(
                              _isSignUp
                                  ? 'Already have an account? Sign In'
                                  : 'Don\'t have an account? Sign Up',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 600))
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        duration: const Duration(milliseconds: 600),
                      ),

                  const SizedBox(height: AppConstants.lg),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.md,
                        ),
                        child: Text(
                          'or',
                          style: GoogleFonts.inter(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: const Duration(milliseconds: 800)),

                  const SizedBox(height: AppConstants.lg),

                  // App features preview
                  if (_isSignUp) ...[
                    Container(
                      padding: const EdgeInsets.all(AppConstants.lg),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusLg),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Why Choose PlugShareX?',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: AppConstants.md),
                          _buildFeatureItem(
                              'Find nearby EV chargers', Icons.location_on),
                          _buildFeatureItem(
                              'Real-time availability', Icons.schedule),
                          _buildFeatureItem(
                              'Earn money by hosting', Icons.attach_money),
                          _buildFeatureItem('Community reviews', Icons.star),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(milliseconds: 1200)),
                    const SizedBox(height: AppConstants.lg),
                  ],

                  // Terms and privacy
                  Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(delay: const Duration(milliseconds: 1200)),

                  // Add bottom spacing to ensure content doesn't get cut off
                  const SizedBox(height: AppConstants.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.sm),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(width: AppConstants.sm),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
