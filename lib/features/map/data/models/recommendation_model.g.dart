// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerRecommendation _$ChargerRecommendationFromJson(
        Map<String, dynamic> json) =>
    ChargerRecommendation(
      charger: ChargerModel.fromJson(json['charger'] as Map<String, dynamic>),
      score: (json['score'] as num).toDouble(),
      reason: json['reason'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      metadata: json['metadata'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$ChargerRecommendationToJson(
        ChargerRecommendation instance) =>
    <String, dynamic>{
      'charger': instance.charger,
      'score': instance.score,
      'reason': instance.reason,
      'tags': instance.tags,
      'metadata': instance.metadata,
    };

RecommendationScore _$RecommendationScoreFromJson(Map<String, dynamic> json) =>
    RecommendationScore(
      distanceScore: (json['distanceScore'] as num).toDouble(),
      priceScore: (json['priceScore'] as num).toDouble(),
      availabilityScore: (json['availabilityScore'] as num).toDouble(),
      ratingScore: (json['ratingScore'] as num).toDouble(),
      powerScore: (json['powerScore'] as num).toDouble(),
      totalScore: (json['totalScore'] as num).toDouble(),
    );

Map<String, dynamic> _$RecommendationScoreToJson(
        RecommendationScore instance) =>
    <String, dynamic>{
      'distanceScore': instance.distanceScore,
      'priceScore': instance.priceScore,
      'availabilityScore': instance.availabilityScore,
      'ratingScore': instance.ratingScore,
      'powerScore': instance.powerScore,
      'totalScore': instance.totalScore,
    };

ChargerLocation _$ChargerLocationFromJson(Map<String, dynamic> json) =>
    ChargerLocation(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String,
    );

Map<String, dynamic> _$ChargerLocationToJson(ChargerLocation instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
    };
