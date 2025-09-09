import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import 'add_charger_screen.dart';

class HostDashboardScreen extends StatefulWidget {
  const HostDashboardScreen({super.key});

  @override
  State<HostDashboardScreen> createState() => _HostDashboardScreenState();
}

class _HostDashboardScreenState extends State<HostDashboardScreen> {
  final List<Map<String, dynamic>> _myChargers = [
    {
      'id': '1',
      'name': 'Home Charger - Main',
      'address': 'Panampilly Nagar, Ernakulam, Kochi, Kerala 682036',
      'power': '22 kW',
      'connector': 'Type 2',
      'price': '₹25/kWh',
      'isAvailable': true,
      'earnings': '₹15,680',
      'bookings': 28,
      'rating': 4.8,
      'reviews': 24,
      'totalEnergy': '627.2 kWh',
      'carbonSaved': '250.9 kg CO2',
      'uptime': '98.5%',
      'lastBooking': '2 hours ago',
      'monthlyEarnings': '₹4,520',
      'popularHours': '18:00-20:00',
    },
    {
      'id': '2',
      'name': 'Home Charger - Garage',
      'address': 'Panampilly Nagar, Ernakulam, Kochi, Kerala 682036',
      'power': '11 kW',
      'connector': 'Type 2',
      'price': '₹20/kWh',
      'isAvailable': false,
      'earnings': '₹8,940',
      'bookings': 15,
      'rating': 4.9,
      'reviews': 12,
      'totalEnergy': '447.0 kWh',
      'carbonSaved': '178.8 kg CO2',
      'uptime': '96.2%',
      'lastBooking': '1 day ago',
      'monthlyEarnings': '₹2,850',
      'popularHours': '19:00-21:00',
    },
    {
      'id': '3',
      'name': 'Workplace Charger - Office',
      'address': 'Infopark Phase 1, Kakkanad, Kochi, Kerala 682030',
      'power': '50 kW',
      'connector': 'CCS',
      'price': '₹30/kWh',
      'isAvailable': true,
      'earnings': '₹23,460',
      'bookings': 42,
      'rating': 4.7,
      'reviews': 38,
      'totalEnergy': '782.0 kWh',
      'carbonSaved': '312.8 kg CO2',
      'uptime': '99.1%',
      'lastBooking': '30 minutes ago',
      'monthlyEarnings': '₹6,780',
      'popularHours': '9:00-11:00',
    },
  ];

  final List<Map<String, dynamic>> _recentBookings = [
    {
      'id': '1',
      'chargerName': 'Home Charger - Main',
      'userName': 'Rajesh K.',
      'userRating': 4.9,
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'duration': '1.5 hours',
      'earnings': '₹525',
      'status': 'completed',
      'energyDelivered': '33 kWh',
      'carbonSaved': '13.2 kg CO2',
      'userReview':
          'Great experience! Very clean and fast charging. Perfect location in Panampilly Nagar.',
    },
    {
      'id': '2',
      'chargerName': 'Workplace Charger - Office',
      'userName': 'Priya M.',
      'userRating': 4.7,
      'date': DateTime.now().subtract(const Duration(hours: 1)),
      'duration': '45 minutes',
      'earnings': '₹675',
      'status': 'completed',
      'energyDelivered': '22.5 kWh',
      'carbonSaved': '9.0 kg CO2',
      'userReview': 'Perfect for quick charging during work hours at Infopark.',
    },
    {
      'id': '3',
      'chargerName': 'Home Charger - Main',
      'userName': 'Mohan R.',
      'userRating': 4.8,
      'date': DateTime.now().add(const Duration(hours: 3)),
      'duration': '2 hours',
      'earnings': '₹700',
      'status': 'upcoming',
      'estimatedEnergy': '44 kWh',
      'estimatedCarbonSaved': '17.6 kg CO2',
    },
    {
      'id': '4',
      'chargerName': 'Workplace Charger - Office',
      'userName': 'Lakshmi K.',
      'userRating': 4.6,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'duration': '1 hour',
      'earnings': '₹450',
      'status': 'completed',
      'energyDelivered': '15 kWh',
      'carbonSaved': '6.0 kg CO2',
      'userReview': 'Convenient location at Infopark and good charging speed.',
    },
    {
      'id': '5',
      'chargerName': 'Home Charger - Garage',
      'userName': 'Deepak P.',
      'userRating': 5.0,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'duration': '1.5 hours',
      'earnings': '₹420',
      'status': 'completed',
      'energyDelivered': '21 kWh',
      'carbonSaved': '8.4 kg CO2',
      'userReview':
          'Excellent host! Very accommodating and clean setup in Kochi.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final totalEarnings = _myChargers.fold<double>(
      0,
      (sum, charger) {
        final raw = charger['earnings'].toString();
        // Strip currency symbols, commas, and any non-numeric characters except dot
        final numeric =
            raw.replaceAll('₹', '').replaceAll(',', '').replaceAll(' ', '');
        final parsed = double.tryParse(numeric) ?? 0.0;
        return sum + parsed;
      },
    );

    final totalBookings = _myChargers.fold<int>(
      0,
      (sum, charger) => sum + (charger['bookings'] as int),
    );

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'Host Dashboard',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddChargerScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            _buildWelcomeSection(),
            const SizedBox(height: AppConstants.lg),

            // Stats Cards
            _buildStatsSection(totalEarnings, totalBookings),
            const SizedBox(height: AppConstants.lg),

            // My Chargers Section
            _buildMyChargersSection(),
            const SizedBox(height: AppConstants.lg),

            // Recent Bookings Section
            _buildRecentBookingsSection(),
            const SizedBox(height: AppConstants.lg),

            // Quick Actions
            _buildQuickActionsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primary,
            AppTheme.primaryLight,
          ],
        ),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.md),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: const Icon(
              Icons.home,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: AppConstants.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, Host!',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: AppConstants.xs),
                Text(
                  'Your chargers are helping the community',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatsSection(double totalEarnings, int totalBookings) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Total Earnings',
            '₹${totalEarnings.toStringAsFixed(2)}',
            Icons.attach_money,
            AppTheme.secondary,
          ),
        ),
        const SizedBox(width: AppConstants.md),
        Expanded(
          child: _buildStatCard(
            'Total Bookings',
            totalBookings.toString(),
            Icons.calendar_today,
            AppTheme.primary,
          ),
        ),
      ],
    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0);
  }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
        border: Border.all(
          color: color.withOpacity(0.2),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.sm),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppConstants.radiusMd),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(height: AppConstants.sm),
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
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMyChargersSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'My Chargers',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddChargerScreen(),
                  ),
                );
              },
              child: Text(
                'Add New',
                style: GoogleFonts.inter(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.md),
        if (_myChargers.isEmpty)
          _buildEmptyState(
            'No Chargers Listed',
            'Start earning by listing your first charger',
            Icons.ev_station,
            'Add Charger',
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddChargerScreen(),
                ),
              );
            },
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _myChargers.length,
            itemBuilder: (context, index) {
              final charger = _myChargers[index];
              return _buildChargerCard(charger)
                  .animate(delay: (index * 100).ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: 0.3, end: 0);
            },
          ),
      ],
    );
  }

  Widget _buildChargerCard(Map<String, dynamic> charger) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
        border: Border.all(
          color: charger['isAvailable']
              ? AppTheme.secondary.withOpacity(0.2)
              : AppTheme.neutral200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: charger['isAvailable']
                        ? AppTheme.secondary.withOpacity(0.1)
                        : AppTheme.neutral200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.ev_station,
                    color: charger['isAvailable']
                        ? AppTheme.secondary
                        : AppTheme.neutral500,
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        charger['address'],
                        style: GoogleFonts.inter(
                          fontSize: 12,
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
                    color: charger['isAvailable'] ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    charger['isAvailable'] ? 'Available' : 'Occupied',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConstants.md),

            // Specifications
            Row(
              children: [
                _buildSpecChip('Power', charger['power'], Icons.bolt),
                const SizedBox(width: AppConstants.sm),
                _buildSpecChip(
                    'Connector', charger['connector'], Icons.ev_station),
                const SizedBox(width: AppConstants.sm),
                _buildSpecChip('Price', charger['price'], Icons.attach_money),
              ],
            ),
            const SizedBox(height: AppConstants.md),

            // Stats
            Row(
              children: [
                _buildStatItem(
                    'Earnings', charger['earnings'], Icons.attach_money),
                const SizedBox(width: AppConstants.lg),
                _buildStatItem(
                    'Bookings', '${charger['bookings']}', Icons.calendar_today),
                const SizedBox(width: AppConstants.lg),
                _buildStatItem('Rating', '${charger['rating']}', Icons.star),
              ],
            ),
            const SizedBox(height: AppConstants.md),

            // Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _editCharger(charger);
                    },
                    icon: const Icon(Icons.edit, size: 16),
                    label: const Text('Edit'),
                    style: OutlinedButton.styleFrom(
                      padding:
                          const EdgeInsets.symmetric(vertical: AppConstants.sm),
                    ),
                  ),
                ),
                const SizedBox(width: AppConstants.sm),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _toggleAvailability(charger);
                    },
                    icon: Icon(
                      charger['isAvailable'] ? Icons.block : Icons.check_circle,
                      size: 16,
                    ),
                    label: Text(charger['isAvailable'] ? 'Disable' : 'Enable'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: charger['isAvailable']
                          ? AppTheme.error
                          : AppTheme.secondary,
                      foregroundColor: Colors.white,
                      padding:
                          const EdgeInsets.symmetric(vertical: AppConstants.sm),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecChip(String label, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.sm,
          vertical: AppConstants.xs,
        ),
        decoration: BoxDecoration(
          color: AppTheme.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          border: Border.all(
            color: AppTheme.primary.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppTheme.primary),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.inter(
                  color: AppTheme.primary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 16, color: AppTheme.textSecondary),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentBookingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Bookings',
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: AppConstants.md),
        if (_recentBookings.isEmpty)
          _buildEmptyState(
            'No Recent Bookings',
            'Bookings will appear here when users book your chargers',
            Icons.calendar_today,
            'View All',
            () {
              // Navigate to bookings
            },
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _recentBookings.length,
            itemBuilder: (context, index) {
              final booking = _recentBookings[index];
              return _buildBookingCard(booking)
                  .animate(delay: (index * 100).ms)
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: 0.3, end: 0);
            },
          ),
      ],
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    final status = booking['status'] as String;
    final statusColor = status == 'completed' ? Colors.green : AppTheme.primary;
    final statusText = status == 'completed' ? 'Completed' : 'Upcoming';

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.sm),
      padding: const EdgeInsets.all(AppConstants.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMd),
        boxShadow: AppConstants.shadowSm,
        border: Border.all(
          color: statusColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.person,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: AppConstants.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking['userName'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  booking['chargerName'],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textSecondary,
                  ),
                ),
                Text(
                  '${_formatDate(booking['date'])} • ${booking['duration']}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                booking['earnings'],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.secondary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
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
              child: _buildQuickActionCard(
                'Add Charger',
                Icons.add,
                AppTheme.primary,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddChargerScreen(),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: AppConstants.md),
            Expanded(
              child: _buildQuickActionCard(
                'View Earnings',
                Icons.attach_money,
                AppTheme.secondary,
                () {
                  _viewEarnings();
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.md),
        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                'Manage Schedule',
                Icons.schedule,
                AppTheme.accent,
                () {
                  _manageSchedule();
                },
              ),
            ),
            const SizedBox(width: AppConstants.md),
            Expanded(
              child: _buildQuickActionCard(
                'Support',
                Icons.support_agent,
                AppTheme.info,
                () {
                  _contactSupport();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppConstants.radiusMd),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.lg),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppConstants.radiusMd),
          border: Border.all(
            color: color.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 32,
            ),
            const SizedBox(height: AppConstants.sm),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle, IconData icon,
      String actionText, VoidCallback onAction) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.xl),
      decoration: BoxDecoration(
        color: AppTheme.neutral50,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: AppTheme.neutral200),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 48,
            color: AppTheme.neutral400,
          ),
          const SizedBox(height: AppConstants.md),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.sm),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppTheme.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.lg),
          ElevatedButton(
            onPressed: onAction,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(actionText),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference < 7) {
      return '${date.day}/${date.month}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _editCharger(Map<String, dynamic> charger) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Edit charger: ${charger['name']}'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _toggleAvailability(Map<String, dynamic> charger) {
    setState(() {
      charger['isAvailable'] = !charger['isAvailable'];
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '${charger['name']} ${charger['isAvailable'] ? 'enabled' : 'disabled'}'),
        backgroundColor: charger['isAvailable'] ? Colors.green : Colors.red,
      ),
    );
  }

  void _viewEarnings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Earnings dashboard coming soon!'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _manageSchedule() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Schedule management coming soon!'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Support chat coming soon!'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }
}
