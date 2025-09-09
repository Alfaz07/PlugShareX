import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../widgets/charger_card.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/filter_bottom_sheet.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final List<Map<String, dynamic>> _chargers = [
    {
      'id': '1',
      'name': 'Tesla Supercharger - Kochi',
      'address': 'Marine Drive, Ernakulam, Kochi, Kerala',
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
      'name': 'Workplace Charger - Technopark',
      'address': 'Technopark Phase 1, Trivandrum, Kerala',
      'isAvailable': true,
      'power': '11 kW',
      'price': '₹15/kWh',
      'distance': '2.1 km',
      'rating': 4.5,
      'reviews': 89,
      'type': 'AC',
      'connectors': ['Type 2'],
      'amenities': ['Office Building', 'Cafeteria', 'WiFi', 'Security'],
      'hours': '8 AM - 6 PM',
      'host': 'Technopark Kerala',
      'lastUpdated': '3 hours ago',
      'waitTime': '0 min',
      'chargingSpeed': 'Slow',
      'reliability': 88,
    },
    {
      'id': '6',
      'name': 'EVgo Ultra-Fast Station',
      'address': 'NH66 Highway, Kollam, Kerala',
      'isAvailable': true,
      'power': '350 kW',
      'price': '₹45/kWh',
      'distance': '3.2 km',
      'rating': 4.9,
      'reviews': 156,
      'type': 'DC Ultra-Fast',
      'connectors': ['CCS', 'CHAdeMO'],
      'amenities': ['Petrol Pump', 'Convenience Store', 'Restrooms'],
      'hours': '24/7',
      'host': 'EVgo India',
      'lastUpdated': '5 min ago',
      'waitTime': '0 min',
      'chargingSpeed': 'Ultra Fast',
      'reliability': 99,
    },
    {
      'id': '7',
      'name': 'Green Energy Community Hub',
      'address': 'Kovalam Beach Road, Trivandrum, Kerala',
      'isAvailable': false,
      'power': '50 kW',
      'price': '₹20/kWh',
      'distance': '4.0 km',
      'rating': 4.8,
      'reviews': 123,
      'type': 'DC Fast',
      'connectors': ['CCS', 'Type 2'],
      'amenities': ['Solar Panels', 'Beach View', 'WiFi', 'Cafe'],
      'hours': '6 AM - 11 PM',
      'host': 'Green Energy Kerala',
      'lastUpdated': '45 min ago',
      'waitTime': '15 min',
      'chargingSpeed': 'Medium',
      'reliability': 94,
    },
    {
      'id': '8',
      'name': 'Premium Hotel Charger',
      'address': 'Taj Malabar, Willingdon Island, Kochi, Kerala',
      'isAvailable': true,
      'power': '22 kW',
      'price': '₹25/kWh',
      'distance': '2.8 km',
      'rating': 4.6,
      'reviews': 78,
      'type': 'AC',
      'connectors': ['Type 2'],
      'amenities': ['Luxury Hotel', 'Valet Parking', 'WiFi', 'Restaurant'],
      'hours': '24/7',
      'host': 'Taj Hotels',
      'lastUpdated': '2 hours ago',
      'waitTime': '0 min',
      'chargingSpeed': 'Medium',
      'reliability': 90,
    },
  ];

  String _selectedFilter = 'All';
  bool _showMap = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Map Placeholder
          if (_showMap) _buildMapPlaceholder(),

          // Top Section
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.lg),
              child: Column(
                children: [
                  // Header
                  _buildHeader(),
                  const SizedBox(height: AppConstants.md),

                  // Search Bar
                  SearchBarWidget(
                    onTap: () {
                      // Handle search tap
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _showMap = !_showMap;
          });
        },
        backgroundColor: AppTheme.primary,
        child: Icon(
          _showMap ? Icons.list : Icons.map,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMapPlaceholder() {
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
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map,
              size: 80,
              color: AppTheme.primary.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'Interactive Map',
              style: GoogleFonts.inter(
                color: AppTheme.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time charger locations',
              style: GoogleFonts.inter(
                color: AppTheme.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
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
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '${_chargers.length} chargers nearby',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            _showFilterBottomSheet();
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.filter_list,
              color: AppTheme.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    final filters = ['All', 'Available', 'Fast Charging', 'Free'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;

          return Container(
            margin: EdgeInsets.only(
                right: index < filters.length - 1 ? AppConstants.sm : 0),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedFilter = filter;
                });
              },
              backgroundColor: Colors.transparent,
              selectedColor: AppTheme.primary.withOpacity(0.2),
              labelStyle: GoogleFonts.inter(
                color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.primary : AppTheme.neutral300,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBottomSection() {
    final availableChargers = _chargers.where((c) => c['isAvailable']).length;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppConstants.radiusXl),
          topRight: Radius.circular(AppConstants.radiusXl),
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
            margin: const EdgeInsets.only(top: AppConstants.md),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.neutral300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Column(
              children: [
                // Stats Row
                Row(
                  children: [
                    _buildStatCard('Available', '$availableChargers',
                        Icons.check_circle, Colors.green),
                    const SizedBox(width: AppConstants.md),
                    _buildStatCard('Total', '${_chargers.length}',
                        Icons.ev_station, AppTheme.primary),
                    const SizedBox(width: AppConstants.md),
                    _buildStatCard(
                        'Nearby', '3', Icons.location_on, AppTheme.secondary),
                  ],
                ),

                const SizedBox(height: AppConstants.lg),

                // Chargers List
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: _chargers.length,
                    itemBuilder: (context, index) {
                      final charger = _chargers[index];
                      return ChargerCard(
                        charger: charger,
                        onTap: () {
                          _showChargerDetails(charger);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().slideY(
          begin: 1,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.md),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.inter(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                color: AppTheme.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
  }

  void _showChargerDetails(Map<String, dynamic> charger) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ChargerDetailsSheet(charger: charger),
    );
  }
}

class ChargerDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> charger;

  const ChargerDetailsSheet({super.key, required this.charger});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppConstants.radiusXl),
          topRight: Radius.circular(AppConstants.radiusXl),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: AppConstants.md),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.neutral300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: charger['isAvailable']
                            ? Colors.green.withOpacity(0.1)
                            : Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.ev_station,
                        color:
                            charger['isAvailable'] ? Colors.green : Colors.red,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: AppConstants.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            charger['name'],
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            charger['address'],
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color:
                            charger['isAvailable'] ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        charger['isAvailable'] ? 'Available' : 'Occupied',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.lg),

                // Details
                _buildDetailRow('Power', charger['power'], Icons.bolt),
                _buildDetailRow('Price', charger['price'], Icons.attach_money),
                _buildDetailRow(
                    'Distance', charger['distance'], Icons.location_on),
                _buildDetailRow('Type', charger['type'], Icons.ev_station),
                _buildDetailRow(
                    'Rating',
                    '${charger['rating']} (${charger['reviews']} reviews)',
                    Icons.star),
                _buildDetailRow('Host', charger['host'], Icons.person),
                _buildDetailRow('Hours', charger['hours'], Icons.schedule),
                _buildDetailRow('Wait Time', charger['waitTime'], Icons.timer),
                _buildDetailRow('Speed', charger['chargingSpeed'], Icons.speed),
                _buildDetailRow('Reliability', '${charger['reliability']}%',
                    Icons.verified),

                const SizedBox(height: AppConstants.lg),

                // Connectors
                Text(
                  'Connectors',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Wrap(
                  spacing: AppConstants.sm,
                  children:
                      (charger['connectors'] as List<String>).map((connector) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.primary.withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        connector,
                        style: GoogleFonts.inter(
                          color: AppTheme.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppConstants.lg),

                // Amenities
                Text(
                  'Amenities',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Wrap(
                  spacing: AppConstants.sm,
                  children:
                      (charger['amenities'] as List<String>).map((amenity) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.sm,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.secondary.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getAmenityIcon(amenity),
                            size: 14,
                            color: AppTheme.secondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            amenity,
                            style: GoogleFonts.inter(
                              color: AppTheme.secondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppConstants.lg),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.directions),
                        label: const Text('Directions'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.md),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.md),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: charger['isAvailable']
                            ? () {
                                // Handle booking
                                Navigator.pop(context);
                              }
                            : null,
                        icon: const Icon(Icons.book_online),
                        label: const Text('Book Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.md),
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
    ).animate().slideY(
          begin: 1,
          end: 0,
          duration: 400.ms,
          curve: Curves.easeOutCubic,
        );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.sm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.textSecondary),
          const SizedBox(width: AppConstants.sm),
          Text(
            '$label:',
            style: GoogleFonts.inter(
              color: AppTheme.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(width: AppConstants.sm),
          Text(
            value,
            style: GoogleFonts.inter(
              color: AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'restaurant':
        return Icons.restaurant;
      case 'coffee shop':
        return Icons.coffee;
      case 'wifi':
        return Icons.wifi;
      case 'restrooms':
        return Icons.wc;
      case 'shopping center':
      case 'shopping mall':
        return Icons.shopping_cart;
      case 'food court':
        return Icons.fastfood;
      case 'security':
        return Icons.security;
      case 'home access':
        return Icons.home;
      case 'safe neighborhood':
        return Icons.safety_divider;
      case 'parking':
        return Icons.local_parking;
      case 'office building':
        return Icons.business;
      case 'cafeteria':
        return Icons.restaurant_menu;
      case 'gas station':
        return Icons.local_gas_station;
      case 'convenience store':
        return Icons.store;
      case 'solar panels':
        return Icons.solar_power;
      case 'green space':
        return Icons.park;
      case 'cafe':
        return Icons.local_cafe;
      case 'hotel':
        return Icons.hotel;
      case 'valet parking':
        return Icons.directions_car;
      default:
        return Icons.star;
    }
  }
}
