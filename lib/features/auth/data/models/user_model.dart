import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String email;
  final String name;
  final String? profileImageUrl;
  final List<String> vehicleTypes;
  final Map<String, dynamic> preferences;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    this.profileImageUrl,
    required this.vehicleTypes,
    required this.preferences,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}

@JsonSerializable()
class UserProfile {
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final double? latitude;
  final double? longitude;
  final List<String> vehicleTypes;
  final String? preferredPaymentMethod;
  final double rating;
  final int totalBookings;
  final int totalHostings;
  final bool isHostEnabled;
  final HostProfile? hostProfile;

  const UserProfile({
    this.firstName,
    this.lastName,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.latitude,
    this.longitude,
    this.vehicleTypes = const [],
    this.preferredPaymentMethod,
    this.rating = 0.0,
    this.totalBookings = 0,
    this.totalHostings = 0,
    this.isHostEnabled = false,
    this.hostProfile,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  UserProfile copyWith({
    String? firstName,
    String? lastName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    double? latitude,
    double? longitude,
    List<String>? vehicleTypes,
    String? preferredPaymentMethod,
    double? rating,
    int? totalBookings,
    int? totalHostings,
    bool? isHostEnabled,
    HostProfile? hostProfile,
  }) {
    return UserProfile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      vehicleTypes: vehicleTypes ?? this.vehicleTypes,
      preferredPaymentMethod:
          preferredPaymentMethod ?? this.preferredPaymentMethod,
      rating: rating ?? this.rating,
      totalBookings: totalBookings ?? this.totalBookings,
      totalHostings: totalHostings ?? this.totalHostings,
      isHostEnabled: isHostEnabled ?? this.isHostEnabled,
      hostProfile: hostProfile ?? this.hostProfile,
    );
  }
}

@JsonSerializable()
class HostProfile {
  final String? businessName;
  final String? businessType;
  final List<ChargerInfo> chargers;
  final Map<String, double> pricing;
  final List<String> amenities;
  final String? description;
  final List<String> photos;
  final AvailabilitySchedule availability;
  final bool isVerified;
  final bool isActive;

  const HostProfile({
    this.businessName,
    this.businessType,
    this.chargers = const [],
    this.pricing = const {},
    this.amenities = const [],
    this.description,
    this.photos = const [],
    required this.availability,
    this.isVerified = false,
    this.isActive = true,
  });

  factory HostProfile.fromJson(Map<String, dynamic> json) =>
      _$HostProfileFromJson(json);

  Map<String, dynamic> toJson() => _$HostProfileToJson(this);
}

@JsonSerializable()
class ChargerInfo {
  final String id;
  final String name;
  final ChargerType type;
  final ConnectorType connectorType;
  final double maxPower;
  final double currentPower;
  final bool isAvailable;
  final String? description;
  final List<String> features;

  const ChargerInfo({
    required this.id,
    required this.name,
    required this.type,
    required this.connectorType,
    required this.maxPower,
    required this.currentPower,
    this.isAvailable = true,
    this.description,
    this.features = const [],
  });

  factory ChargerInfo.fromJson(Map<String, dynamic> json) =>
      _$ChargerInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ChargerInfoToJson(this);
}

@JsonSerializable()
class AvailabilitySchedule {
  final Map<String, DaySchedule> weeklySchedule;
  final List<DateRange> blockedDates;
  final bool is24x7Available;

  const AvailabilitySchedule({
    this.weeklySchedule = const {},
    this.blockedDates = const [],
    this.is24x7Available = false,
  });

  factory AvailabilitySchedule.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityScheduleToJson(this);
}

@JsonSerializable()
class DaySchedule {
  final String startTime;
  final String endTime;
  final bool isAvailable;

  const DaySchedule({
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });

  factory DaySchedule.fromJson(Map<String, dynamic> json) =>
      _$DayScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$DayScheduleToJson(this);
}

@JsonSerializable()
class DateRange {
  final DateTime startDate;
  final DateTime endDate;
  final String? reason;

  const DateRange({
    required this.startDate,
    required this.endDate,
    this.reason,
  });

  factory DateRange.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFromJson(json);

  Map<String, dynamic> toJson() => _$DateRangeToJson(this);
}

enum UserType {
  @JsonValue('user')
  user,
  @JsonValue('host')
  host,
  @JsonValue('both')
  both,
  @JsonValue('admin')
  admin,
}

enum ChargerType {
  @JsonValue('level1')
  level1,
  @JsonValue('level2')
  level2,
  @JsonValue('dcFast')
  dcFast,
  @JsonValue('supercharger')
  supercharger,
}

enum ConnectorType {
  @JsonValue('type1')
  type1,
  @JsonValue('type2')
  type2,
  @JsonValue('ccs')
  ccs,
  @JsonValue('chademo')
  chademo,
  @JsonValue('tesla')
  tesla,
  @JsonValue('nacs')
  nacs,
}
