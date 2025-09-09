import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';

class SimpleMapScreen extends StatefulWidget {
  const SimpleMapScreen({super.key});

  @override
  State<SimpleMapScreen> createState() => _SimpleMapScreenState();
}

class _SimpleMapScreenState extends State<SimpleMapScreen> {
  // Mock charger data
  final List<Map<String, dynamic>> _chargers = [
    {
      'id': '1',
      'name': 'HyperCharge Station',
      'isAvailable': true,
      'power': '150 kW',
      'price': '\$0.22/kWh',
      'distance': '0.5 km',
    },
    {
      'id': '2',
      'name': 'EcoCharge Hub',
      'isAvailable': false,
      'power': '100 kW',
      'price': '\$0.25/kWh',
      'distance': '1.2 km',
    },
    {
      'id': '3',
      'name': 'FastCharge Point',
      'isAvailable': true,
      'power': '200 kW',
      'price': '\$0.30/kWh',
      'distance': '2.1 km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Map Placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.background,
                  AppTheme.background.withOpacity(0.8),
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
                    'Map View',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Interactive map coming soon',
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Top App Bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.lg),
              child: Row(
                children: [
                  // Back Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  const SizedBox(width: AppConstants.md),

                  // Search Bar
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search for chargers...',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                          ),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: AppConstants.md),

                  // Filter Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.filter_list, color: Colors.white),
                      onPressed: () {
                        // Show filter options
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Sheet with Charger Info
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.all(AppConstants.lg),
              padding: const EdgeInsets.all(AppConstants.lg),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Handle
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),

                  const SizedBox(height: AppConstants.md),

                  // Charger Stats
                  Row(
                    children: [
                      _buildStatCard(
                        'Available',
                        '${_chargers.where((c) => c['isAvailable'] == true).length}',
                        Icons.check_circle,
                        Colors.green,
                      ),
                      const SizedBox(width: AppConstants.md),
                      _buildStatCard(
                        'Total',
                        '${_chargers.length}',
                        Icons.ev_station,
                        AppTheme.primary,
                      ),
                      const SizedBox(width: AppConstants.md),
                      _buildStatCard(
                        'Nearby',
                        '3',
                        Icons.location_on,
                        AppTheme.secondary,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppConstants.md),

                  // Charger List
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _chargers.length,
                      itemBuilder: (context, index) {
                        final charger = _chargers[index];
                        return Container(
                          margin:
                              const EdgeInsets.only(bottom: AppConstants.sm),
                          padding: const EdgeInsets.all(AppConstants.md),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: charger['isAvailable']
                                      ? Colors.green.withOpacity(0.2)
                                      : Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.ev_station,
                                  color: charger['isAvailable']
                                      ? Colors.green
                                      : Colors.red,
                                  size: 20,
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
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.bolt,
                                          size: 14,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          charger['power'],
                                          style: GoogleFonts.inter(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(width: AppConstants.md),
                                        Icon(
                                          Icons.attach_money,
                                          size: 14,
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          charger['price'],
                                          style: GoogleFonts.inter(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed:
                                    charger['isAvailable'] ? () {} : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: charger['isAvailable']
                                      ? AppTheme.primary
                                      : Colors.grey.withOpacity(0.3),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text(
                                  charger['isAvailable'] ? 'Book' : 'Occupied',
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: AppConstants.md),

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Go to current location
                          },
                          icon: const Icon(Icons.my_location),
                          label: const Text('My Location'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppConstants.md),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // Show all chargers
                          },
                          icon: const Icon(Icons.list),
                          label: const Text('List View'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.1),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().slideY(
                  begin: 1,
                  end: 0,
                  duration: 600.ms,
                  curve: Curves.easeOutCubic,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.md),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
