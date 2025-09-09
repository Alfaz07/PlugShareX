import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _priceRange = const RangeValues(0, 1);
  RangeValues _distanceRange = const RangeValues(0, 50);
  String _selectedChargerType = 'All';
  String _selectedConnector = 'All';
  bool _onlyAvailable = false;
  bool _onlyFree = false;

  final List<String> _chargerTypes = [
    'All',
    'DC Fast',
    'AC',
    'Tesla Supercharger',
    'Home Charger',
  ];

  final List<String> _connectors = [
    'All',
    'CCS',
    'CHAdeMO',
    'Type 2',
    'Tesla',
  ];

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
                    Text(
                      'Filter Chargers',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _priceRange = const RangeValues(0, 1);
                          _distanceRange = const RangeValues(0, 50);
                          _selectedChargerType = 'All';
                          _selectedConnector = 'All';
                          _onlyAvailable = false;
                          _onlyFree = false;
                        });
                      },
                      child: Text(
                        'Reset',
                        style: GoogleFonts.inter(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.lg),

                // Availability Filter
                Text(
                  'Availability',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                SwitchListTile(
                  title: Text(
                    'Only available chargers',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  ),
                  value: _onlyAvailable,
                  onChanged: (value) {
                    setState(() {
                      _onlyAvailable = value;
                    });
                  },
                  activeColor: AppTheme.primary,
                ),
                SwitchListTile(
                  title: Text(
                    'Only free chargers',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                  ),
                  value: _onlyFree,
                  onChanged: (value) {
                    setState(() {
                      _onlyFree = value;
                    });
                  },
                  activeColor: AppTheme.primary,
                ),

                const SizedBox(height: AppConstants.lg),

                // Charger Type Filter
                Text(
                  'Charger Type',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Wrap(
                  spacing: AppConstants.sm,
                  children: _chargerTypes.map((type) {
                    final isSelected = _selectedChargerType == type;
                    return FilterChip(
                      label: Text(type),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedChargerType = type;
                        });
                      },
                      backgroundColor: Colors.transparent,
                      selectedColor: AppTheme.primary.withOpacity(0.2),
                      labelStyle: GoogleFonts.inter(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                      side: BorderSide(
                        color:
                            isSelected ? AppTheme.primary : AppTheme.neutral300,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppConstants.lg),

                // Connector Type Filter
                Text(
                  'Connector Type',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                Wrap(
                  spacing: AppConstants.sm,
                  children: _connectors.map((connector) {
                    final isSelected = _selectedConnector == connector;
                    return FilterChip(
                      label: Text(connector),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          _selectedConnector = connector;
                        });
                      },
                      backgroundColor: Colors.transparent,
                      selectedColor: AppTheme.primary.withOpacity(0.2),
                      labelStyle: GoogleFonts.inter(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.textSecondary,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                      side: BorderSide(
                        color:
                            isSelected ? AppTheme.primary : AppTheme.neutral300,
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: AppConstants.lg),

                // Price Range Filter
                Text(
                  'Price Range (\$/kWh)',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                RangeSlider(
                  values: _priceRange,
                  min: 0,
                  max: 1,
                  divisions: 20,
                  labels: RangeLabels(
                    '\$${_priceRange.start.toStringAsFixed(2)}',
                    '\$${_priceRange.end.toStringAsFixed(2)}',
                  ),
                  onChanged: (values) {
                    setState(() {
                      _priceRange = values;
                    });
                  },
                  activeColor: AppTheme.primary,
                ),

                const SizedBox(height: AppConstants.lg),

                // Distance Range Filter
                Text(
                  'Distance (km)',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: AppConstants.sm),
                RangeSlider(
                  values: _distanceRange,
                  min: 0,
                  max: 50,
                  divisions: 50,
                  labels: RangeLabels(
                    '${_distanceRange.start.round()} km',
                    '${_distanceRange.end.round()} km',
                  ),
                  onChanged: (values) {
                    setState(() {
                      _distanceRange = values;
                    });
                  },
                  activeColor: AppTheme.primary,
                ),

                const SizedBox(height: AppConstants.lg),

                // Apply Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Apply filters
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Filters applied!'),
                          backgroundColor: AppTheme.primary,
                        ),
                      );
                    },
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
                      'Apply Filters',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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
}
