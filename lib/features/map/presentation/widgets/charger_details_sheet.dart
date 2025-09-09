import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class ChargerDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> charger;

  const ChargerDetailsSheet({
    super.key,
    required this.charger,
  });

  IconData _getAmenityIcon(String amenity) {
    switch (amenity.toLowerCase()) {
      case 'restaurant':
      case 'food court':
      case 'fine dining':
        return Icons.restaurant;
      case 'coffee shop':
      case 'cafeteria':
        return Icons.coffee;
      case 'wifi':
        return Icons.wifi;
      case 'restrooms':
        return Icons.wc;
      case 'parking':
      case 'valet parking':
        return Icons.local_parking;
      case 'shopping mall':
      case 'premium mall':
        return Icons.shopping_bag;
      case 'tech park':
        return Icons.business;
      case 'security':
        return Icons.security;
      case 'beach view':
      case 'tourist area':
        return Icons.beach_access;
      case 'home access':
      case 'safe neighborhood':
      case 'residential area':
        return Icons.home;
      case 'local shops':
        return Icons.store;
      default:
        return Icons.check_circle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppConstants.lg),

                  // Header
                  _buildHeader(),
                  const SizedBox(height: AppConstants.lg),

                  // Status and Quick Info
                  _buildStatusSection(),
                  const SizedBox(height: AppConstants.lg),

                  // Details
                  _buildDetailsSection(),
                  const SizedBox(height: AppConstants.lg),

                  // Amenities
                  _buildAmenitiesSection(),
                  const SizedBox(height: AppConstants.lg),

                  // Action Buttons
                  _buildActionButtons(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                charger['name'],
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.md,
                vertical: AppConstants.sm,
              ),
              decoration: BoxDecoration(
                color: charger['isAvailable']
                    ? AppTheme.success.withOpacity(0.2)
                    : AppTheme.error.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                charger['isAvailable'] ? 'Available' : 'Busy',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: charger['isAvailable']
                      ? AppTheme.success
                      : AppTheme.error,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.sm),
        Row(
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: AppTheme.textSecondary,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                charger['address'],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppTheme.textSecondary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.sm),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 16,
              color: AppTheme.warning,
            ),
            const SizedBox(width: 4),
            Text(
              '${charger['rating']} (${charger['reviews']} reviews)',
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.3);
  }

  Widget _buildStatusSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: AppTheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(
          color: AppTheme.primary.withOpacity(0.1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatusItem(
              'Power',
              charger['power'],
              Icons.bolt,
              AppTheme.warning,
            ),
          ),
          Expanded(
            child: _buildStatusItem(
              'Price',
              charger['price'],
              Icons.attach_money,
              AppTheme.success,
            ),
          ),
          Expanded(
            child: _buildStatusItem(
              'Type',
              charger['type'],
              Icons.ev_station,
              AppTheme.primary,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 300.ms, delay: 100.ms).slideY(begin: 0.3);
  }

  Widget _buildStatusItem(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
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
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Details',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppConstants.md),
        _buildDetailRow('Host', charger['host'], Icons.person),
        _buildDetailRow('Hours', charger['hours'], Icons.access_time),
        _buildDetailRow('Wait Time', charger['waitTime'], Icons.timer),
        _buildDetailRow('Speed', charger['chargingSpeed'], Icons.speed),
        _buildDetailRow(
            'Reliability', '${charger['reliability']}%', Icons.verified),
        _buildDetailRow('Last Updated', charger['lastUpdated'], Icons.update),
      ],
    ).animate().fadeIn(duration: 300.ms, delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConstants.md),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: AppTheme.primary),
          ),
          const SizedBox(width: AppConstants.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmenitiesSection() {
    final amenities = List<String>.from(charger['amenities']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amenities',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppConstants.md),
        Wrap(
          spacing: AppConstants.sm,
          runSpacing: AppConstants.sm,
          children: amenities.map((amenity) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.md,
                vertical: AppConstants.sm,
              ),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppTheme.secondary.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getAmenityIcon(amenity),
                    size: 16,
                    color: AppTheme.secondary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    amenity,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.secondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms, delay: 300.ms).slideY(begin: 0.3);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: charger['isAvailable']
                ? () {
                    // Handle booking
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Booking ${charger['name']}...'),
                        backgroundColor: AppTheme.primary,
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: AppConstants.lg),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            child: Text(
              charger['isAvailable'] ? 'Book Now' : 'Currently Busy',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppConstants.md),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              // Handle navigation
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening navigation to ${charger['name']}...'),
                  backgroundColor: AppTheme.secondary,
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppTheme.secondary,
              side: BorderSide(color: AppTheme.secondary),
              padding: const EdgeInsets.symmetric(vertical: AppConstants.lg),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.radiusMd),
              ),
            ),
            child: Text(
              'Navigate',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ).animate().fadeIn(duration: 300.ms, delay: 400.ms).slideY(begin: 0.3);
  }
}
