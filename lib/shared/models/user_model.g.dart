// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      location: _$JsonConverterFromJson<Map<String, dynamic>, GeoPoint>(
          json['location'], const GeoPointConverter().fromJson),
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      vehicleTypes: (json['vehicleTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      preferences: json['preferences'] as Map<String, dynamic>?,
      isHost: json['isHost'] as bool,
      isVerified: json['isVerified'] as bool,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: (json['reviewCount'] as num).toInt(),
      totalBookings: (json['totalBookings'] as num).toInt(),
      totalEarnings: (json['totalEarnings'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
      'photoURL': instance.photoURL,
      'phoneNumber': instance.phoneNumber,
      'location': _$JsonConverterToJson<Map<String, dynamic>, GeoPoint>(
          instance.location, const GeoPointConverter().toJson),
      'address': instance.address,
      'bio': instance.bio,
      'vehicleTypes': instance.vehicleTypes,
      'preferences': instance.preferences,
      'isHost': instance.isHost,
      'isVerified': instance.isVerified,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'totalBookings': instance.totalBookings,
      'totalEarnings': instance.totalEarnings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
