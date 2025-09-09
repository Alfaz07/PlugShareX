import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/charger_model.dart';
import '../models/recommendation_model.dart';

class SmartRecommendationService {
  static final SmartRecommendationService _instance =
      SmartRecommendationService._internal();
  factory SmartRecommendationService() => _instance;
  SmartRecommendationService._internal();

  final double _earthRadius = 6371.0; // Earth's radius in kilometers

  /// Get personalized charger recommendations
  Future<List<ChargerRecommendation>> getRecommendations({
    required List<ChargerModel> chargers,
    required LatLng userLocation,
    required RecommendationContext context,
  }) async {
    final recommendations = <ChargerRecommendation>[];

    for (final charger in chargers) {
      final score = await _calculateRecommendationScore(
        charger: charger,
        userLocation: userLocation,
        context: context,
      );

      if (score.totalScore > 0.3) {
        // Minimum threshold
        recommendations.add(ChargerRecommendation(
          charger: charger,
          score: score.totalScore,
          reason: _generateRecommendationReason(score, charger, context),
          tags: ['recommended', 'nearby'],
          metadata: {
            'estimatedArrivalTime':
                _calculateArrivalTime(userLocation, charger),
            'estimatedChargingTime': _calculateChargingTime(charger, context),
            'totalCost': _calculateTotalCost(charger, context),
          },
        ));
      }
    }

    // Sort by total score descending
    recommendations.sort((a, b) => b.score.compareTo(a.score));

    return recommendations.take(10).toList(); // Return top 10
  }

  /// Calculate comprehensive recommendation score
  Future<RecommendationScore> _calculateRecommendationScore({
    required ChargerModel charger,
    required LatLng userLocation,
    required RecommendationContext context,
  }) async {
    // Distance score (closer is better)
    final distance = _calculateDistance(userLocation, charger.location);
    final distanceScore = _calculateDistanceScore(distance);

    // Price score (cheaper is better)
    final priceScore = _calculatePriceScore(charger, context);

    // Availability score
    final availabilityScore = _calculateAvailabilityScore(charger, context);

    // Rating score
    final ratingScore = charger.rating / 5.0;

    // Speed score (faster charging is better)
    final speedScore = _calculateSpeedScore(charger, context);

    // Calculate weighted total score
    final totalScore = (distanceScore * 0.25 +
        priceScore * 0.20 +
        availabilityScore * 0.15 +
        ratingScore * 0.15 +
        speedScore * 0.25);

    return RecommendationScore(
      totalScore: totalScore,
      distanceScore: distanceScore,
      priceScore: priceScore,
      availabilityScore: availabilityScore,
      ratingScore: ratingScore,
      powerScore: speedScore, // Use speedScore as powerScore
    );
  }

  double _calculateDistance(LatLng userLocation, LatLng chargerLocation) {
    return Geolocator.distanceBetween(
          userLocation.latitude,
          userLocation.longitude,
          chargerLocation.latitude,
          chargerLocation.longitude,
        ) /
        1000; // Convert to kilometers
  }

  double _calculateDistanceScore(double distance) {
    // Score decreases exponentially with distance
    if (distance <= 1) return 1.0;
    if (distance <= 5) return 0.8;
    if (distance <= 10) return 0.6;
    if (distance <= 20) return 0.4;
    if (distance <= 50) return 0.2;
    return 0.1;
  }

  double _calculatePriceScore(
      ChargerModel charger, RecommendationContext context) {
    final userBudget = context.maxPricePerKwh ?? double.infinity;
    final chargerPrice = charger.pricePerKwh;

    if (chargerPrice > userBudget) return 0.0;

    // Normalize price score (lower price = higher score)
    final maxPrice = context.maxPriceInArea ?? 1.0;
    return 1.0 - (chargerPrice / maxPrice);
  }

  double _calculateAvailabilityScore(
      ChargerModel charger, RecommendationContext context) {
    if (!charger.isAvailable) return 0.0;
    return 1.0; // Simplified for now
  }

  double _calculateSpeedScore(
      ChargerModel charger, RecommendationContext context) {
    final maxPower = charger.power;
    final userPreferredPower = context.preferredChargingSpeed ?? 50.0;

    if (maxPower >= userPreferredPower) return 1.0;
    return maxPower / userPreferredPower;
  }

  String _generateRecommendationReason(
    RecommendationScore score,
    ChargerModel charger,
    RecommendationContext context,
  ) {
    final reasons = <String>[];

    if (score.distanceScore > 0.8) {
      reasons.add('Very close to your location');
    }

    if (score.priceScore > 0.8) {
      reasons.add('Great pricing');
    }

    if (score.availabilityScore == 1.0) {
      reasons.add('Immediately available');
    }

    if (score.ratingScore > 0.8) {
      reasons.add('Highly rated by users');
    }

    if (score.powerScore > 0.8) {
      reasons.add('Fast charging available');
    }

    if (charger.amenities.isNotEmpty) {
      reasons.add('Great amenities nearby');
    }

    return reasons.join(', ');
  }

  Duration _calculateArrivalTime(LatLng userLocation, ChargerModel charger) {
    final distance = _calculateDistance(userLocation, charger.location);
    final averageSpeed = 30.0; // km/h average city speed
    final hours = distance / averageSpeed;
    return Duration(minutes: (hours * 60).round());
  }

  Duration _calculateChargingTime(
      ChargerModel charger, RecommendationContext context) {
    final energyNeeded = context.energyNeeded ?? 20.0; // kWh
    final maxPower = charger.power;

    final hours = energyNeeded / maxPower;
    return Duration(minutes: (hours * 60).round());
  }

  double _calculateTotalCost(
      ChargerModel charger, RecommendationContext context) {
    final energyNeeded = context.energyNeeded ?? 20.0;
    final chargingTime = _calculateChargingTime(charger, context);

    final energyCost = energyNeeded * charger.pricePerKwh;
    final timeCost =
        (chargingTime.inMinutes / 60.0) * (charger.pricePerHour ?? 0.0);

    return energyCost + timeCost;
  }

  /// Get route-based recommendations for long trips
  Future<List<ChargerRecommendation>> getRouteRecommendations({
    required List<LatLng> routePoints,
    required double vehicleRange,
    required double currentBatteryLevel,
  }) async {
    final recommendations = <ChargerRecommendation>[];

    // Calculate charging stops needed along the route
    final totalDistance = _calculateRouteDistance(routePoints);
    final availableRange = vehicleRange * (currentBatteryLevel / 100);

    if (totalDistance <= availableRange) {
      return recommendations; // No charging needed
    }

    // TODO: Implement route-based charging recommendations
    // This would involve finding optimal charging stops along the route

    return recommendations;
  }

  double _calculateRouteDistance(List<LatLng> routePoints) {
    double totalDistance = 0.0;

    for (int i = 0; i < routePoints.length - 1; i++) {
      totalDistance += _calculateDistance(routePoints[i], routePoints[i + 1]);
    }

    return totalDistance;
  }
}

/// Context for recommendation calculations
class RecommendationContext {
  final double? maxPricePerKwh;
  final double? maxPriceInArea;
  final double? preferredChargingSpeed;
  final double? energyNeeded;

  const RecommendationContext({
    this.maxPricePerKwh,
    this.maxPriceInArea,
    this.preferredChargingSpeed,
    this.energyNeeded,
  });
}
