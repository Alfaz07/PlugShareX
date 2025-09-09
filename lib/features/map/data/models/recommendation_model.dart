import 'package:json_annotation/json_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'charger_model.dart';

part 'recommendation_model.g.dart';

@JsonSerializable()
class ChargerRecommendation {
  final ChargerModel charger;
  final double score;
  final String reason;
  final List<String> tags;
  final Map<String, dynamic> metadata;

  const ChargerRecommendation({
    required this.charger,
    required this.score,
    required this.reason,
    required this.tags,
    required this.metadata,
  });

  factory ChargerRecommendation.fromJson(Map<String, dynamic> json) =>
      _$ChargerRecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerRecommendationToJson(this);
}

@JsonSerializable()
class RecommendationScore {
  final double distanceScore;
  final double priceScore;
  final double availabilityScore;
  final double ratingScore;
  final double powerScore;
  final double totalScore;

  const RecommendationScore({
    required this.distanceScore,
    required this.priceScore,
    required this.availabilityScore,
    required this.ratingScore,
    required this.powerScore,
    required this.totalScore,
  });

  factory RecommendationScore.fromJson(Map<String, dynamic> json) =>
      _$RecommendationScoreFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendationScoreToJson(this);
}

@JsonSerializable()
class ChargerLocation {
  final double latitude;
  final double longitude;
  final String address;

  const ChargerLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory ChargerLocation.fromJson(Map<String, dynamic> json) =>
      _$ChargerLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerLocationToJson(this);

  LatLng toLatLng() => LatLng(latitude, longitude);
}
