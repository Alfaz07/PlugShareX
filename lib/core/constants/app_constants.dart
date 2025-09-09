import 'package:flutter/material.dart';

class AppConstants {
  // App Info
  static const String appName = 'PlugShareX';
  static const String appVersion = '1.0.0';

  // API Endpoints (TODO: Replace with actual endpoints)
  static const String baseUrl = 'https://api.plugsharex.com';
  static const String googleMapsApiKey =
      'AIzaSyDfqWOq3aRPvEViZek17kL9GEOvVFK-IlE';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String chargersCollection = 'chargers';
  static const String bookingsCollection = 'bookings';
  static const String sessionsCollection = 'sessions';
  static const String reviewsCollection = 'reviews';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);

  // Spacing
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Shadows
  static const List<BoxShadow> shadowSm = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 4)),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(color: Color(0x15000000), blurRadius: 16, offset: Offset(0, 8)),
  ];

  // Glassmorphism
  static const double glassOpacity = 0.1;
  static const double glassBlur = 10.0;

  // Map Constants
  static const double defaultZoom = 15.0;
  static const double maxZoom = 20.0;
  static const double minZoom = 10.0;

  // Charger Types
  static const List<String> chargerTypes = [
    'Type 1 (J1772)',
    'Type 2 (Mennekes)',
    'CCS (Combo)',
    'CHAdeMO',
    'Tesla Supercharger',
    'Tesla Destination',
  ];

  // Connector Types
  static const List<String> connectorTypes = [
    'AC Single Phase',
    'AC Three Phase',
    'DC Fast Charging',
  ];

  // Payment Methods
  static const List<String> paymentMethods = [
    'Credit Card',
    'Debit Card',
    'Digital Wallet',
    'Bank Transfer',
  ];

  // Booking Status
  static const String pending = 'pending';
  static const String confirmed = 'confirmed';
  static const String cancelled = 'cancelled';
  static const String completed = 'completed';

  // Session Status
  static const String active = 'active';
  static const String paused = 'paused';
  static const String stopped = 'stopped';
}
