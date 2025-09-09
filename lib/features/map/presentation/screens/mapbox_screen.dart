import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/config/mapbox_config.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/services/mapbox_service.dart';

class MapboxScreen extends StatefulWidget {
  const MapboxScreen({super.key});

  @override
  State<MapboxScreen> createState() => _MapboxScreenState();
}

class _MapboxScreenState extends State<MapboxScreen> {
  MapboxMapController? mapController;
  LatLng? _currentLocation;
  bool _isLoading = true;

  // Mock charger data
  final List<ChargerMarker> _chargers = [
    ChargerMarker(
      id: '1',
      name: 'HyperCharge Station',
      location: const LatLng(37.7749, -122.4194),
      isAvailable: true,
      power: '150 kW',
      price: '\$0.22/kWh',
    ),
    ChargerMarker(
      id: '2',
      name: 'EcoCharge Hub',
      location: const LatLng(37.7849, -122.4094),
      isAvailable: false,
      power: '100 kW',
      price: '\$0.25/kWh',
    ),
    ChargerMarker(
      id: '3',
      name: 'FastCharge Point',
      location: const LatLng(37.7649, -122.4294),
      isAvailable: true,
      power: '200 kW',
      price: '\$0.30/kWh',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    try {
      // Get current location
      _currentLocation = await MapboxService.getCurrentLocation();

      // If no current location, use default
      if (_currentLocation == null) {
        _currentLocation = const LatLng(
          MapboxConfig.defaultLatitude,
          MapboxConfig.defaultLongitude,
        );
      }

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error initializing map: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    MapboxService.setMapController(controller);

    // Add charger markers after map is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MapboxService.addChargerMarkers(_chargers);
    });
  }

  void _onMapClick(dynamic point, LatLng coordinates) {
    // Handle map click
    print('Map clicked at: $coordinates');
  }

  Future<void> _goToCurrentLocation() async {
    if (_currentLocation != null && mapController != null) {
      await MapboxService.animateToLocation(_currentLocation!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppTheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: AppTheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Loading map...',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: Stack(
        children: [
          // Mapbox Map
          MapboxMap(
            accessToken: MapboxConfig.accessToken,
            initialCameraPosition: CameraPosition(
              target: _currentLocation!,
              zoom: MapboxConfig.defaultZoom,
            ),
            onMapCreated: _onMapCreated,
            onMapClick: _onMapClick,
            myLocationEnabled: true,
            myLocationTrackingMode: MyLocationTrackingMode.Tracking,
            styleString: MapboxConfig.mapStyle,
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
                        '${_chargers.where((c) => c.isAvailable).length}',
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

                  // Quick Actions
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: _goToCurrentLocation,
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
