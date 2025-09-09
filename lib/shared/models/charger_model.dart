// Firebase temporarily disabled
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'charger_model.g.dart';

// Mock GeoPoint class for development (same as in booking_model.dart)
class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);
}

// Mock GeoPoint converter
class GeoPointConverter implements JsonConverter<GeoPoint, Map<String, dynamic>> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(json['latitude'] as double, json['longitude'] as double);
  }

  @override
  Map<String, dynamic> toJson(GeoPoint geoPoint) {
    return {
      'latitude': geoPoint.latitude,
      'longitude': geoPoint.longitude,
    };
  }
}

@JsonSerializable()
class ChargerModel {
  final String id;
  final String hostId;
  final String name;
  final String address;
  @GeoPointConverter()
  final GeoPoint location;
  final String chargerType; // Type 1, Type 2, CCS, etc.
  final String connectorType; // AC Single Phase, AC Three Phase, DC Fast
  final double powerOutput; // in kW
  final double pricePerKwh;
  final double pricePerHour;
  final bool isAvailable;
  final String? description;
  final List<String> images;
  final double rating;
  final int reviewCount;
  final Map<String, dynamic>? specifications;
  final List<String>? amenities;
  final DateTime createdAt;
  final DateTime updatedAt;

  ChargerModel({
    required this.id,
    required this.hostId,
    required this.name,
    required this.address,
    required this.location,
    required this.chargerType,
    required this.connectorType,
    required this.powerOutput,
    required this.pricePerKwh,
    required this.pricePerHour,
    required this.isAvailable,
    this.description,
    required this.images,
    required this.rating,
    required this.reviewCount,
    this.specifications,
    this.amenities,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChargerModel.fromJson(Map<String, dynamic> json) =>
      _$ChargerModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerModelToJson(this);

  ChargerModel copyWith({
    String? id,
    String? hostId,
    String? name,
    String? address,
    GeoPoint? location,
    String? chargerType,
    String? connectorType,
    double? powerOutput,
    double? pricePerKwh,
    double? pricePerHour,
    bool? isAvailable,
    String? description,
    List<String>? images,
    double? rating,
    int? reviewCount,
    Map<String, dynamic>? specifications,
    List<String>? amenities,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChargerModel(
      id: id ?? this.id,
      hostId: hostId ?? this.hostId,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      chargerType: chargerType ?? this.chargerType,
      connectorType: connectorType ?? this.connectorType,
      powerOutput: powerOutput ?? this.powerOutput,
      pricePerKwh: pricePerKwh ?? this.pricePerKwh,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
      images: images ?? this.images,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      specifications: specifications ?? this.specifications,
      amenities: amenities ?? this.amenities,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'ChargerModel(id: $id, hostId: $hostId, name: $name, address: $address, location: $location, chargerType: $chargerType, connectorType: $connectorType, powerOutput: $powerOutput, pricePerKwh: $pricePerKwh, pricePerHour: $pricePerHour, isAvailable: $isAvailable, description: $description, images: $images, rating: $rating, reviewCount: $reviewCount, specifications: $specifications, amenities: $amenities, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChargerModel &&
        other.id == id &&
        other.hostId == hostId &&
        other.name == name &&
        other.address == address &&
        other.location.latitude == location.latitude &&
        other.location.longitude == location.longitude &&
        other.chargerType == chargerType &&
        other.connectorType == connectorType &&
        other.powerOutput == powerOutput &&
        other.pricePerKwh == pricePerKwh &&
        other.pricePerHour == pricePerHour &&
        other.isAvailable == isAvailable &&
        other.description == description &&
        other.images == images &&
        other.rating == rating &&
        other.reviewCount == reviewCount &&
        other.specifications == specifications &&
        other.amenities == amenities &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        hostId.hashCode ^
        name.hashCode ^
        address.hashCode ^
        location.latitude.hashCode ^
        location.longitude.hashCode ^
        chargerType.hashCode ^
        connectorType.hashCode ^
        powerOutput.hashCode ^
        pricePerKwh.hashCode ^
        pricePerHour.hashCode ^
        isAvailable.hashCode ^
        description.hashCode ^
        images.hashCode ^
        rating.hashCode ^
        reviewCount.hashCode ^
        specifications.hashCode ^
        amenities.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
