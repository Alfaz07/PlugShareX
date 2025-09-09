import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../navigation/presentation/screens/main_navigation.dart';
import '../providers/auth_provider.dart';
import '../providers/user_profile_provider.dart';
import '../../data/models/user_profile_model.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  final String email;
  final String password;

  const RegistrationScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _bioController = TextEditingController();
  final _vehicleMakeController = TextEditingController();
  final _vehicleModelController = TextEditingController();
  final _vehicleYearController = TextEditingController();
  final _batteryCapacityController = TextEditingController();
  final _maxChargingRateController = TextEditingController();
  final _maxPriceController = TextEditingController();

  // Security Questions Controllers
  final _securityQuestion1Controller = TextEditingController();
  final _securityQuestion2Controller = TextEditingController();
  final _securityQuestion3Controller = TextEditingController();
  final _securityAnswer1Controller = TextEditingController();
  final _securityAnswer2Controller = TextEditingController();
  final _securityAnswer3Controller = TextEditingController();

  int _currentStep = 0;
  String? _selectedVehicleType;
  String? _selectedChargerType;
  String? _selectedPreferredBrands;
  String? _selectedGender;
  DateTime? _selectedDateOfBirth;
  bool _isHost = false;
  bool _preferFastCharging = true;
  bool _preferHomeChargers = true;
  String? _profilePictureUrl;

  final List<String> _vehicleTypes = [
    'Tesla Model S',
    'Tesla Model 3',
    'Tesla Model X',
    'Tesla Model Y',
    'Nissan Leaf',
    'Chevrolet Bolt',
    'BMW i3',
    'Audi e-tron',
    'Porsche Taycan',
    'Ford Mustang Mach-E',
    'Volkswagen ID.4',
    'Hyundai Kona Electric',
    'Kia Niro EV',
    'Rivian R1T',
    'Rivian R1S',
    'Lucid Air',
    'Other',
  ];

  final List<String> _chargerTypes = [
    'Type 1 (J1772)',
    'Type 2 (Mennekes)',
    'CCS (Combined Charging System)',
    'CHAdeMO',
    'Tesla Supercharger',
    'Tesla Destination Charger',
    'Any Type',
  ];

  final List<String> _preferredBrands = [
    'Tesla',
    'ChargePoint',
    'Electrify America',
    'EVgo',
    'Blink',
    'Greenlots',
    'Any Brand',
  ];

  final List<String> _genderOptions = [
    'Male',
    'Female',
    'Non-binary',
    'Prefer not to say',
  ];

  // Security Questions Options
  final List<String> _securityQuestions = [
    'What was the name of your first pet?',
    'In what city were you born?',
    'What was your mother\'s maiden name?',
    'What was the name of your first school?',
    'What was your childhood nickname?',
    'What is your favorite book?',
    'What was the make of your first car?',
    'What is your favorite movie?',
    'What is the name of the street you grew up on?',
    'What is your favorite food?',
    'What was the name of your first teacher?',
    'What is your favorite color?',
    'What is the name of your favorite childhood friend?',
    'What was your first job?',
    'What is your favorite holiday destination?',
  ];

  String? _selectedSecurityQuestion1;
  String? _selectedSecurityQuestion2;
  String? _selectedSecurityQuestion3;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _bioController.dispose();
    _vehicleMakeController.dispose();
    _vehicleModelController.dispose();
    _vehicleYearController.dispose();
    _batteryCapacityController.dispose();
    _maxChargingRateController.dispose();
    _maxPriceController.dispose();

    // Security Questions Controllers
    _securityQuestion1Controller.dispose();
    _securityQuestion2Controller.dispose();
    _securityQuestion3Controller.dispose();
    _securityAnswer1Controller.dispose();
    _securityAnswer2Controller.dispose();
    _securityAnswer3Controller.dispose();

    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 7) {
      // Increased from 5 to 7 to include security questions
      setState(() {
        _currentStep++;
      });
    } else {
      _completeRegistration();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
      firstDate:
          DateTime.now().subtract(const Duration(days: 36500)), // 100 years ago
      lastDate:
          DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
    );
    if (picked != null && picked != _selectedDateOfBirth) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  Future<void> _pickProfilePicture() async {
    // TODO: Implement image picker
    // For now, just show a placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile picture upload coming soon!'),
        backgroundColor: AppTheme.secondary,
      ),
    );
  }

  Future<void> _completeRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Create user account
      await ref
          .read(authStateNotifierProvider.notifier)
          .createUserWithEmailAndPassword(
            widget.email,
            widget.password,
          );

      // Create security questions map
      final Map<String, String> securityQuestions = {};
      if (_selectedSecurityQuestion1 != null &&
          _securityAnswer1Controller.text.isNotEmpty) {
        securityQuestions[_selectedSecurityQuestion1!] =
            _securityAnswer1Controller.text;
      }
      if (_selectedSecurityQuestion2 != null &&
          _securityAnswer2Controller.text.isNotEmpty) {
        securityQuestions[_selectedSecurityQuestion2!] =
            _securityAnswer2Controller.text;
      }
      if (_selectedSecurityQuestion3 != null &&
          _securityAnswer3Controller.text.isNotEmpty) {
        securityQuestions[_selectedSecurityQuestion3!] =
            _securityAnswer3Controller.text;
      }

      // Create user profile with collected data
      final userProfile = UserProfile(
        id: ref.read(authStateNotifierProvider).value?.uid ?? '',
        email: widget.email,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        phoneNumber:
            _phoneController.text.isNotEmpty ? _phoneController.text : null,
        photoURL: _profilePictureUrl,
        address:
            _addressController.text.isNotEmpty ? _addressController.text : null,
        bio: _bioController.text.isNotEmpty ? _bioController.text : null,
        dateOfBirth: _selectedDateOfBirth,
        gender: _selectedGender,
        vehicle: _selectedVehicleType != null
            ? VehicleInfo(
                type: _selectedVehicleType!,
                make: _selectedVehicleType == 'Other'
                    ? _vehicleMakeController.text
                    : null,
                model: _selectedVehicleType == 'Other'
                    ? _vehicleModelController.text
                    : null,
                year: _selectedVehicleType == 'Other'
                    ? _vehicleYearController.text
                    : null,
                batteryCapacity: _batteryCapacityController.text.isNotEmpty
                    ? _batteryCapacityController.text
                    : null,
                maxChargingRate: _maxChargingRateController.text.isNotEmpty
                    ? _maxChargingRateController.text
                    : null,
              )
            : null,
        chargerPreferences: _selectedChargerType != null
            ? ChargerPreferences(
                preferredType: _selectedChargerType!,
                maxPricePerKwh: _maxPriceController.text.isNotEmpty
                    ? double.tryParse(_maxPriceController.text)
                    : null,
                preferFastCharging: _preferFastCharging,
                preferHomeChargers: _preferHomeChargers,
                preferredBrands: _selectedPreferredBrands != null
                    ? [_selectedPreferredBrands!]
                    : [],
              )
            : null,
        isHost: _isHost,
        securityQuestions:
            securityQuestions.isNotEmpty ? securityQuestions : null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Update user profile with collected data
      await ref.read(authStateNotifierProvider.notifier).updateProfile(
            displayName: userProfile.fullName,
            photoURL: _profilePictureUrl,
          );

      // Store user profile in provider
      ref.read(userProfileStateProvider.notifier).setUserProfile(userProfile);

      // TODO: Save user profile to database
      // For now, we'll just print it to console
      print('User Profile Created: ${userProfile.toJson()}');

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration successful! Welcome to PlugShareX!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigation is now handled by the main app router
      // No need to manually navigate
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
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: ${e.toString()}'),
          backgroundColor: AppTheme.error,
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
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(AppConstants.lg),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: AppConstants.md),
                    Expanded(
                      child: Text(
                        'Complete Your Profile',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '${_currentStep + 1}/8',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Progress indicator
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppConstants.lg),
                child: Row(
                  children: List.generate(8, (index) {
                    return Expanded(
                      child: Container(
                        height: 4,
                        margin: EdgeInsets.only(
                          right: index < 7 ? AppConstants.sm : 0,
                        ),
                        decoration: BoxDecoration(
                          color: index <= _currentStep
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: AppConstants.lg),

              // Content
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radiusXl),
                      topRight: Radius.circular(AppConstants.radiusXl),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: _buildStepContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildVehicleInfoStep();
      case 2:
        return _buildChargerPreferencesStep();
      case 3:
        return _buildHostingStep();
      case 4:
        return _buildSecurityQuestionsStep();
      case 5:
        return _buildSecurityQuestionsStep2();
      case 6:
        return _buildSecurityQuestionsStep3();
      case 7:
        return _buildFinalStep();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPersonalInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Tell us about yourself to personalize your experience',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Profile Picture
          Center(
            child: GestureDetector(
              onTap: _pickProfilePicture,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.primary.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: _profilePictureUrl != null
                    ? ClipOval(
                        child: Image.network(
                          _profilePictureUrl!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt,
                            color: AppTheme.primary,
                            size: 32,
                          ),
                          const SizedBox(height: AppConstants.xs),
                          Text(
                            'Add Photo',
                            style: GoogleFonts.inter(
                              color: AppTheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.lg),

          // First Name
          TextFormField(
            controller: _firstNameController,
            decoration: InputDecoration(
              labelText: 'First Name',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your first name';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.md),

          // Last Name
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: 'Last Name',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your last name';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.md),

          // Phone Number
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: const Icon(Icons.phone_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.md),

          // Address
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              labelText: 'Address (Optional)',
              prefixIcon: const Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: AppConstants.md),

          // Bio
          TextFormField(
            controller: _bioController,
            decoration: InputDecoration(
              labelText: 'Bio (Optional)',
              prefixIcon: const Icon(Icons.edit_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            maxLines: 3,
          ),
          const SizedBox(height: AppConstants.xl),

          // Next Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: AppConstants.md),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
              child: Text(
                'Next',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleInfoStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vehicle Information',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Help us find the perfect chargers for your vehicle',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Vehicle Type Dropdown
          DropdownButtonFormField<String>(
            value: _selectedVehicleType,
            decoration: InputDecoration(
              labelText: 'Vehicle Type',
              prefixIcon: const Icon(Icons.directions_car_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            items: _vehicleTypes.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedVehicleType = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your vehicle type';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.md),

          // Custom Vehicle Fields (if "Other" is selected)
          if (_selectedVehicleType == 'Other') ...[
            TextFormField(
              controller: _vehicleMakeController,
              decoration: InputDecoration(
                labelText: 'Vehicle Make',
                prefixIcon: const Icon(Icons.directions_car_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle make';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.md),
            TextFormField(
              controller: _vehicleModelController,
              decoration: InputDecoration(
                labelText: 'Vehicle Model',
                prefixIcon: const Icon(Icons.directions_car_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle model';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.md),
            TextFormField(
              controller: _vehicleYearController,
              decoration: InputDecoration(
                labelText: 'Vehicle Year',
                prefixIcon: const Icon(Icons.calendar_today_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter vehicle year';
                }
                return null;
              },
            ),
            const SizedBox(height: AppConstants.md),
          ],

          // Battery Capacity
          TextFormField(
            controller: _batteryCapacityController,
            decoration: InputDecoration(
              labelText: 'Battery Capacity (kWh)',
              prefixIcon: const Icon(Icons.battery_charging_full_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppConstants.md),

          // Max Charging Rate
          TextFormField(
            controller: _maxChargingRateController,
            decoration: InputDecoration(
              labelText: 'Max Charging Rate (kW)',
              prefixIcon: const Icon(Icons.speed_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppConstants.xl),

          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChargerPreferencesStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Charger Preferences',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'What type of chargers do you prefer?',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Charger Type Dropdown
          DropdownButtonFormField<String>(
            value: _selectedChargerType,
            decoration: InputDecoration(
              labelText: 'Preferred Charger Type',
              prefixIcon: const Icon(Icons.ev_station_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            items: _chargerTypes.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(type),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedChargerType = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your preferred charger type';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.md),

          // Preferred Brands
          DropdownButtonFormField<String>(
            value: _selectedPreferredBrands,
            decoration: InputDecoration(
              labelText: 'Preferred Charger Brands',
              prefixIcon: const Icon(Icons.branding_watermark_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            items: _preferredBrands.map((brand) {
              return DropdownMenuItem(
                value: brand,
                child: Text(brand),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedPreferredBrands = value;
              });
            },
          ),
          const SizedBox(height: AppConstants.md),

          // Max Price
          TextFormField(
            controller: _maxPriceController,
            decoration: InputDecoration(
              labelText: 'Max Price per kWh (\$)',
              prefixIcon: const Icon(Icons.attach_money_outlined),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: AppConstants.lg),

          // Preferences
          Text(
            'Charging Preferences',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.md),

          SwitchListTile(
            title: Text(
              'Prefer Fast Charging',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Prioritize high-speed chargers',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppTheme.neutral600,
              ),
            ),
            value: _preferFastCharging,
            onChanged: (value) {
              setState(() {
                _preferFastCharging = value;
              });
            },
            activeColor: AppTheme.primary,
          ),

          SwitchListTile(
            title: Text(
              'Prefer Home Chargers',
              style: GoogleFonts.inter(fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              'Show residential chargers first',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppTheme.neutral600,
              ),
            ),
            value: _preferHomeChargers,
            onChanged: (value) {
              setState(() {
                _preferHomeChargers = value;
              });
            },
            activeColor: AppTheme.primary,
          ),

          const SizedBox(height: AppConstants.xl),

          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHostingStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Become a Host',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Share your charger and earn money while helping the community',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Hosting Option Card
          Container(
            padding: const EdgeInsets.all(AppConstants.lg),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
              border: Border.all(
                color: AppTheme.primary.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.home_outlined,
                  size: 48,
                  color: AppTheme.primary,
                ),
                const SizedBox(height: AppConstants.md),
                Text(
                  'Host Your Charger',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Text(
                  'List your home charger and earn money when other EV drivers use it',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.neutral600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.md),
                SwitchListTile(
                  title: Text(
                    'I want to host my charger',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: _isHost,
                  onChanged: (value) {
                    setState(() {
                      _isHost = value;
                    });
                  },
                  activeColor: AppTheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Benefits List
          if (_isHost) ...[
            Text(
              'Benefits of Hosting:',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.neutral900,
              ),
            ),
            const SizedBox(height: AppConstants.md),
            _buildBenefitItem(
                'Earn money from your charger', Icons.attach_money),
            _buildBenefitItem('Help the EV community grow', Icons.people),
            _buildBenefitItem('Flexible availability settings', Icons.schedule),
            _buildBenefitItem('Easy booking management', Icons.manage_accounts),
            _buildBenefitItem('24/7 customer support', Icons.support_agent),
            _buildBenefitItem('Secure payment processing', Icons.security),
            const SizedBox(height: AppConstants.lg),
          ],

          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFinalStep() {
    final isLoading = ref.watch(authLoadingProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Review & Complete',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Review your information before completing registration',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Summary Card
          Container(
            padding: const EdgeInsets.all(AppConstants.lg),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
              border: Border.all(
                color: AppTheme.primary.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Profile Summary',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primary,
                  ),
                ),
                const SizedBox(height: AppConstants.md),
                _buildSummaryItem('Name',
                    '${_firstNameController.text} ${_lastNameController.text}'),
                _buildSummaryItem('Email', widget.email),
                _buildSummaryItem('Phone', _phoneController.text),
                if (_selectedVehicleType != null)
                  _buildSummaryItem('Vehicle', _selectedVehicleType!),
                _buildSummaryItem('Hosting', _isHost ? 'Yes' : 'No'),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Welcome Message
          Container(
            padding: const EdgeInsets.all(AppConstants.lg),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
              border: Border.all(
                color: Colors.green.withOpacity(0.3),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 48,
                  color: Colors.green,
                ),
                const SizedBox(height: AppConstants.md),
                Text(
                  'Welcome to PlugShareX!',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Text(
                  'You\'re all set to start finding and sharing EV chargers. Get ready to explore the electric future!',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.neutral700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Navigation Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Back',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: isLoading ? null : _completeRegistration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(vertical: AppConstants.md),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          'Complete Registration',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.sm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: AppTheme.primary,
          ),
          const SizedBox(width: AppConstants.sm),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.neutral700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.neutral700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.neutral900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Security Questions Steps
  Widget _buildSecurityQuestionsStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security Questions',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Set up security questions to protect your account',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Security Question 1
          Text(
            'Security Question 1',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          DropdownButtonFormField<String>(
            value: _selectedSecurityQuestion1,
            decoration: InputDecoration(
              labelText: 'Select a security question',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            items: _securityQuestions.map((String question) {
              return DropdownMenuItem<String>(
                value: question,
                child: Text(question),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedSecurityQuestion1 = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a security question';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.lg),

          // Security Answer 1
          TextFormField(
            controller: _securityAnswer1Controller,
            decoration: InputDecoration(
              labelText: 'Your Answer',
              hintText: 'Enter your answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your answer';
              }
              if (value.length < 3) {
                return 'Answer must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.xl),

          // Security Question 2
          Text(
            'Security Question 2',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          DropdownButtonFormField<String>(
            value: _selectedSecurityQuestion2,
            decoration: InputDecoration(
              labelText: 'Select a security question',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            items: _securityQuestions.map((String question) {
              return DropdownMenuItem<String>(
                value: question,
                child: Text(question),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedSecurityQuestion2 = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a security question';
              }
              if (value == _selectedSecurityQuestion1) {
                return 'Please select a different question';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.lg),

          // Security Answer 2
          TextFormField(
            controller: _securityAnswer2Controller,
            decoration: InputDecoration(
              labelText: 'Your Answer',
              hintText: 'Enter your answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your answer';
              }
              if (value.length < 3) {
                return 'Answer must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.xl),

          // Navigation buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Previous',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityQuestionsStep2() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Additional Security',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Set up one more security question for enhanced protection',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Security Question 3
          Text(
            'Security Question 3',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          DropdownButtonFormField<String>(
            value: _selectedSecurityQuestion3,
            decoration: InputDecoration(
              labelText: 'Select a security question',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            items: _securityQuestions.map((String question) {
              return DropdownMenuItem<String>(
                value: question,
                child: Text(question),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedSecurityQuestion3 = newValue;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a security question';
              }
              if (value == _selectedSecurityQuestion1 ||
                  value == _selectedSecurityQuestion2) {
                return 'Please select a different question';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.lg),

          // Security Answer 3
          TextFormField(
            controller: _securityAnswer3Controller,
            decoration: InputDecoration(
              labelText: 'Your Answer',
              hintText: 'Enter your answer',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your answer';
              }
              if (value.length < 3) {
                return 'Answer must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: AppConstants.xl),

          // Security Tips
          Container(
            padding: const EdgeInsets.all(AppConstants.md),
            decoration: BoxDecoration(
              color: AppTheme.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: AppTheme.primary.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.security,
                      color: AppTheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: AppConstants.sm),
                    Text(
                      'Security Tips',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.sm),
                Text(
                  '• Choose answers that are easy for you to remember but hard for others to guess\n'
                  '• Avoid using information that can be found on social media\n'
                  '• Use specific details rather than general answers',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: AppTheme.neutral700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Navigation buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Previous',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityQuestionsStep3() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security Verification',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.neutral900,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            'Review your security questions and answers',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppTheme.neutral600,
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Security Questions Summary
          Container(
            padding: const EdgeInsets.all(AppConstants.lg),
            decoration: BoxDecoration(
              color: AppTheme.neutral50,
              borderRadius: BorderRadius.circular(AppConstants.radiusLg),
              border: Border.all(
                color: AppTheme.neutral200,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Security Questions',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.neutral900,
                  ),
                ),
                const SizedBox(height: AppConstants.lg),

                // Question 1
                if (_selectedSecurityQuestion1 != null) ...[
                  _buildSecurityQuestionSummary(
                    'Question 1:',
                    _selectedSecurityQuestion1!,
                    _securityAnswer1Controller.text,
                  ),
                  const SizedBox(height: AppConstants.md),
                ],

                // Question 2
                if (_selectedSecurityQuestion2 != null) ...[
                  _buildSecurityQuestionSummary(
                    'Question 2:',
                    _selectedSecurityQuestion2!,
                    _securityAnswer2Controller.text,
                  ),
                  const SizedBox(height: AppConstants.md),
                ],

                // Question 3
                if (_selectedSecurityQuestion3 != null) ...[
                  _buildSecurityQuestionSummary(
                    'Question 3:',
                    _selectedSecurityQuestion3!,
                    _securityAnswer3Controller.text,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Security Notice
          Container(
            padding: const EdgeInsets.all(AppConstants.md),
            decoration: BoxDecoration(
              color: AppTheme.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              border: Border.all(
                color: AppTheme.secondary.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: AppTheme.secondary,
                  size: 20,
                ),
                const SizedBox(width: AppConstants.sm),
                Expanded(
                  child: Text(
                    'Your security questions will be used for account recovery and verification.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      color: AppTheme.neutral700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppConstants.xl),

          // Navigation buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _previousStep,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Previous',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _nextStep,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      vertical: AppConstants.md,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityQuestionSummary(
      String label, String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.neutral700,
          ),
        ),
        const SizedBox(height: AppConstants.xs),
        Text(
          question,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppTheme.neutral900,
          ),
        ),
        const SizedBox(height: AppConstants.xs),
        Text(
          'Answer: ${answer.isNotEmpty ? answer : 'Not provided'}',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppTheme.neutral600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}
