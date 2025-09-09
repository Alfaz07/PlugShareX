import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _upcomingBookings = [
    {
      'id': '1',
      'chargerName': 'Tesla Supercharger - Kochi',
      'address': 'Marine Drive, Ernakulam, Kochi, Kerala',
      'date': DateTime.now().add(const Duration(days: 1)),
      'time': '14:00 - 16:00',
      'duration': '2 hours',
      'price': '₹1,260',
      'status': 'confirmed',
      'power': '250 kW',
      'connector': 'Tesla Supercharger',
      'host': 'Tesla Inc.',
      'estimatedCost': '₹1,260',
      'savings': '₹340',
      'carbonSaved': '12.5 kg CO2',
      'energyAdded': '36 kWh',
    },
    {
      'id': '2',
      'chargerName': 'Electrify India Hub',
      'address': 'Lulu Mall, Edappally, Kochi, Kerala',
      'date': DateTime.now().add(const Duration(days: 3)),
      'time': '10:00 - 11:30',
      'duration': '1.5 hours',
      'price': '₹840',
      'status': 'confirmed',
      'power': '150 kW',
      'connector': 'CCS',
      'host': 'Electrify India',
      'estimatedCost': '₹840',
      'savings': '₹210',
      'carbonSaved': '8.2 kg CO2',
      'energyAdded': '22.5 kWh',
    },
    {
      'id': '3',
      'chargerName': 'Home Charger - Thomas Residence',
      'address': 'Panampilly Nagar, Ernakulam, Kochi, Kerala',
      'date': DateTime.now().add(const Duration(hours: 6)),
      'time': '18:00 - 20:00',
      'duration': '2 hours',
      'price': '₹792',
      'status': 'pending',
      'power': '22 kW',
      'connector': 'Type 2',
      'host': 'Thomas Mathew',
      'estimatedCost': '₹792',
      'savings': '₹198',
      'carbonSaved': '6.8 kg CO2',
      'energyAdded': '44 kWh',
    },
  ];

  final List<Map<String, dynamic>> _pastBookings = [
    {
      'id': '4',
      'chargerName': 'EVgo Ultra-Fast Station',
      'address': 'NH66 Highway, Kollam, Kerala',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'time': '16:00 - 18:00',
      'duration': '2 hours',
      'price': '₹1,575',
      'status': 'completed',
      'power': '350 kW',
      'connector': 'CCS',
      'host': 'EVgo India',
      'rating': 5,
      'review':
          'Incredibly fast charging! The 350kW speed is amazing. Perfect location on NH66 for road trips to Trivandrum.',
      'actualCost': '₹1,575',
      'energyReceived': '35 kWh',
      'carbonSaved': '14.2 kg CO2',
      'chargingEfficiency': '95%',
    },
    {
      'id': '5',
      'chargerName': 'ChargePoint Express',
      'address': 'Infopark, Kakkanad, Kochi, Kerala',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'time': '14:00 - 15:30',
      'duration': '1.5 hours',
      'price': '₹960',
      'status': 'completed',
      'power': '100 kW',
      'connector': 'CCS',
      'host': 'ChargePoint',
      'rating': 4,
      'review':
          'Convenient location at Infopark. Good charging speed and clean facilities. Great for tech professionals.',
      'actualCost': '₹960',
      'energyReceived': '15 kWh',
      'carbonSaved': '6.1 kg CO2',
      'chargingEfficiency': '92%',
    },
    {
      'id': '6',
      'chargerName': 'Green Energy Community Hub',
      'address': 'Kovalam Beach Road, Trivandrum, Kerala',
      'date': DateTime.now().subtract(const Duration(days: 7)),
      'time': '10:00 - 12:00',
      'duration': '2 hours',
      'price': '₹800',
      'status': 'completed',
      'power': '50 kW',
      'connector': 'CCS',
      'host': 'Green Energy Kerala',
      'rating': 5,
      'review':
          'Love the solar-powered charging! Beautiful beach view and great coffee at the cafe. Perfect for tourists.',
      'actualCost': '₹800',
      'energyReceived': '20 kWh',
      'carbonSaved': '8.0 kg CO2',
      'chargingEfficiency': '88%',
    },
    {
      'id': '7',
      'chargerName': 'Premium Hotel Charger',
      'address': 'Taj Malabar, Willingdon Island, Kochi, Kerala',
      'date': DateTime.now().subtract(const Duration(days: 10)),
      'time': '20:00 - 22:00',
      'duration': '2 hours',
      'price': '₹1,100',
      'status': 'completed',
      'power': '22 kW',
      'connector': 'Type 2',
      'host': 'Taj Hotels',
      'rating': 4,
      'review':
          'Premium experience at Taj Malabar with valet parking. A bit expensive but worth it for the luxury.',
      'actualCost': '₹1,100',
      'energyReceived': '44 kWh',
      'carbonSaved': '7.8 kg CO2',
      'chargingEfficiency': '90%',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Text(
          'My Bookings',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.schedule, size: 20),
                  const SizedBox(width: AppConstants.xs),
                  Text(
                    'Upcoming (${_upcomingBookings.length})',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.history, size: 20),
                  const SizedBox(width: AppConstants.xs),
                  Text(
                    'Past (${_pastBookings.length})',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildUpcomingBookings(),
          _buildPastBookings(),
        ],
      ),
    );
  }

  Widget _buildUpcomingBookings() {
    if (_upcomingBookings.isEmpty) {
      return _buildEmptyState(
        'No Upcoming Bookings',
        'You don\'t have any upcoming charging sessions.',
        Icons.schedule,
        'Book a Charger',
        () {
          // Navigate to map to book
          Navigator.pop(context);
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.lg),
      itemCount: _upcomingBookings.length,
      itemBuilder: (context, index) {
        final booking = _upcomingBookings[index];
        return _buildBookingCard(booking, true)
            .animate(delay: (index * 100).ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: 0.3, end: 0);
      },
    );
  }

  Widget _buildPastBookings() {
    if (_pastBookings.isEmpty) {
      return _buildEmptyState(
        'No Past Bookings',
        'You haven\'t completed any charging sessions yet.',
        Icons.history,
        'Book Your First Session',
        () {
          // Navigate to map to book
          Navigator.pop(context);
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.lg),
      itemCount: _pastBookings.length,
      itemBuilder: (context, index) {
        final booking = _pastBookings[index];
        return _buildBookingCard(booking, false)
            .animate(delay: (index * 100).ms)
            .fadeIn(duration: 400.ms)
            .slideX(begin: 0.3, end: 0);
      },
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking, bool isUpcoming) {
    final status = booking['status'] as String;
    final statusColor = _getStatusColor(status);
    final statusText = _getStatusText(status);

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        boxShadow: AppConstants.shadowSm,
        border: Border.all(
          color: statusColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppConstants.lg),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.radiusLg),
                topRight: Radius.circular(AppConstants.radiusLg),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getStatusIcon(status),
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['chargerName'],
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      Text(
                        booking['address'],
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
                    color: statusColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    statusText,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.all(AppConstants.lg),
            child: Column(
              children: [
                // Date and Time
                Row(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 20, color: AppTheme.textSecondary),
                    const SizedBox(width: AppConstants.sm),
                    Text(
                      _formatDate(booking['date']),
                      style: GoogleFonts.inter(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.access_time,
                        size: 20, color: AppTheme.textSecondary),
                    const SizedBox(width: AppConstants.sm),
                    Text(
                      booking['time'],
                      style: GoogleFonts.inter(
                        color: AppTheme.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppConstants.md),

                // Specifications
                Row(
                  children: [
                    _buildSpecChip(
                        'Duration', booking['duration'], Icons.timer),
                    const SizedBox(width: AppConstants.sm),
                    _buildSpecChip('Power', booking['power'], Icons.bolt),
                    const SizedBox(width: AppConstants.sm),
                    _buildSpecChip(
                        'Connector', booking['connector'], Icons.ev_station),
                  ],
                ),

                const SizedBox(height: AppConstants.lg),

                // Price and Actions
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: GoogleFonts.inter(
                            color: AppTheme.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          booking['price'],
                          style: GoogleFonts.inter(
                            color: AppTheme.textPrimary,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    if (isUpcoming) ...[
                      OutlinedButton(
                        onPressed: () {
                          _cancelBooking(booking);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppTheme.error,
                          side: BorderSide(color: AppTheme.error),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: AppConstants.sm),
                      ElevatedButton(
                        onPressed: () {
                          _getDirections(booking);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Directions'),
                      ),
                    ] else ...[
                      if (booking['rating'] == null)
                        ElevatedButton(
                          onPressed: () {
                            _showReviewDialog(booking);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.secondary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Review'),
                        )
                      else
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${booking['rating']}',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ],
                ),

                // Review (for past bookings)
                if (!isUpcoming && booking['review'] != null) ...[
                  const SizedBox(height: AppConstants.md),
                  Container(
                    padding: const EdgeInsets.all(AppConstants.md),
                    decoration: BoxDecoration(
                      color: AppTheme.neutral50,
                      borderRadius:
                          BorderRadius.circular(AppConstants.radiusMd),
                      border: Border.all(color: AppTheme.neutral200),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.rate_review,
                            size: 20, color: AppTheme.textSecondary),
                        const SizedBox(width: AppConstants.sm),
                        Expanded(
                          child: Text(
                            booking['review'],
                            style: GoogleFonts.inter(
                              color: AppTheme.textPrimary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
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
            Icon(icon, size: 16, color: AppTheme.primary),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                value,
                style: GoogleFonts.inter(
                  color: AppTheme.primary,
                  fontSize: 12,
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

  Widget _buildEmptyState(String title, String subtitle, IconData icon,
      String actionText, VoidCallback onAction) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.lg),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: AppConstants.lg),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.sm),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.xl),
            ElevatedButton.icon(
              onPressed: onAction,
              icon: const Icon(Icons.add),
              label: Text(actionText),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.lg,
                  vertical: AppConstants.md,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return Colors.green;
      case 'completed':
        return Colors.blue;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return AppTheme.neutral500;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'confirmed':
        return 'Confirmed';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'pending':
        return 'Pending';
      default:
        return status;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'confirmed':
        return Icons.check_circle;
      case 'completed':
        return Icons.done_all;
      case 'cancelled':
        return Icons.cancel;
      case 'pending':
        return Icons.schedule;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else if (difference < 7) {
      return '${date.day}/${date.month}/${date.year}';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _cancelBooking(Map<String, dynamic> booking) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: Text(
            'Are you sure you want to cancel your booking at ${booking['chargerName']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _upcomingBookings.removeWhere((b) => b['id'] == booking['id']);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Booking cancelled successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );
  }

  void _getDirections(Map<String, dynamic> booking) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening directions to ${booking['chargerName']}'),
        backgroundColor: AppTheme.primary,
      ),
    );
  }

  void _showReviewDialog(Map<String, dynamic> booking) {
    int rating = 0;
    String review = '';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Rate Your Experience'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('How was your experience at ${booking['chargerName']}?'),
              const SizedBox(height: AppConstants.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () {
                      setState(() {
                        rating = index + 1;
                      });
                    },
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
              const SizedBox(height: AppConstants.md),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Review (optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  review = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  final index =
                      _pastBookings.indexWhere((b) => b['id'] == booking['id']);
                  if (index != -1) {
                    _pastBookings[index]['rating'] = rating;
                    _pastBookings[index]['review'] = review;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Review submitted successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
