class UserProfile {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final String? photoURL;
  final String? address;
  final String? bio;
  final DateTime? dateOfBirth;
  final String? gender;
  final VehicleInfo? vehicle;
  final ChargerPreferences? chargerPreferences;
  final bool isHost;
  final bool isVerified;
  final Map<String, String>? securityQuestions; // question -> answer
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.photoURL,
    this.address,
    this.bio,
    this.dateOfBirth,
    this.gender,
    this.vehicle,
    this.chargerPreferences,
    this.isHost = false,
    this.isVerified = false,
    this.securityQuestions,
    required this.createdAt,
    required this.updatedAt,
  });

  String get fullName => '$firstName $lastName';
  String get displayName => fullName;

  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  UserProfile copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? photoURL,
    String? address,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    VehicleInfo? vehicle,
    ChargerPreferences? chargerPreferences,
    bool? isHost,
    bool? isVerified,
    Map<String, String>? securityQuestions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoURL: photoURL ?? this.photoURL,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      vehicle: vehicle ?? this.vehicle,
      chargerPreferences: chargerPreferences ?? this.chargerPreferences,
      isHost: isHost ?? this.isHost,
      isVerified: isVerified ?? this.isVerified,
      securityQuestions: securityQuestions ?? this.securityQuestions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'photoURL': photoURL,
      'address': address,
      'bio': bio,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'vehicle': vehicle?.toJson(),
      'chargerPreferences': chargerPreferences?.toJson(),
      'isHost': isHost,
      'isVerified': isVerified,
      'securityQuestions': securityQuestions,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      photoURL: json['photoURL'] as String?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      gender: json['gender'] as String?,
      vehicle: json['vehicle'] != null
          ? VehicleInfo.fromJson(json['vehicle'] as Map<String, dynamic>)
          : null,
      chargerPreferences: json['chargerPreferences'] != null
          ? ChargerPreferences.fromJson(
              json['chargerPreferences'] as Map<String, dynamic>)
          : null,
      isHost: json['isHost'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      securityQuestions: json['securityQuestions'] != null
          ? Map<String, String>.from(json['securityQuestions'] as Map)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
}

class VehicleInfo {
  final String type;
  final String? make;
  final String? model;
  final String? year;
  final String? batteryCapacity;
  final String? maxChargingRate;

  VehicleInfo({
    required this.type,
    this.make,
    this.model,
    this.year,
    this.batteryCapacity,
    this.maxChargingRate,
  });

  VehicleInfo copyWith({
    String? type,
    String? make,
    String? model,
    String? year,
    String? batteryCapacity,
    String? maxChargingRate,
  }) {
    return VehicleInfo(
      type: type ?? this.type,
      make: make ?? this.make,
      model: model ?? this.model,
      year: year ?? this.year,
      batteryCapacity: batteryCapacity ?? this.batteryCapacity,
      maxChargingRate: maxChargingRate ?? this.maxChargingRate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'make': make,
      'model': model,
      'year': year,
      'batteryCapacity': batteryCapacity,
      'maxChargingRate': maxChargingRate,
    };
  }

  factory VehicleInfo.fromJson(Map<String, dynamic> json) {
    return VehicleInfo(
      type: json['type'] as String,
      make: json['make'] as String?,
      model: json['model'] as String?,
      year: json['year'] as String?,
      batteryCapacity: json['batteryCapacity'] as String?,
      maxChargingRate: json['maxChargingRate'] as String?,
    );
  }

  String get displayName {
    if (type == 'Other' && make != null && model != null) {
      return '$make $model${year != null ? ' ($year)' : ''}';
    }
    return type;
  }
}

class ChargerPreferences {
  final String preferredType;
  final double? maxPricePerKwh;
  final double? maxPricePerHour;
  final bool preferFastCharging;
  final bool preferHomeChargers;
  final List<String> preferredBrands;

  ChargerPreferences({
    required this.preferredType,
    this.maxPricePerKwh,
    this.maxPricePerHour,
    this.preferFastCharging = true,
    this.preferHomeChargers = false,
    this.preferredBrands = const [],
  });

  ChargerPreferences copyWith({
    String? preferredType,
    double? maxPricePerKwh,
    double? maxPricePerHour,
    bool? preferFastCharging,
    bool? preferHomeChargers,
    List<String>? preferredBrands,
  }) {
    return ChargerPreferences(
      preferredType: preferredType ?? this.preferredType,
      maxPricePerKwh: maxPricePerKwh ?? this.maxPricePerKwh,
      maxPricePerHour: maxPricePerHour ?? this.maxPricePerHour,
      preferFastCharging: preferFastCharging ?? this.preferFastCharging,
      preferHomeChargers: preferHomeChargers ?? this.preferHomeChargers,
      preferredBrands: preferredBrands ?? this.preferredBrands,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'preferredType': preferredType,
      'maxPricePerKwh': maxPricePerKwh,
      'maxPricePerHour': maxPricePerHour,
      'preferFastCharging': preferFastCharging,
      'preferHomeChargers': preferHomeChargers,
      'preferredBrands': preferredBrands,
    };
  }

  factory ChargerPreferences.fromJson(Map<String, dynamic> json) {
    return ChargerPreferences(
      preferredType: json['preferredType'] as String,
      maxPricePerKwh: json['maxPricePerKwh'] as double?,
      maxPricePerHour: json['maxPricePerHour'] as double?,
      preferFastCharging: json['preferFastCharging'] as bool? ?? true,
      preferHomeChargers: json['preferHomeChargers'] as bool? ?? false,
      preferredBrands: (json['preferredBrands'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }
}
