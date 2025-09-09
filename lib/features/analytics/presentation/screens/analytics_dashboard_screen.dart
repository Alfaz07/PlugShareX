import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class AnalyticsDashboardScreen extends StatefulWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  State<AnalyticsDashboardScreen> createState() =>
      _AnalyticsDashboardScreenState();
}

class _AnalyticsDashboardScreenState extends State<AnalyticsDashboardScreen> {
  String _selectedPeriod = 'This Month';

  final List<String> _periods = [
    'This Week',
    'This Month',
    'Last 3 Months',
    'This Year'
  ];

  final Map<String, dynamic> _analyticsData = {
    'totalEarnings': 48100.00,
    'totalBookings': 85,
    'totalEnergy': 2147.2,
    'totalCarbonSaved': 858.9,
    'averageRating': 4.8,
    'uptime': 97.9,
    'monthlyGrowth': 23.5,
    'customerSatisfaction': 94.2,
    'peakHours': {
      '18:00': 15,
      '19:00': 22,
      '20:00': 18,
      '21:00': 12,
      '22:00': 8,
    },
    'popularChargers': [
      {'name': 'Home Charger - Main', 'bookings': 28, 'earnings': 15680.00},
      {
        'name': 'Workplace Charger - Office',
        'bookings': 42,
        'earnings': 23460.00
      },
      {'name': 'Home Charger - Garage', 'bookings': 15, 'earnings': 8940.00},
    ],
    'revenueByDay': [
      {'day': 'Mon', 'revenue': 4520.00},
      {'day': 'Tue', 'revenue': 5280.00},
      {'day': 'Wed', 'revenue': 4890.00},
      {'day': 'Thu', 'revenue': 6130.00},
      {'day': 'Fri', 'revenue': 6750.00},
      {'day': 'Sat', 'revenue': 8920.00},
      {'day': 'Sun', 'revenue': 11610.00},
    ],
    'customerReviews': [
      {'rating': 5, 'count': 45, 'percentage': 52.9},
      {'rating': 4, 'count': 28, 'percentage': 32.9},
      {'rating': 3, 'count': 8, 'percentage': 9.4},
      {'rating': 2, 'count': 3, 'percentage': 3.5},
      {'rating': 1, 'count': 1, 'percentage': 1.2},
    ],
    'environmentalImpact': {
      'treesPlanted': 43,
      'gasolineSaved': 214.7,
      'co2Reduced': 858.9,
      'electricCarsSupported': 85,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Analytics Dashboard',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                _selectedPeriod = value;
              });
            },
            itemBuilder: (context) => _periods.map((period) {
              return PopupMenuItem(
                value: period,
                child: Text(period),
              );
            }).toList(),
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.md),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_selectedPeriod),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overview Cards
            _buildOverviewSection(),
            const SizedBox(height: AppConstants.lg),

            // Revenue Chart
            _buildRevenueChart(),
            const SizedBox(height: AppConstants.lg),

            // Performance Metrics
            _buildPerformanceMetrics(),
            const SizedBox(height: AppConstants.lg),

            // Popular Chargers
            _buildPopularChargers(),
            const SizedBox(height: AppConstants.lg),

            // Customer Satisfaction
            _buildCustomerSatisfaction(),
            const SizedBox(height: AppConstants.lg),

            // Environmental Impact
            _buildEnvironmentalImpact(),
            const SizedBox(height: AppConstants.lg),

            // Peak Hours Analysis
            _buildPeakHoursAnalysis(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverviewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppConstants.md),
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                'Total Earnings',
                '₹${_analyticsData['totalEarnings'].toStringAsFixed(0)}',
                Icons.attach_money,
                AppTheme.secondary,
                '+${_analyticsData['monthlyGrowth'].toStringAsFixed(1)}%',
              ),
            ),
            const SizedBox(width: AppConstants.md),
            Expanded(
              child: _buildOverviewCard(
                'Total Bookings',
                _analyticsData['totalBookings'].toString(),
                Icons.calendar_today,
                AppTheme.primary,
                '+12.3%',
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.md),
        Row(
          children: [
            Expanded(
              child: _buildOverviewCard(
                'Energy Delivered',
                '${_analyticsData['totalEnergy'].toStringAsFixed(1)} kWh',
                Icons.bolt,
                AppTheme.accent,
                '+8.7%',
              ),
            ),
            const SizedBox(width: AppConstants.md),
            Expanded(
              child: _buildOverviewCard(
                'Carbon Saved',
                '${_analyticsData['totalCarbonSaved'].toStringAsFixed(1)} kg',
                Icons.eco,
                Colors.green,
                '+15.2%',
              ),
            ),
          ],
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildOverviewCard(
      String title, String value, IconData icon, Color color, String growth) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppConstants.sm),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConstants.radiusMd),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  growth,
                  style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.md),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRevenueChart() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Revenue Trend',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.md),
          SizedBox(
            height: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _analyticsData['revenueByDay'].map<Widget>((day) {
                final height = (day['revenue'] as double) / 120 * 150;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 30,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.primary,
                            AppTheme.primaryLight,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: AppConstants.sm),
                    Text(
                      day['day'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '₹${day['revenue'].toStringAsFixed(0)}',
                        style: GoogleFonts.inter(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildPerformanceMetrics() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Performance Metrics',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.lg),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Average Rating',
                  '${_analyticsData['averageRating']}',
                  Icons.star,
                  Colors.amber,
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: _buildMetricCard(
                  'Uptime',
                  '${_analyticsData['uptime']}%',
                  Icons.check_circle,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.md),
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  'Customer Satisfaction',
                  '${_analyticsData['customerSatisfaction']}%',
                  Icons.sentiment_satisfied,
                  AppTheme.secondary,
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: _buildMetricCard(
                  'Monthly Growth',
                  '+${_analyticsData['monthlyGrowth']}%',
                  Icons.trending_up,
                  AppTheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildMetricCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: AppConstants.sm),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20,
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPopularChargers() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Most Popular Chargers',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.lg),
          ..._analyticsData['popularChargers'].map<Widget>((charger) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.md),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppConstants.sm),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.ev_station,
                      color: AppTheme.primary,
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
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        Text(
                          '${charger['bookings']} bookings',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '₹${charger['earnings'].toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.secondary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildCustomerSatisfaction() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Customer Reviews',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.lg),
          ..._analyticsData['customerReviews'].map<Widget>((review) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.sm),
              child: Row(
                children: [
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < review['rating']
                            ? Icons.star
                            : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      );
                    }),
                  ),
                  const SizedBox(width: AppConstants.sm),
                  Expanded(
                    child: LinearProgressIndicator(
                      value: review['percentage'] / 100,
                      backgroundColor: AppTheme.neutral200,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    ),
                  ),
                  const SizedBox(width: AppConstants.sm),
                  Text(
                    '${review['count']}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimary,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildEnvironmentalImpact() {
    final impact = _analyticsData['environmentalImpact'];
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.1),
            Colors.blue.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.eco,
                color: Colors.green,
                size: 24,
              ),
              const SizedBox(width: AppConstants.sm),
              Text(
                'Environmental Impact',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.lg),
          Row(
            children: [
              Expanded(
                child: _buildImpactCard(
                  'Trees Planted',
                  impact['treesPlanted'].toString(),
                  Icons.park,
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: _buildImpactCard(
                  'Gasoline Saved',
                  '${impact['gasolineSaved']}L',
                  Icons.local_gas_station,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.md),
          Row(
            children: [
              Expanded(
                child: _buildImpactCard(
                  'CO₂ Reduced',
                  '${impact['co2Reduced']} kg',
                  Icons.cloud,
                ),
              ),
              const SizedBox(width: AppConstants.md),
              Expanded(
                child: _buildImpactCard(
                  'EVs Supported',
                  impact['electricCarsSupported'].toString(),
                  Icons.ev_station,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildImpactCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.md),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.green, size: 24),
          const SizedBox(height: AppConstants.sm),
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
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPeakHoursAnalysis() {
    final peakHours = _analyticsData['peakHours'];
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Peak Hours Analysis',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppConstants.md),
          Text(
            'Most popular charging times',
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
          ),
          const SizedBox(height: AppConstants.lg),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: peakHours.entries.map<Widget>((entry) {
                final height = (entry.value as int) / 25 * 100;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 25,
                      height: height,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppTheme.secondary,
                            AppTheme.secondary.withOpacity(0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: AppConstants.sm),
                    Text(
                      entry.key,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                    Text(
                      entry.value.toString(),
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 1200.ms).slideY(begin: 0.3, end: 0);
  }
}
