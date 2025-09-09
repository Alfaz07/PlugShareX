import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationServices = true;
  bool _darkMode = false;
  bool _biometricAuth = false;
  bool _autoBooking = false;
  bool _ecoMode = true;
  String _language = 'English';
  String _currency = 'INR';
  double _maxDistance = 10.0;
  double _maxPrice = 0.50;

  final List<String> _languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese'
  ];
  final List<String> _currencies = ['INR', 'USD', 'EUR', 'GBP', 'AED'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            _buildProfileSection(),
            const SizedBox(height: AppConstants.lg),

            // Preferences Section
            _buildPreferencesSection(),
            const SizedBox(height: AppConstants.lg),

            // Charging Preferences
            _buildChargingPreferences(),
            const SizedBox(height: AppConstants.lg),

            // Notifications
            _buildNotificationsSection(),
            const SizedBox(height: AppConstants.lg),

            // Privacy & Security
            _buildPrivacySecuritySection(),
            const SizedBox(height: AppConstants.lg),

            // App Settings
            _buildAppSettingsSection(),
            const SizedBox(height: AppConstants.lg),

            // Support & About
            _buildSupportAboutSection(),
            const SizedBox(height: AppConstants.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary.withOpacity(0.1),
            AppTheme.secondary.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppTheme.primary,
            child: const Icon(
              Icons.person,
              size: 40,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: AppConstants.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thomas Mathew',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.xs),
                Text(
                  'thomas.mathew@example.com',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.secondary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Premium Member',
                    style: GoogleFonts.inter(
                      color: AppTheme.secondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              // Edit profile
            },
            icon: const Icon(Icons.edit),
            color: AppTheme.primary,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildPreferencesSection() {
    return _buildSection(
      'Preferences',
      Icons.settings,
      [
        _buildSettingTile(
          'Language',
          _language,
          Icons.language,
          () => _showLanguageDialog(),
        ),
        _buildSettingTile(
          'Currency',
          _currency,
          Icons.attach_money,
          () => _showCurrencyDialog(),
        ),
        _buildSwitchTile(
          'Dark Mode',
          'Use dark theme',
          Icons.dark_mode,
          _darkMode,
          (value) => setState(() => _darkMode = value),
        ),
        _buildSwitchTile(
          'Biometric Authentication',
          'Use fingerprint or face ID',
          Icons.fingerprint,
          _biometricAuth,
          (value) => setState(() => _biometricAuth = value),
        ),
      ],
    );
  }

  Widget _buildChargingPreferences() {
    return _buildSection(
      'Charging Preferences',
      Icons.ev_station,
      [
        _buildSliderTile(
          'Maximum Distance',
          '${_maxDistance.toStringAsFixed(1)} km',
          Icons.location_on,
          _maxDistance,
          1.0,
          50.0,
          (value) => setState(() => _maxDistance = value),
        ),
        _buildSliderTile(
          'Maximum Price',
          '₹${_maxPrice.toStringAsFixed(2)}/kWh',
          Icons.attach_money,
          _maxPrice,
          0.10,
          1.00,
          (value) => setState(() => _maxPrice = value),
        ),
        _buildSwitchTile(
          'Auto Booking',
          'Automatically book available chargers',
          Icons.auto_awesome,
          _autoBooking,
          (value) => setState(() => _autoBooking = value),
        ),
        _buildSwitchTile(
          'Eco Mode',
          'Prefer green energy sources',
          Icons.eco,
          _ecoMode,
          (value) => setState(() => _ecoMode = value),
        ),
      ],
    );
  }

  Widget _buildNotificationsSection() {
    return _buildSection(
      'Notifications',
      Icons.notifications,
      [
        _buildSwitchTile(
          'Push Notifications',
          'Receive push notifications',
          Icons.notifications_active,
          _notificationsEnabled,
          (value) => setState(() => _notificationsEnabled = value),
        ),
        _buildSwitchTile(
          'Booking Reminders',
          'Remind me before bookings',
          Icons.alarm,
          _notificationsEnabled,
          (value) {},
        ),
        _buildSwitchTile(
          'New Chargers',
          'Notify about new chargers nearby',
          Icons.add_location,
          _notificationsEnabled,
          (value) {},
        ),
        _buildSwitchTile(
          'Price Alerts',
          'Alert when prices change',
          Icons.trending_up,
          _notificationsEnabled,
          (value) {},
        ),
      ],
    );
  }

  Widget _buildPrivacySecuritySection() {
    return _buildSection(
      'Privacy & Security',
      Icons.security,
      [
        _buildSettingTile(
          'Change Password',
          '',
          Icons.lock,
          () {},
        ),
        _buildSettingTile(
          'Two-Factor Authentication',
          'Enabled',
          Icons.verified_user,
          () {},
        ),
        _buildSwitchTile(
          'Location Services',
          'Allow location access',
          Icons.location_on,
          _locationServices,
          (value) => setState(() => _locationServices = value),
        ),
        _buildSettingTile(
          'Privacy Policy',
          '',
          Icons.privacy_tip,
          () {},
        ),
        _buildSettingTile(
          'Terms of Service',
          '',
          Icons.description,
          () {},
        ),
      ],
    );
  }

  Widget _buildAppSettingsSection() {
    return _buildSection(
      'App Settings',
      Icons.app_settings_alt,
      [
        _buildSettingTile(
          'App Version',
          '1.0.0',
          Icons.info,
          () {},
        ),
        _buildSettingTile(
          'Clear Cache',
          '23.5 MB',
          Icons.cleaning_services,
          () => _showClearCacheDialog(),
        ),
        _buildSettingTile(
          'Export Data',
          '',
          Icons.download,
          () {},
        ),
        _buildSettingTile(
          'Reset Settings',
          '',
          Icons.restore,
          () => _showResetDialog(),
        ),
      ],
    );
  }

  Widget _buildSupportAboutSection() {
    return _buildSection(
      'Support & About',
      Icons.help,
      [
        _buildSettingTile(
          'Help Center',
          '',
          Icons.help_center,
          () {},
        ),
        _buildSettingTile(
          'Contact Support',
          '',
          Icons.support_agent,
          () {},
        ),
        _buildSettingTile(
          'Rate App',
          '',
          Icons.star,
          () {},
        ),
        _buildSettingTile(
          'Share App',
          '',
          Icons.share,
          () {},
        ),
        _buildSettingTile(
          'About',
          '',
          Icons.info,
          () {},
        ),
      ],
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Row(
              children: [
                Icon(icon, color: AppTheme.primary, size: 24),
                const SizedBox(width: AppConstants.sm),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildSettingTile(
      String title, String subtitle, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: GoogleFonts.inter(
                color: AppTheme.textSecondary,
              ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppTheme.neutral400),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, IconData icon,
      bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppTheme.primary, size: 20),
      ),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          color: AppTheme.textPrimary,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.inter(
          color: AppTheme.textSecondary,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primary,
      ),
    );
  }

  Widget _buildSliderTile(
      String title,
      String value,
      IconData icon,
      double sliderValue,
      double min,
      double max,
      ValueChanged<double> onChanged) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppTheme.primary, size: 20),
          ),
          title: Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          subtitle: Text(
            value,
            style: GoogleFonts.inter(
              color: AppTheme.textSecondary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.lg),
          child: Slider(
            value: sliderValue,
            min: min,
            max: max,
            divisions: ((max - min) * 10).round(),
            onChanged: onChanged,
            activeColor: AppTheme.primary,
          ),
        ),
      ],
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _languages.map((language) {
            return ListTile(
              title: Text(language),
              trailing: _language == language
                  ? const Icon(Icons.check, color: AppTheme.primary)
                  : null,
              onTap: () {
                setState(() => _language = language);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCurrencyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Currency'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: _currencies.map((currency) {
            return ListTile(
              title: Text(currency),
              trailing: _currency == currency
                  ? const Icon(Icons.check, color: AppTheme.primary)
                  : null,
              onTap: () {
                setState(() => _currency = currency);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showClearCacheDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Cache'),
        content: const Text(
            'Are you sure you want to clear the app cache? This will free up 23.5 MB of storage.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache cleared successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _showResetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Settings'),
        content: const Text(
            'Are you sure you want to reset all settings to their default values?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _notificationsEnabled = true;
                _locationServices = true;
                _darkMode = false;
                _biometricAuth = false;
                _autoBooking = false;
                _ecoMode = true;
                _language = 'English';
                _currency = 'INR';
                _maxDistance = 10.0;
                _maxPrice = 0.50;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settings reset successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
