import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class ChargerCard extends StatelessWidget {
  final Map<String, dynamic> charger;
  final VoidCallback onTap;

  const ChargerCard({
    super.key,
    required this.charger,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
        border: Border.all(
          color: charger['isAvailable']
              ? AppTheme.secondary.withValues(alpha: 0.2)
              : AppTheme.neutral200,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                Row(
                  children: [
                    // Status indicator
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: charger['isAvailable']
                            ? AppTheme.success
                            : AppTheme.error,
                      ),
                    ),

                    const SizedBox(width: AppConstants.sm),

                    // Charger name
                    Expanded(
                      child: Text(
                        charger['name'],
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.neutral900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Rating
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 16,
                          color: AppTheme.accent,
                        ),
                        const SizedBox(width: AppConstants.xs),
                        Text(
                          charger['rating'].toString(),
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.neutral700,
                          ),
                        ),
                        Text(
                          ' (${charger['reviewCount']})',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.neutral500,
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
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: AppTheme.neutral500,
                    ),
                    const SizedBox(width: AppConstants.xs),
                    Expanded(
                      child: Text(
                        charger['address'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppTheme.neutral600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.md),

                // Specifications row
                Row(
                  children: [
                    // Power rating
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.sm,
                        vertical: AppConstants.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusSm),
                      ),
                      child: Text(
                        (() {
                          final dynamic powerRating = charger['powerRating'];
                          final dynamic power = charger['power'];
                          if (powerRating != null) {
                            return '${powerRating} kW';
                          }
                          if (power is String && power.isNotEmpty) {
                            return power; // already formatted
                          }
                          return '—';
                        })(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primary,
                        ),
                      ),
                    ),

                    const SizedBox(width: AppConstants.sm),

                    // Connector type
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.sm,
                        vertical: AppConstants.xs,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.secondary.withValues(alpha: 0.1),
                        borderRadius:
                            BorderRadius.circular(AppConstants.radiusSm),
                      ),
                      child: Text(
                        charger['connector'] ?? 'Unknown',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.secondary,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Distance
                    Text((() {
                      final dynamic d = charger['distance'];
                      if (d == null) return '—';
                      if (d is num) return '${d.toStringAsFixed(1)} km';
                      final s = d.toString();
                      return s.endsWith('km') || s.endsWith(' km')
                          ? s
                          : '$s km';
                    })(),
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.neutral500,
                        )),
                  ],
                ),

                const SizedBox(height: AppConstants.md),

                // Price and action row
                Row(
                  children: [
                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (() {
                            final v = charger['pricePerKwh'];
                            if (v is num)
                              return '\$${v.toStringAsFixed(2)}/kWh';
                            final s = v?.toString() ?? '';
                            return s.isNotEmpty ? s : '—';
                          })(),
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.neutral900,
                          ),
                        ),
                        Text(
                          (() {
                            final v = charger['pricePerHour'];
                            if (v is num)
                              return '+ \$${v.toStringAsFixed(2)}/hr';
                            final s = v?.toString() ?? '';
                            return s.isNotEmpty ? '+ $s/hr' : '';
                          })(),
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.neutral500,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    // Book button
                    ElevatedButton(
                      onPressed: charger['isAvailable'] ? onTap : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: charger['isAvailable']
                            ? AppTheme.primary
                            : AppTheme.neutral300,
                        foregroundColor: charger['isAvailable']
                            ? Colors.white
                            : AppTheme.neutral500,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.md,
                          vertical: AppConstants.sm,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        charger['isAvailable'] ? 'Book Now' : 'Unavailable',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
