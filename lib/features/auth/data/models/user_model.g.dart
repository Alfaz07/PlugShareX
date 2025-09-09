// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
      vehicleTypes: (json['vehicleTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      preferences: json['preferences'] as Map<String, dynamic>,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'vehicleTypes': instance.vehicleTypes,
      'preferences': instance.preferences,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zipCode'] as String?,
      country: json['country'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      vehicleTypes: (json['vehicleTypes'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferredPaymentMethod: json['preferredPaymentMethod'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
      totalHostings: (json['totalHostings'] as num?)?.toInt() ?? 0,
      isHostEnabled: json['isHostEnabled'] as bool? ?? false,
      hostProfile: json['hostProfile'] == null
          ? null
          : HostProfile.fromJson(json['hostProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'vehicleTypes': instance.vehicleTypes,
      'preferredPaymentMethod': instance.preferredPaymentMethod,
      'rating': instance.rating,
      'totalBookings': instance.totalBookings,
      'totalHostings': instance.totalHostings,
      'isHostEnabled': instance.isHostEnabled,
      'hostProfile': instance.hostProfile,
    };

HostProfile _$HostProfileFromJson(Map<String, dynamic> json) => HostProfile(
      businessName: json['businessName'] as String?,
      businessType: json['businessType'] as String?,
      chargers: (json['chargers'] as List<dynamic>?)
              ?.map((e) => ChargerInfo.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pricing: (json['pricing'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toDouble()),
          ) ??
          const {},
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      description: json['description'] as String?,
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      availability: AvailabilitySchedule.fromJson(
          json['availability'] as Map<String, dynamic>),
      isVerified: json['isVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$HostProfileToJson(HostProfile instance) =>
    <String, dynamic>{
      'businessName': instance.businessName,
      'businessType': instance.businessType,
      'chargers': instance.chargers,
      'pricing': instance.pricing,
      'amenities': instance.amenities,
      'description': instance.description,
      'photos': instance.photos,
      'availability': instance.availability,
      'isVerified': instance.isVerified,
      'isActive': instance.isActive,
    };

ChargerInfo _$ChargerInfoFromJson(Map<String, dynamic> json) => ChargerInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$ChargerTypeEnumMap, json['type']),
      connectorType: $enumDecode(_$ConnectorTypeEnumMap, json['connectorType']),
      maxPower: (json['maxPower'] as num).toDouble(),
      currentPower: (json['currentPower'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool? ?? true,
      description: json['description'] as String?,
      features: (json['features'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$ChargerInfoToJson(ChargerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': _$ChargerTypeEnumMap[instance.type]!,
      'connectorType': _$ConnectorTypeEnumMap[instance.connectorType]!,
      'maxPower': instance.maxPower,
      'currentPower': instance.currentPower,
      'isAvailable': instance.isAvailable,
      'description': instance.description,
      'features': instance.features,
    };

const _$ChargerTypeEnumMap = {
  ChargerType.level1: 'level1',
  ChargerType.level2: 'level2',
  ChargerType.dcFast: 'dcFast',
  ChargerType.supercharger: 'supercharger',
};

const _$ConnectorTypeEnumMap = {
  ConnectorType.type1: 'type1',
  ConnectorType.type2: 'type2',
  ConnectorType.ccs: 'ccs',
  ConnectorType.chademo: 'chademo',
  ConnectorType.tesla: 'tesla',
  ConnectorType.nacs: 'nacs',
};

AvailabilitySchedule _$AvailabilityScheduleFromJson(
        Map<String, dynamic> json) =>
    AvailabilitySchedule(
      weeklySchedule: (json['weeklySchedule'] as Map<String, dynamic>?)?.map(
            (k, e) =>
                MapEntry(k, DaySchedule.fromJson(e as Map<String, dynamic>)),
          ) ??
          const {},
      blockedDates: (json['blockedDates'] as List<dynamic>?)
              ?.map((e) => DateRange.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      is24x7Available: json['is24x7Available'] as bool? ?? false,
    );

Map<String, dynamic> _$AvailabilityScheduleToJson(
        AvailabilitySchedule instance) =>
    <String, dynamic>{
      'weeklySchedule': instance.weeklySchedule,
      'blockedDates': instance.blockedDates,
      'is24x7Available': instance.is24x7Available,
    };

DaySchedule _$DayScheduleFromJson(Map<String, dynamic> json) => DaySchedule(
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );

Map<String, dynamic> _$DayScheduleToJson(DaySchedule instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'isAvailable': instance.isAvailable,
    };

DateRange _$DateRangeFromJson(Map<String, dynamic> json) => DateRange(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$DateRangeToJson(DateRange instance) => <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'reason': instance.reason,
    };
