import 'package:json_annotation/json_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'charger_model.g.dart';

class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json['latitude'] as double, json['longitude'] as double);
  }

  @override
  Map<String, dynamic> toJson(LatLng latLng) {
    return {'latitude': latLng.latitude, 'longitude': latLng.longitude};
  }
}

@JsonSerializable()
class ChargerModel {
  final String id;
  final String name;
  final String address;
  @LatLngConverter()
  final LatLng location;
  final String hostId;
  final String hostName;
  final double rating;
  final int reviewCount;
  final double power; // kW
  final String connectorType;
  final double pricePerKwh;
  final double pricePerHour;
  final bool isAvailable;
  final String imageUrl;
  final List<String> amenities;
  final Map<String, dynamic> schedule;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ChargerModel({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.hostId,
    required this.hostName,
    required this.rating,
    required this.reviewCount,
    required this.power,
    required this.connectorType,
    required this.pricePerKwh,
    required this.pricePerHour,
    required this.isAvailable,
    required this.imageUrl,
    required this.amenities,
    required this.schedule,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChargerModel.fromJson(Map<String, dynamic> json) =>
      _$ChargerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerModelToJson(this);

  ChargerModel copyWith({
    String? id,
    String? name,
    String? address,
    LatLng? location,
    String? hostId,
    String? hostName,
    double? rating,
    int? reviewCount,
    double? power,
    String? connectorType,
    double? pricePerKwh,
    double? pricePerHour,
    bool? isAvailable,
    String? imageUrl,
    List<String>? amenities,
    Map<String, dynamic>? schedule,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChargerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      hostId: hostId ?? this.hostId,
      hostName: hostName ?? this.hostName,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      power: power ?? this.power,
      connectorType: connectorType ?? this.connectorType,
      pricePerKwh: pricePerKwh ?? this.pricePerKwh,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      isAvailable: isAvailable ?? this.isAvailable,
      imageUrl: imageUrl ?? this.imageUrl,
      amenities: amenities ?? this.amenities,
      schedule: schedule ?? this.schedule,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

enum ConnectorStatus { available, inUse, offline, maintenance }
