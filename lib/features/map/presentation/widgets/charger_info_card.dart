import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class ChargerInfoCard extends StatelessWidget {
  final Map<String, dynamic> charger;
  final VoidCallback onClose;
  final VoidCallback onBook;

  const ChargerInfoCard({
    super.key,
    required this.charger,
    required this.onClose,
    required this.onBook,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header with image
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.radiusLg),
                topRight: Radius.circular(AppConstants.radiusLg),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(charger['image']),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppConstants.radiusLg),
                      topRight: Radius.circular(AppConstants.radiusLg),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
                // Close button
                Positioned(
                  top: AppConstants.sm,
                  right: AppConstants.sm,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                    ),
                    child: IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close, size: 20),
                      color: Colors.black87,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ),
                ),
                // Availability badge
                Positioned(
                  top: AppConstants.sm,
                  left: AppConstants.sm,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.sm,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: charger['isAvailable']
                          ? AppTheme.success.withValues(alpha: 0.9)
                          : AppTheme.error.withValues(alpha: 0.9),
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusSm),
                    ),
                    child: Text(
                      charger['isAvailable'] ? 'Available' : 'Unavailable',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and rating
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        charger['name'],
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: AppTheme.accent,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          charger['rating'].toString(),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          ' (${charger['reviewCount']})',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.sm),

                // Address
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        charger['address'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.md),

                // Charger details
                Row(
                  children: [
                    _buildDetailItem(
                      icon: Icons.electric_bolt,
                      label: 'Power',
                      value: charger['power'],
                      color: AppTheme.primary,
                    ),
                    const SizedBox(width: AppConstants.md),
                    _buildDetailItem(
                      icon: Icons.power,
                      label: 'Connector',
                      value: charger['connector'],
                      color: AppTheme.secondary,
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.sm),

                Row(
                  children: [
                    _buildDetailItem(
                      icon: Icons.attach_money,
                      label: 'Per kWh',
                      value: charger['pricePerKwh'],
                      color: AppTheme.accent,
                    ),
                    const SizedBox(width: AppConstants.md),
                    _buildDetailItem(
                      icon: Icons.access_time,
                      label: 'Per Hour',
                      value: charger['pricePerHour'],
                      color: AppTheme.info,
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.lg),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // TODO: Navigate to directions
                        },
                        icon: const Icon(Icons.directions, size: 18),
                        label: Text(
                          'Directions',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.md,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.sm),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: charger['isAvailable'] ? onBook : null,
                        icon: const Icon(Icons.calendar_today, size: 18),
                        label: Text(
                          'Book Now',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: charger['isAvailable']
                              ? AppTheme.primary
                              : Colors.grey[400],
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConstants.md,
                          ),
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
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppConstants.sm),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: Colors.grey[600],
              ),
            ),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
