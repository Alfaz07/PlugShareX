// Analytics service temporarily disabled
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  // Mock analytics data
  Future<Map<String, dynamic>> getChargingMetrics() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalSessions': 45,
      'totalKwh': 1250.5,
      'totalCost': 375.15,
      'averageSessionDuration': 2.5,
      'averageCostPerSession': 8.34,
    };
  }

  Future<Map<String, dynamic>> getCostMetrics() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'totalSpent': 375.15,
      'totalEarned': 0.0,
      'averageCostPerKwh': 0.30,
      'monthlySpending': 125.05,
      'savingsVsPublicChargers': 187.58,
    };
  }

  Future<Map<String, dynamic>> getUsagePatterns() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'peakHours': ['18:00', '19:00', '20:00'],
      'preferredDays': ['Friday', 'Saturday', 'Sunday'],
      'averageDistance': 15.5,
      'mostUsedChargers': [
        {'name': 'Home Charger - John', 'usage': 12},
        {'name': 'Fast Charging Station', 'usage': 8},
        {'name': 'Tesla Supercharger', 'usage': 5},
      ],
    };
  }

  Future<Map<String, dynamic>> getEnvironmentalImpact() async {
    await Future.delayed(const Duration(seconds: 1));
    return {
      'co2Saved': 625.25, // kg
      'treesEquivalent': 31.26,
      'gasolineEquivalent': 275.18, // liters
      'renewableEnergyPercentage': 85.0,
    };
  }

  // Mock methods for getting data
  Future<List<Map<String, dynamic>>> _getChargingSessions() async {
    return [
      {
        'id': '1',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'duration': 2.5,
        'kwh': 25.0,
        'cost': 7.50,
      },
      {
        'id': '2',
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'duration': 1.8,
        'kwh': 18.0,
        'cost': 5.40,
      },
    ];
  }

  Future<List<Map<String, dynamic>>> _getBookings() async {
    return [
      {
        'id': '1',
        'date': DateTime.now().subtract(const Duration(days: 1)),
        'status': 'completed',
        'cost': 7.50,
      },
      {
        'id': '2',
        'date': DateTime.now().subtract(const Duration(days: 3)),
        'status': 'completed',
        'cost': 5.40,
      },
    ];
  }

  Future<Map<String, int>> _analyzeChargingTimes() async {
    return {
      'morning': 15,
      'afternoon': 20,
      'evening': 35,
      'night': 30,
    };
  }

  Future<Map<String, int>> _analyzeChargerTypes() async {
    return {
      'Type 2': 45,
      'CCS': 25,
      'Tesla Supercharger': 20,
      'CHAdeMO': 10,
    };
  }
}
