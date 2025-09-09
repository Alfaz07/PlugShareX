import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../auth/data/models/user_profile_model.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/providers/user_profile_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to edit profile
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: authState.when(
        data: (user) {
          if (user == null) {
            return const Center(
              child: Text('Please sign in to view your profile'),
            );
          }

          // Get user profile from provider
          final userProfile = ref.watch(currentUserProfileProvider);

          if (userProfile == null) {
            // Show loading or create a basic profile from user data
            final basicProfile = UserProfile(
              id: user.uid,
              email: user.email ?? '',
              firstName: user.displayName?.split(' ').first ?? 'User',
              lastName: user.displayName?.split(' ').last ?? '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            return _buildProfileContent(context, basicProfile, ref);
          }

          return _buildProfileContent(context, userProfile, ref);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }

  Widget _buildProfileContent(
      BuildContext context, UserProfile profile, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          _buildProfileHeader(profile),
          const SizedBox(height: AppConstants.xl),

          // Personal Information Section
          _buildSection(
            title: 'Personal Information',
            icon: Icons.person_outline,
            children: [
              _buildInfoTile('Full Name', profile.fullName),
              _buildInfoTile('Email', profile.email),
              if (profile.phoneNumber != null)
                _buildInfoTile('Phone', profile.phoneNumber!),
              _buildInfoTile('Member Since',
                  '${profile.createdAt.day}/${profile.createdAt.month}/${profile.createdAt.year}'),
            ],
          ),
          const SizedBox(height: AppConstants.lg),

          // Vehicle Information Section
          if (profile.vehicle != null) ...[
            _buildSection(
              title: 'Vehicle Information',
              icon: Icons.directions_car_outlined,
              children: [
                _buildInfoTile('Vehicle', profile.vehicle!.displayName),
                if (profile.vehicle!.batteryCapacity != null)
                  _buildInfoTile(
                      'Battery Capacity', profile.vehicle!.batteryCapacity!),
                if (profile.vehicle!.maxChargingRate != null)
                  _buildInfoTile(
                      'Max Charging Rate', profile.vehicle!.maxChargingRate!),
              ],
            ),
            const SizedBox(height: AppConstants.lg),
          ],

          // Charger Preferences Section
          if (profile.chargerPreferences != null) ...[
            _buildSection(
              title: 'Charger Preferences',
              icon: Icons.ev_station_outlined,
              children: [
                _buildInfoTile('Preferred Type',
                    profile.chargerPreferences!.preferredType),
                _buildInfoTile(
                    'Fast Charging',
                    profile.chargerPreferences!.preferFastCharging
                        ? 'Yes'
                        : 'No'),
                _buildInfoTile(
                    'Home Chargers',
                    profile.chargerPreferences!.preferHomeChargers
                        ? 'Yes'
                        : 'No'),
              ],
            ),
            const SizedBox(height: AppConstants.lg),
          ],

          // Hosting Status Section
          _buildSection(
            title: 'Hosting Status',
            icon: Icons.home_outlined,
            children: [
              _buildInfoTile('Charger Host', profile.isHost ? 'Yes' : 'No'),
              if (profile.isHost) ...[
                _buildInfoTile('Earnings', '\$0.00'),
                _buildInfoTile('Total Bookings', '0'),
                _buildInfoTile('Rating', 'No ratings yet'),
              ],
            ],
          ),
          const SizedBox(height: AppConstants.lg),

          // Action Buttons
          _buildActionButtons(context, profile, ref),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(UserProfile profile) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary,
            AppTheme.primaryLight,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: AppConstants.shadowMd,
            ),
            child: Icon(
              Icons.person,
              size: 40,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(width: AppConstants.lg),

          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.fullName,
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppConstants.xs),
                Text(
                  profile.email,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                if (profile.vehicle != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.sm,
                      vertical: AppConstants.xs,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusSm),
                    ),
                    child: Text(
                      profile.vehicle!.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: AppTheme.primary,
                size: 24,
              ),
              const SizedBox(width: AppConstants.sm),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.neutral900,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.md),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.neutral600,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: AppConstants.sm),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.neutral900,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, UserProfile profile, WidgetRef ref) {
    return Column(
      children: [
        // Edit Profile Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              // TODO: Navigate to edit profile
            },
            icon: const Icon(Icons.edit_outlined),
            label: Text(
              'Edit Profile',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppConstants.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.md),

        // Add Vehicle Button
        if (profile.vehicle == null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to add vehicle
              },
              icon: const Icon(Icons.directions_car_outlined),
              label: Text(
                'Add Vehicle',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
            ),
          ),
        if (profile.vehicle == null) const SizedBox(height: AppConstants.md),

        // Become a Host Button
        if (!profile.isHost)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Navigate to become a host
              },
              icon: const Icon(Icons.home_outlined),
              label: Text(
                'Become a Host',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
            ),
          ),
        if (!profile.isHost) const SizedBox(height: AppConstants.md),

        // Sign Out Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () async {
              await ref.read(authStateNotifierProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout_outlined),
            label: Text(
              'Sign Out',
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w600,
                color: AppTheme.error,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.error,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.md),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
