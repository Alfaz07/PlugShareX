import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/services/auth_service.dart' show User;
import '../providers/auth_provider.dart';
import '../../../navigation/presentation/screens/main_navigation.dart';

class NeoLoginScreen extends ConsumerStatefulWidget {
  const NeoLoginScreen({super.key});

  @override
  ConsumerState<NeoLoginScreen> createState() => _NeoLoginScreenState();
}

class _NeoLoginScreenState extends ConsumerState<NeoLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isSignUp = false;
  bool _obscure = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_isSignUp) {
      await ref
          .read(authStateNotifierProvider.notifier)
          .createUserWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text,
          );
    } else {
      await ref
          .read(authStateNotifierProvider.notifier)
          .signInWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Navigate when user logs in
    ref.listen<AsyncValue<User?>>(authStateNotifierProvider, (prev, next) {
      next.whenData((user) {
        if (user != null) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, a, __) => const MainNavigation(),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        }
      });
    });

    final isLoading = ref.watch(authStateNotifierProvider).isLoading;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () => setState(() => _isSignUp = !_isSignUp),
            child: Text(
              _isSignUp
                  ? 'Have an account? Sign in'
                  : 'New here? Create account',
              style: GoogleFonts.inter(color: Colors.white),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B1020), Color(0xFF0D0F1A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Hero heading
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppConstants.xl),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [AppTheme.primaryLight, AppTheme.secondaryLight],
                    ).createShader(bounds),
                    child: Text(
                      'PlugShareX',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms)
                      .slideY(begin: 0.2, end: 0),
                  const SizedBox(height: AppConstants.sm),
                  Text(
                    _isSignUp
                        ? 'Create your account to start charging smarter.'
                        : 'Welcome back! Sign in to continue.',
                    style: GoogleFonts.inter(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: AppConstants.xl),

                  // Glass card form
                  Container(
                    padding: const EdgeInsets.all(AppConstants.lg),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.06),
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusXl),
                      border: Border.all(color: Colors.white.withOpacity(0.08)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 30,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.white),
                            decoration: _fieldDecoration(
                              label: 'Email address',
                              icon: Icons.alternate_email_rounded,
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Email required';
                              }
                              if (!v.contains('@'))
                                return 'Enter a valid email';
                              return null;
                            },
                          ),
                          const SizedBox(height: AppConstants.md),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: _obscure,
                            style: const TextStyle(color: Colors.white),
                            decoration: _fieldDecoration(
                              label: 'Password',
                              icon: Icons.lock_outline_rounded,
                              suffix: IconButton(
                                onPressed: () =>
                                    setState(() => _obscure = !_obscure),
                                icon: Icon(
                                  _obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return 'Password required';
                              if (v.length < 6) return 'Min 6 characters';
                              return null;
                            },
                          ),
                          const SizedBox(height: AppConstants.lg),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: isLoading ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppConstants.md,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppConstants.radiusLg),
                                    ),
                                  ),
                                  child: Text(
                                    isLoading
                                        ? 'Please wait...'
                                        : (_isSignUp
                                            ? 'Create account'
                                            : 'Sign in'),
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppConstants.sm),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: isLoading
                                  ? null
                                  : () async {
                                      if (_emailController.text
                                          .trim()
                                          .isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Enter your email to reset password'),
                                            backgroundColor: Colors.orange,
                                          ),
                                        );
                                        return;
                                      }
                                      await ref
                                          .read(authStateNotifierProvider
                                              .notifier)
                                          .sendPasswordResetEmail(
                                              _emailController.text.trim());
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content:
                                              Text('Reset instructions sent'),
                                        ),
                                      );
                                    },
                              child: const Text('Forgot password?'),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(duration: 400.ms, delay: 100.ms)
                      .move(begin: const Offset(0, 12), end: Offset.zero),

                  const SizedBox(height: AppConstants.xl),

                  // Social or info footer (placeholder)
                  Center(
                    child: Text(
                      'By continuing, you agree to our Terms & Privacy Policy',
                      style: GoogleFonts.inter(
                          color: Colors.white54, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: AppConstants.lg),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _fieldDecoration(
      {required String label, required IconData icon, Widget? suffix}) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white.withOpacity(0.06),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        borderSide: const BorderSide(color: AppTheme.primaryLight, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        borderSide: const BorderSide(color: AppTheme.error, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.md,
        vertical: AppConstants.md,
      ),
    );
  }
}



