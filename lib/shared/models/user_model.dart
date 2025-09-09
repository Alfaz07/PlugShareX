// Firebase temporarily disabled
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

// Mock GeoPoint class for development (same as in other models)
class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);
}

// Mock GeoPoint converter
class GeoPointConverter
    implements JsonConverter<GeoPoint, Map<String, dynamic>> {
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
class UserModel {
  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
  final String? phoneNumber;
  @GeoPointConverter()
  final GeoPoint? location;
  final String? address;
  final String? bio;
  final List<String>? vehicleTypes;
  final Map<String, dynamic>? preferences;
  final bool isHost;
  final bool isVerified;
  final double rating;
  final int reviewCount;
  final int totalBookings;
  final int totalEarnings;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    this.phoneNumber,
    this.location,
    this.address,
    this.bio,
    this.vehicleTypes,
    this.preferences,
    required this.isHost,
    required this.isVerified,
    required this.rating,
    required this.reviewCount,
    required this.totalBookings,
    required this.totalEarnings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? photoURL,
    String? phoneNumber,
    GeoPoint? location,
    String? address,
    String? bio,
    List<String>? vehicleTypes,
    Map<String, dynamic>? preferences,
    bool? isHost,
    bool? isVerified,
    double? rating,
    int? reviewCount,
    int? totalBookings,
    int? totalEarnings,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
      preferences: preferences ?? this.preferences,
      isHost: isHost ?? this.isHost,
      isVerified: isVerified ?? this.isVerified,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      totalBookings: totalBookings ?? this.totalBookings,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, photoURL: $photoURL, phoneNumber: $phoneNumber, location: $location, address: $address, bio: $bio, vehicleTypes: $vehicleTypes, preferences: $preferences, isHost: $isHost, isVerified: $isVerified, rating: $rating, reviewCount: $reviewCount, totalBookings: $totalBookings, totalEarnings: $totalEarnings, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.displayName == displayName &&
        other.photoURL == photoURL &&
        other.phoneNumber == phoneNumber &&
        other.location?.latitude == location?.latitude &&
        other.location?.longitude == location?.longitude &&
        other.address == address &&
        other.bio == bio &&
        other.vehicleTypes == vehicleTypes &&
        other.preferences == preferences &&
        other.isHost == isHost &&
        other.isVerified == isVerified &&
        other.rating == rating &&
        other.reviewCount == reviewCount &&
        other.totalBookings == totalBookings &&
        other.totalEarnings == totalEarnings &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        displayName.hashCode ^
        photoURL.hashCode ^
        phoneNumber.hashCode ^
        (location?.latitude.hashCode ?? 0) ^
        (location?.longitude.hashCode ?? 0) ^
        address.hashCode ^
        bio.hashCode ^
        vehicleTypes.hashCode ^
        preferences.hashCode ^
        isHost.hashCode ^
        isVerified.hashCode ^
        rating.hashCode ^
        reviewCount.hashCode ^
        totalBookings.hashCode ^
        totalEarnings.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
