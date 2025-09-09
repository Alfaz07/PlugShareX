import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../map/presentation/screens/simple_map_screen.dart'; // Only this import
import '../../../booking/presentation/screens/bookings_screen.dart';

class NeoDashboardScreen extends StatefulWidget {
  const NeoDashboardScreen({super.key});

  @override
  State<NeoDashboardScreen> createState() => _NeoDashboardScreenState();
}

class _NeoDashboardScreenState extends State<NeoDashboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'PlugShareX',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_active_rounded),
            onPressed: () {},
          ),
          const SizedBox(width: AppConstants.sm),
        ],
      ),
      body: Stack(
        children: [
          _buildAnimatedBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppConstants.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeroHeader(),
                  const SizedBox(height: AppConstants.lg),
                  _buildEnergyPanel(),
                  const SizedBox(height: AppConstants.lg),
                  _buildQuickActions(),
                  const SizedBox(height: AppConstants.lg),
                  _buildTrendingStations(),
                  const SizedBox(height: AppConstants.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final t = _controller.value;
        return CustomPaint(
          painter: _AuroraPainter(t: t),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0B1020), Color(0xFF0D0F1A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back,',
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.75),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppConstants.xs),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppTheme.primaryLight, AppTheme.secondaryLight],
          ).createShader(bounds),
          child: Text(
            'Charge the Future',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
        ).animate().fadeIn().slideY(begin: 0.3, end: 0, duration: 400.ms),
        const SizedBox(height: AppConstants.sm),
        Text(
          'Find, book, and optimize EV charging anywhere.',
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildEnergyPanel() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.lg),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(AppConstants.radiusLg),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CustomPaint(
              painter: EnergyRingPainter(
                progress: 0.64,
                startColor: AppTheme.secondary,
                endColor: AppTheme.primary,
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '64%',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Battery',
                      style: GoogleFonts.inter(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).animate().scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1, 1),
              duration: 400.ms),
          const SizedBox(width: AppConstants.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _statRow('Optimal charger', '12 nearby', Icons.ev_station),
                const SizedBox(height: AppConstants.sm),
                _statRow('Est. full charge', '42 min', Icons.bolt_rounded),
                const SizedBox(height: AppConstants.sm),
                _statRow('Cost prediction', ' 3.80 - 5.10',
                    Icons.attach_money_rounded),
                const SizedBox(height: AppConstants.md),
                Wrap(
                  spacing: AppConstants.sm,
                  runSpacing: AppConstants.sm,
                  children: [
                    _chip(Icons.auto_awesome, 'Smart recommend'),
                    _chip(Icons.speed_rounded, 'Fastest'),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _chip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.md,
        vertical: AppConstants.xs,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: AppConstants.xs),
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.inter(
                  color: Colors.white, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }

  Widget _statRow(String title, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(AppConstants.radiusSm),
          ),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
        const SizedBox(width: AppConstants.sm),
        Expanded(
          child: Text(
            title,
            style: GoogleFonts.inter(color: Colors.white.withOpacity(0.85)),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      _QuickAction(
        color: AppTheme.primary,
        icon: Icons.bolt_rounded,
        label: 'Quick charge',
        onTap: () {
          // Handle quick charge
        },
      ),
      _QuickAction(
        color: AppTheme.secondary,
        icon: Icons.map_rounded,
        label: 'Explore map',
        onTap: () {
          // Navigate to simple map screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SimpleMapScreen(),
            ),
          );
        },
      ),
      _QuickAction(
        color: AppTheme.accent,
        icon: Icons.schedule_rounded,
        label: 'Book slot',
        onTap: () {
          // Navigate to bookings screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookingsScreen(),
            ),
          );
        },
      ),
      _QuickAction(
        color: AppTheme.info,
        icon: Icons.auto_graph_rounded,
        label: 'Insights',
        onTap: () {
          // Handle insights
        },
      ),
    ];

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: AppConstants.sm,
      runSpacing: AppConstants.sm,
      children: actions
          .map((a) => SizedBox(
                width: (MediaQuery.of(context).size.width -
                        (AppConstants.lg * 2) -
                        (AppConstants.sm * 3)) /
                    4,
                child: _QuickActionButton(action: a).animate().fadeIn().move(
                    begin: const Offset(0, 10),
                    end: Offset.zero,
                    duration: 350.ms),
              ))
          .toList(),
    );
  }

  Widget _buildTrendingStations() {
    final items = List.generate(4, (i) => i);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Trending stations',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('See all'),
            )
          ],
        ),
        const SizedBox(height: AppConstants.md),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(width: AppConstants.md),
            itemBuilder: (context, index) {
              return _StationCard(index: index)
                  .animate(delay: (index * 80).ms)
                  .fadeIn(duration: 300.ms)
                  .move(begin: const Offset(0, 12), end: Offset.zero);
            },
          ),
        )
      ],
    );
  }
}

class _QuickAction {
  final Color color;
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _QuickAction({
    required this.color,
    required this.icon,
    required this.label,
    this.onTap,
  });
}

class _QuickActionButton extends StatelessWidget {
  final _QuickAction action;
  const _QuickActionButton({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppConstants.radiusLg),
      onTap: action.onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.md,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusLg),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          color: Colors.white.withOpacity(0.04),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: action.color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(action.icon, color: Colors.white),
            ),
            const SizedBox(height: AppConstants.sm),
            Text(
              action.label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StationCard extends StatelessWidget {
  final int index;
  const _StationCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = [
      AppTheme.secondary,
      AppTheme.primary,
      AppTheme.accent,
      AppTheme.info
    ];
    final color = colors[index % colors.length];

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = math.min(260.0, constraints.maxWidth);
        return Container(
          width: cardWidth,
          padding: const EdgeInsets.all(AppConstants.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.radiusLg),
            gradient: LinearGradient(
              colors: [color.withOpacity(0.12), Colors.white.withOpacity(0.04)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white.withOpacity(0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.ev_station,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: AppConstants.sm),
                  Expanded(
                    child: Text(
                      'HyperCharge • Sector ${index + 1}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Icon(Icons.star_rounded, color: Colors.amber.shade400),
                  const SizedBox(width: 4),
                  Text('4.${index + 3}',
                      style: GoogleFonts.inter(color: Colors.white)),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Icon(Icons.bolt_rounded, color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text('150 kW',
                        style: GoogleFonts.inter(color: Colors.white),
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: AppConstants.md),
                  const Icon(Icons.attach_money_rounded,
                      color: Colors.white, size: 18),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(' 0.22/kWh',
                        style: GoogleFonts.inter(color: Colors.white),
                        overflow: TextOverflow.ellipsis),
                  ),
                  const SizedBox(width: AppConstants.sm),
                  Flexible(
                    fit: FlexFit.loose,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.15),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppConstants.md,
                            vertical: AppConstants.sm,
                          ),
                        ),
                        child: const Text('Book'),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class EnergyRingPainter extends CustomPainter {
  final double progress; // 0..1
  final Color startColor;
  final Color endColor;

  EnergyRingPainter(
      {required this.progress,
      required this.startColor,
      required this.endColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - 6;

    // Background circle
    final bg = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = Colors.white.withOpacity(0.08);
    canvas.drawCircle(center, radius, bg);

    // Gradient arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweep = 2 * math.pi * progress;

    final arcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 12
      ..shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: -math.pi / 2 + sweep,
        colors: [startColor, endColor],
      ).createShader(rect);

    canvas.drawArc(rect, -math.pi / 2, sweep, false, arcPaint);

    // Glow outer ring
    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 24
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12)
      ..color = endColor.withOpacity(0.15);
    canvas.drawArc(rect, -math.pi / 2, sweep, false, glow);
  }

  @override
  bool shouldRepaint(covariant EnergyRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor;
  }
}

class _AuroraPainter extends CustomPainter {
  final double t;
  _AuroraPainter({required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final colors = [
      AppTheme.primary.withOpacity(0.25),
      AppTheme.secondary.withOpacity(0.20),
      AppTheme.accent.withOpacity(0.18),
    ];

    for (int i = 0; i < colors.length; i++) {
      final paint = Paint()..color = colors[i];
      final dx =
          math.sin((t + i) * 2 * math.pi) * size.width * 0.2 + size.width * 0.5;
      final dy = math.cos((t + i * 0.33) * 2 * math.pi) * size.height * 0.15 +
          size.height * 0.35;
      final r = size.width * (0.35 + 0.05 * math.sin((t + i) * 2 * math.pi));
      final rect = Rect.fromCircle(center: Offset(dx, dy), radius: r);
      final grad = RadialGradient(colors: [paint.color, Colors.transparent]);
      final shader = grad.createShader(rect);
      canvas.drawCircle(Offset(dx, dy), r, Paint()..shader = shader);
    }
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter oldDelegate) =>
      oldDelegate.t != t;
}
