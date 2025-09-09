import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

@JsonSerializable()
class BookingModel {
  final String id;
  final String userId;
  final String chargerId;
  final DateTime startTime;
  final DateTime endTime;
  final Duration duration;
  final BookingStatus status;
  final ChargerLocation location;
  final PaymentInfo paymentInfo;
  final VehicleInfo vehicleInfo;
  final BookingPreferences preferences;
  final List<BookingUpdate> updates;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BookingModel({
    required this.id,
    required this.userId,
    required this.chargerId,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.status,
    required this.location,
    required this.paymentInfo,
    required this.vehicleInfo,
    required this.preferences,
    required this.updates,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);
}

@JsonSerializable()
class ChargerLocation {
  final String id;
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;
  final double latitude;
  final double longitude;
  final String zipCode;

  const ChargerLocation({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.zipCode,
  });

  factory ChargerLocation.fromJson(Map<String, dynamic> json) =>
      _$ChargerLocationFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerLocationToJson(this);
}

@JsonSerializable()
class PaymentInfo {
  final String paymentMethodId;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final String? transactionId;
  final DateTime? paidAt;

  const PaymentInfo({
    required this.paymentMethodId,
    required this.amount,
    required this.currency,
    required this.status,
    this.transactionId,
    this.paidAt,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) =>
      _$PaymentInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PaymentInfoToJson(this);
}

@JsonSerializable()
class VehicleInfo {
  final String vehicleId;
  final String make;
  final String model;
  final int year;
  final String licensePlate;
  final double batteryCapacity;
  final String connectorType;

  const VehicleInfo({
    required this.vehicleId,
    required this.make,
    required this.model,
    required this.year,
    required this.licensePlate,
    required this.batteryCapacity,
    required this.connectorType,
  });

  factory VehicleInfo.fromJson(Map<String, dynamic> json) =>
      _$VehicleInfoFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleInfoToJson(this);
}

@JsonSerializable()
class BookingPreferences {
  final double targetBatteryLevel;
  final bool autoStop;
  final bool notifications;
  final String preferredConnector;
  final Map<String, dynamic> customPreferences;

  const BookingPreferences({
    required this.targetBatteryLevel,
    required this.autoStop,
    required this.notifications,
    required this.preferredConnector,
    required this.customPreferences,
  });

  factory BookingPreferences.fromJson(Map<String, dynamic> json) =>
      _$BookingPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$BookingPreferencesToJson(this);
}

@JsonSerializable()
class BookingUpdate {
  final String type;
  final DateTime timestamp;
  final String message;
  final Map<String, dynamic>? data;

  const BookingUpdate({
    required this.type,
    required this.timestamp,
    required this.message,
    this.data,
  });

  factory BookingUpdate.fromJson(Map<String, dynamic> json) =>
      _$BookingUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$BookingUpdateToJson(this);
}

enum BookingStatus { pending, confirmed, active, completed, cancelled, expired }

enum PaymentStatus { pending, processing, completed, failed, refunded }
