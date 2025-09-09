// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerModel _$ChargerModelFromJson(Map<String, dynamic> json) => ChargerModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      location: const LatLngConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
      hostId: json['hostId'] as String,
      hostName: json['hostName'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: (json['reviewCount'] as num).toInt(),
      power: (json['power'] as num).toDouble(),
      connectorType: json['connectorType'] as String,
      pricePerKwh: (json['pricePerKwh'] as num).toDouble(),
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
      imageUrl: json['imageUrl'] as String,
      amenities:
          (json['amenities'] as List<dynamic>).map((e) => e as String).toList(),
      schedule: json['schedule'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ChargerModelToJson(ChargerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'location': const LatLngConverter().toJson(instance.location),
      'hostId': instance.hostId,
      'hostName': instance.hostName,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'power': instance.power,
      'connectorType': instance.connectorType,
      'pricePerKwh': instance.pricePerKwh,
      'pricePerHour': instance.pricePerHour,
      'isAvailable': instance.isAvailable,
      'imageUrl': instance.imageUrl,
      'amenities': instance.amenities,
      'schedule': instance.schedule,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
