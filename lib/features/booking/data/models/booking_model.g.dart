// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      chargerId: json['chargerId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      duration: Duration(microseconds: (json['duration'] as num).toInt()),
      status: $enumDecode(_$BookingStatusEnumMap, json['status']),
      location:
          ChargerLocation.fromJson(json['location'] as Map<String, dynamic>),
      paymentInfo:
          PaymentInfo.fromJson(json['paymentInfo'] as Map<String, dynamic>),
      vehicleInfo:
          VehicleInfo.fromJson(json['vehicleInfo'] as Map<String, dynamic>),
      preferences: BookingPreferences.fromJson(
          json['preferences'] as Map<String, dynamic>),
      updates: (json['updates'] as List<dynamic>)
          .map((e) => BookingUpdate.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'chargerId': instance.chargerId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'duration': instance.duration.inMicroseconds,
      'status': _$BookingStatusEnumMap[instance.status]!,
      'location': instance.location,
      'paymentInfo': instance.paymentInfo,
      'vehicleInfo': instance.vehicleInfo,
      'preferences': instance.preferences,
      'updates': instance.updates,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$BookingStatusEnumMap = {
  BookingStatus.pending: 'pending',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.active: 'active',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
  BookingStatus.expired: 'expired',
};

ChargerLocation _$ChargerLocationFromJson(Map<String, dynamic> json) =>
    ChargerLocation(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      zipCode: json['zipCode'] as String,
    );

Map<String, dynamic> _$ChargerLocationToJson(ChargerLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'zipCode': instance.zipCode,
    };

PaymentInfo _$PaymentInfoFromJson(Map<String, dynamic> json) => PaymentInfo(
      paymentMethodId: json['paymentMethodId'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      status: $enumDecode(_$PaymentStatusEnumMap, json['status']),
      transactionId: json['transactionId'] as String?,
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
    );

Map<String, dynamic> _$PaymentInfoToJson(PaymentInfo instance) =>
    <String, dynamic>{
      'paymentMethodId': instance.paymentMethodId,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'transactionId': instance.transactionId,
      'paidAt': instance.paidAt?.toIso8601String(),
    };

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.failed: 'failed',
  PaymentStatus.refunded: 'refunded',
};

VehicleInfo _$VehicleInfoFromJson(Map<String, dynamic> json) => VehicleInfo(
      vehicleId: json['vehicleId'] as String,
      make: json['make'] as String,
      model: json['model'] as String,
      year: (json['year'] as num).toInt(),
      licensePlate: json['licensePlate'] as String,
      batteryCapacity: (json['batteryCapacity'] as num).toDouble(),
      connectorType: json['connectorType'] as String,
    );

Map<String, dynamic> _$VehicleInfoToJson(VehicleInfo instance) =>
    <String, dynamic>{
      'vehicleId': instance.vehicleId,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'licensePlate': instance.licensePlate,
      'batteryCapacity': instance.batteryCapacity,
      'connectorType': instance.connectorType,
    };

BookingPreferences _$BookingPreferencesFromJson(Map<String, dynamic> json) =>
    BookingPreferences(
      targetBatteryLevel: (json['targetBatteryLevel'] as num).toDouble(),
      autoStop: json['autoStop'] as bool,
      notifications: json['notifications'] as bool,
      preferredConnector: json['preferredConnector'] as String,
      customPreferences: json['customPreferences'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$BookingPreferencesToJson(BookingPreferences instance) =>
    <String, dynamic>{
      'targetBatteryLevel': instance.targetBatteryLevel,
      'autoStop': instance.autoStop,
      'notifications': instance.notifications,
      'preferredConnector': instance.preferredConnector,
      'customPreferences': instance.customPreferences,
    };

BookingUpdate _$BookingUpdateFromJson(Map<String, dynamic> json) =>
    BookingUpdate(
      type: json['type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BookingUpdateToJson(BookingUpdate instance) =>
    <String, dynamic>{
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
      'message': instance.message,
      'data': instance.data,
    };
