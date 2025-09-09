import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/charger_details_sheet.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_bottom_sheet.dart';

class InteractiveMapScreen extends StatefulWidget {
  const InteractiveMapScreen({super.key});

  @override
  State<InteractiveMapScreen> createState() => _InteractiveMapScreenState();
}

class _InteractiveMapScreenState extends State<InteractiveMapScreen> {
  bool _isLoadingLocation = false;
  Position? _currentPosition;
  Map<String, dynamic>? _selectedCharger;

  // Kerala center coordinates (Kochi)
  static const double KERALA_LAT = 9.9312;
  static const double KERALA_LNG = 76.2673;

  final List<Map<String, dynamic>> _chargers = [
    {
      'id': '1',
      'name': 'Tesla Supercharger - Kochi',
      'address': 'Marine Drive, Ernakulam, Kochi, Kerala',
      'lat': 9.9312,
      'lng': 76.2673,
      'isAvailable': true,
      'power': '250 kW',
      'price': '₹35/kWh',
      'distance': '0.3 km',
      'rating': 4.9,
      'reviews': 342,
      'type': 'DC Fast',
      'connectors': ['Tesla Supercharger'],
      'amenities': ['Restaurant', 'Coffee Shop', 'WiFi', 'Restrooms'],
      'hours': '24/7',
      'host': 'Tesla Inc.',
      'lastUpdated': '2 hours ago',
      'waitTime': '5 min',
      'chargingSpeed': 'Very Fast',
      'reliability': 98,
    },
    {
      'id': '2',
      'name': 'Electrify India Hub',
      'address': 'Lulu Mall, Edappally, Kochi, Kerala',
      'lat': 10.0273,
      'lng': 76.3080,
      'isAvailable': false,
      'power': '150 kW',
      'price': '₹28/kWh',
      'distance': '0.8 km',
      'rating': 4.6,
      'reviews': 189,
      'type': 'DC Fast',
      'connectors': ['CCS', 'CHAdeMO'],
      'amenities': ['Shopping Mall', 'Food Court', 'WiFi'],
      'hours': '6 AM - 10 PM',
      'host': 'Electrify India',
      'lastUpdated': '15 min ago',
      'waitTime': '20 min',
      'chargingSpeed': 'Fast',
      'reliability': 95,
    },
    {
      'id': '3',
      'name': 'Home Charger - Thomas Residence',
      'address': 'Panampilly Nagar, Ernakulam, Kochi, Kerala',
      'lat': 9.9455,
      'lng': 76.2850,
      'isAvailable': true,
      'power': '22 kW',
      'price': '₹18/kWh',
      'distance': '1.2 km',
      'rating': 4.8,
      'reviews': 67,
      'type': 'AC',
      'connectors': ['Type 2'],
      'amenities': ['Home Access', 'Safe Neighborhood', 'Parking'],
      'hours': '7 AM - 9 PM',
      'host': 'Thomas Mathew',
      'lastUpdated': '1 hour ago',
      'waitTime': '0 min',
      'chargingSpeed': 'Medium',
      'reliability': 92,
    },
    {
      'id': '4',
      'name': 'ChargePoint Express',
      'address': 'Infopark, Kakkanad, Kochi, Kerala',
      'lat': 10.0168,
      'lng': 76.3618,
      'isAvailable': true,
      'power': '100 kW',
      'price': '₹32/kWh',
      'distance': '1.5 km',
      'rating': 4.7,
      'reviews': 234,
      'type': 'DC Fast',
      'connectors': ['CCS', 'Type 2'],
      'amenities': ['Tech Park', 'Cafeteria', 'WiFi', 'Security'],
      'hours': '10 AM - 9 PM',
      'host': 'ChargePoint',
      'lastUpdated': '30 min ago',
      'waitTime': '10 min',
      'chargingSpeed': 'Fast',
      'reliability': 96,
    },
    {
      'id': '5',
      'name': 'EV Station - Fort Kochi',
      'address': 'Fort Kochi Beach, Kochi, Kerala',
      'lat': 9.9685,
      'lng': 76.2458,
      'isAvailable': true,
      'power': '50 kW',
      'price': '₹25/kWh',
      'distance': '2.1 km',
      'rating': 4.5,
      'reviews': 156,
      'type': 'DC Fast',
      'connectors': ['CCS', 'Type 2'],
      'amenities': ['Beach View', 'Tourist Area', 'Parking'],
      'hours': '8 AM - 8 PM',
      'host': 'Kerala Tourism',
      'lastUpdated': '45 min ago',
      'waitTime': '15 min',
      'chargingSpeed': 'Medium',
      'reliability': 88,
    },
    {
      'id': '6',
      'name': 'Smart Charger - MG Road',
      'address': 'MG Road, Ernakulam, Kochi, Kerala',
      'lat': 9.9815,
      'lng': 76.2999,
      'isAvailable': false,
      'power': '75 kW',
      'price': '₹30/kWh',
      'distance': '2.8 km',
      'rating': 4.4,
      'reviews': 98,
      'type': 'DC Fast',
      'connectors': ['CCS'],
      'amenities': ['Shopping District', 'Restaurants', 'Parking'],
      'hours': '9 AM - 11 PM',
      'host': 'Smart EV Solutions',
      'lastUpdated': '5 min ago',
      'waitTime': '25 min',
      'chargingSpeed': 'Fast',
      'reliability': 90,
    },
    {
      'id': '7',
      'name': 'Community Charger - Kadavanthra',
      'address': 'Kadavanthra Junction, Ernakulam, Kochi, Kerala',
      'lat': 9.9568,
      'lng': 76.2855,
      'isAvailable': true,
      'power': '22 kW',
      'price': '₹20/kWh',
      'distance': '3.2 km',
      'rating': 4.6,
      'reviews': 78,
      'type': 'AC',
      'connectors': ['Type 2'],
      'amenities': ['Residential Area', 'Local Shops', 'Safe Parking'],
      'hours': '6 AM - 10 PM',
      'host': 'Community EV Group',
      'lastUpdated': '2 hours ago',
      'waitTime': '0 min',
      'chargingSpeed': 'Medium',
      'reliability': 85,
    },
    {
      'id': '8',
      'name': 'Premium Charger - Oberon Mall',
      'address': 'Oberon Mall, Edappally, Kochi, Kerala',
      'lat': 10.0234,
      'lng': 76.3120,
      'isAvailable': true,
      'power': '150 kW',
      'price': '₹40/kWh',
      'distance': '3.5 km',
      'rating': 4.8,
      'reviews': 203,
      'type': 'DC Fast',
      'connectors': ['CCS', 'CHAdeMO', 'Type 2'],
      'amenities': ['Premium Mall', 'Fine Dining', 'Valet Parking', 'WiFi'],
      'hours': '10 AM - 10 PM',
      'host': 'Premium EV Network',
      'lastUpdated': '1 hour ago',
      'waitTime': '8 min',
      'chargingSpeed': 'Very Fast',
      'reliability': 97,
    },
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoadingLocation = true;
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied');
      }

      Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = position;
        _isLoadingLocation = false;
      });
    } catch (e) {
      print('Error getting location: $e');
      setState(() {
        _isLoadingLocation = false;
      });
    }
  }

  void _showChargerDetails(Map<String, dynamic> charger) {
    setState(() {
      _selectedCharger = charger;
    });
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChargerDetailsSheet(charger: charger),
    );
  }

  void _showFilters() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Custom Map Background
          _buildMapBackground(),

          // Top Section
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + AppConstants.md,
                left: AppConstants.md,
                right: AppConstants.md,
                bottom: AppConstants.md,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Header
                  _buildHeader(),
                  const SizedBox(height: AppConstants.md),

                  // Search Bar
                  SearchBarWidget(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Search feature coming soon!'),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: AppConstants.md),

                  // Filter Chips
                  _buildFilterChips(),
                ],
              ),
            ),
          ),

          // Bottom Section
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomSection(),
          ),

          // Location Loading Indicator
          if (_isLoadingLocation)
            Positioned(
              top: MediaQuery.of(context).padding.top + 100,
              right: AppConstants.md,
              child: Container(
                padding: const EdgeInsets.all(AppConstants.sm),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'location',
            onPressed: _getCurrentLocation,
            backgroundColor: Colors.white,
            mini: true,
            child: const Icon(
              Icons.my_location,
              color: AppTheme.primary,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
          FloatingActionButton(
            heroTag: 'filters',
            onPressed: _showFilters,
            backgroundColor: AppTheme.primary,
            mini: true,
            child: const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primary.withOpacity(0.1),
            AppTheme.secondary.withOpacity(0.1),
            Colors.blue.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Map Grid Pattern
          CustomPaint(
            painter: MapGridPainter(),
            size: Size.infinite,
          ),

          // Map Title
          Positioned(
            top: 100,
            left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                'Kerala EV Charging Network',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
          ),

          // Charger Markers
          ..._chargers.map((charger) => _buildChargerMarker(charger)),

          // Current Location Marker
          if (_currentPosition != null) _buildCurrentLocationMarker(),
        ],
      ),
    );
  }

  Widget _buildChargerMarker(Map<String, dynamic> charger) {
    // Calculate position based on coordinates (improved positioning)
    final lat = charger['lat'] as double;
    final lng = charger['lng'] as double;

    // Convert to screen coordinates (better scaling)
    final screenX = ((lng - KERALA_LNG) * 200) + 150;
    final screenY = ((KERALA_LAT - lat) * 200) + 200;

    return Positioned(
      left: screenX,
      top: screenY,
      child: GestureDetector(
        onTap: () => _showChargerDetails(charger),
        child: Column(
          children: [
            // Charger Icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color:
                    charger['isAvailable'] ? AppTheme.success : AppTheme.error,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                Icons.ev_station,
                size: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            // Charger Name
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                charger['name'].split(' - ').first,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocationMarker() {
    return Positioned(
      left: 150,
      top: 200,
      child: Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppTheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.my_location,
              size: 10,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'You',
              style: GoogleFonts.inter(
                fontSize: 8,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Find Chargers',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${_chargers.length} stations nearby',
                style: GoogleFonts.inter(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(AppConstants.sm),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All', true),
          const SizedBox(width: AppConstants.sm),
          _buildFilterChip('Available', false),
          const SizedBox(width: AppConstants.sm),
          _buildFilterChip('Fast Charging', false),
          const SizedBox(width: AppConstants.sm),
          _buildFilterChip('Free', false),
          const SizedBox(width: AppConstants.sm),
          _buildFilterChip('Nearby', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.md,
        vertical: AppConstants.sm,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.primary : Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    final availableChargers = _chargers.where((c) => c['isAvailable']).length;
    final totalChargers = _chargers.length;

    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: AppConstants.lg),

          // Stats
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  'Available',
                  '$availableChargers/$totalChargers',
                  Icons.check_circle,
                  AppTheme.success,
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: _buildStatCard(
                  'Average Price',
                  '₹28/kWh',
                  Icons.attach_money,
                  AppTheme.warning,
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: _buildStatCard(
                  'Avg Rating',
                  '4.7★',
                  Icons.star,
                  AppTheme.info,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.lg),

          // Recent Chargers
          Row(
            children: [
              Text(
                'Recent Stations',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // Show all chargers
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.md),

          // Charger List
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _chargers.take(5).length,
              itemBuilder: (context, index) {
                final charger = _chargers[index];
                return Container(
                  width: 280,
                  margin: EdgeInsets.only(
                    right: index < 4 ? AppConstants.md : 0,
                  ),
                  child: _buildChargerCard(charger),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: AppConstants.xs),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChargerCard(Map<String, dynamic> charger) {
    return GestureDetector(
      onTap: () => _showChargerDetails(charger),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.md),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: charger['isAvailable']
                ? AppTheme.success.withOpacity(0.3)
                : AppTheme.error.withOpacity(0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    charger['name'],
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: charger['isAvailable']
                        ? AppTheme.success.withOpacity(0.2)
                        : AppTheme.error.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    charger['isAvailable'] ? 'Available' : 'Busy',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: charger['isAvailable']
                          ? AppTheme.success
                          : AppTheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.xs),
            Text(
              charger['address'],
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppTheme.textSecondary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: AppConstants.xs),
            Row(
              children: [
                Icon(
                  Icons.bolt,
                  size: 12,
                  color: AppTheme.warning,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    charger['power'],
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: AppConstants.sm),
                Icon(
                  Icons.attach_money,
                  size: 12,
                  color: AppTheme.warning,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    charger['price'],
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 0.5;

    // Draw vertical lines
    for (double x = 0; x < size.width; x += 50) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal lines
    for (double y = 0; y < size.height; y += 50) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
