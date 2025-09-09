// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charger_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargerModel _$ChargerModelFromJson(Map<String, dynamic> json) => ChargerModel(
      id: json['id'] as String,
      hostId: json['hostId'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      location: const GeoPointConverter()
          .fromJson(json['location'] as Map<String, dynamic>),
      chargerType: json['chargerType'] as String,
      connectorType: json['connectorType'] as String,
      powerOutput: (json['powerOutput'] as num).toDouble(),
      pricePerKwh: (json['pricePerKwh'] as num).toDouble(),
      pricePerHour: (json['pricePerHour'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
      reviewCount: (json['reviewCount'] as num).toInt(),
      specifications: json['specifications'] as Map<String, dynamic>?,
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ChargerModelToJson(ChargerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'hostId': instance.hostId,
      'name': instance.name,
      'address': instance.address,
      'location': const GeoPointConverter().toJson(instance.location),
      'chargerType': instance.chargerType,
      'connectorType': instance.connectorType,
      'powerOutput': instance.powerOutput,
      'pricePerKwh': instance.pricePerKwh,
      'pricePerHour': instance.pricePerHour,
      'isAvailable': instance.isAvailable,
      'description': instance.description,
      'images': instance.images,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'specifications': instance.specifications,
      'amenities': instance.amenities,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
