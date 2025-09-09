import 'package:json_annotation/json_annotation.dart';

part 'charging_session_model.g.dart';

@JsonSerializable()
class ChargingSessionModel {
  final String id;
  final String userId;
  final String chargerId;
  final DateTime startTime;
  final DateTime? endTime;
  final Duration? duration;
  final ChargingData chargingData;
  final double averageChargingPower;
  final double chargingEfficiency;
  final CostBreakdown costBreakdown;
  final SessionStatus status;
  final List<SessionEvent> events;
  final SessionSettings settings;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ChargingSessionModel({
    required this.id,
    required this.userId,
    required this.chargerId,
    required this.startTime,
    this.endTime,
    this.duration,
    required this.chargingData,
    required this.averageChargingPower,
    required this.chargingEfficiency,
    required this.costBreakdown,
    required this.status,
    required this.events,
    required this.settings,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChargingSessionModel.fromJson(Map<String, dynamic> json) =>
      _$ChargingSessionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingSessionModelToJson(this);
}

@JsonSerializable()
class ChargingData {
  final double totalEnergyDelivered;
  final double maxPowerReached;
  final double averagePower;
  final List<PowerReading> powerReadings;
  final ChargingCurve chargingCurve;
  final EnergyMetrics energyMetrics;

  const ChargingData({
    required this.totalEnergyDelivered,
    required this.maxPowerReached,
    required this.averagePower,
    required this.powerReadings,
    required this.chargingCurve,
    required this.energyMetrics,
  });

  factory ChargingData.fromJson(Map<String, dynamic> json) =>
      _$ChargingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingDataToJson(this);
}

@JsonSerializable()
class PowerReading {
  final DateTime timestamp;
  final double power;
  final double voltage;
  final double current;

  const PowerReading({
    required this.timestamp,
    required this.power,
    required this.voltage,
    required this.current,
  });

  factory PowerReading.fromJson(Map<String, dynamic> json) =>
      _$PowerReadingFromJson(json);

  Map<String, dynamic> toJson() => _$PowerReadingToJson(this);
}

@JsonSerializable()
class ChargingCurve {
  final List<CurvePoint> points;
  final double efficiency;

  const ChargingCurve({
    required this.points,
    required this.efficiency,
  });

  factory ChargingCurve.fromJson(Map<String, dynamic> json) =>
      _$ChargingCurveFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingCurveToJson(this);
}

@JsonSerializable()
class CurvePoint {
  final double batteryLevel;
  final double power;
  final DateTime timestamp;

  const CurvePoint({
    required this.batteryLevel,
    required this.power,
    required this.timestamp,
  });

  factory CurvePoint.fromJson(Map<String, dynamic> json) =>
      _$CurvePointFromJson(json);

  Map<String, dynamic> toJson() => _$CurvePointToJson(this);
}

@JsonSerializable()
class EnergyMetrics {
  final double totalEnergy;
  final double energyEfficiency;
  final double carbonFootprint;
  final double costSavings;

  const EnergyMetrics({
    required this.totalEnergy,
    required this.energyEfficiency,
    required this.carbonFootprint,
    required this.costSavings,
  });

  factory EnergyMetrics.fromJson(Map<String, dynamic> json) =>
      _$EnergyMetricsFromJson(json);

  Map<String, dynamic> toJson() => _$EnergyMetricsToJson(this);
}

@JsonSerializable()
class CostBreakdown {
  final double energyCost;
  final double timeCost;
  final double serviceFee;
  final double tax;
  final double totalCost;
  final double pricePerKwh;

  const CostBreakdown({
    required this.energyCost,
    required this.timeCost,
    required this.serviceFee,
    required this.tax,
    required this.totalCost,
    required this.pricePerKwh,
  });

  factory CostBreakdown.fromJson(Map<String, dynamic> json) =>
      _$CostBreakdownFromJson(json);

  Map<String, dynamic> toJson() => _$CostBreakdownToJson(this);
}

@JsonSerializable()
class CostComponent {
  final String name;
  final double amount;
  final String currency;

  const CostComponent({
    required this.name,
    required this.amount,
    required this.currency,
  });

  factory CostComponent.fromJson(Map<String, dynamic> json) =>
      _$CostComponentFromJson(json);

  Map<String, dynamic> toJson() => _$CostComponentToJson(this);
}

@JsonSerializable()
class SessionEvent {
  final String type;
  final DateTime timestamp;
  final Map<String, dynamic> data;
  final String description;

  const SessionEvent({
    required this.type,
    required this.timestamp,
    required this.data,
    required this.description,
  });

  factory SessionEvent.fromJson(Map<String, dynamic> json) =>
      _$SessionEventFromJson(json);

  Map<String, dynamic> toJson() => _$SessionEventToJson(this);
}

@JsonSerializable()
class SessionSettings {
  final double targetBatteryLevel;
  final bool autoStop;
  final TimeOfUseSettings timeOfUse;
  final Map<String, dynamic> preferences;

  const SessionSettings({
    required this.targetBatteryLevel,
    required this.autoStop,
    required this.timeOfUse,
    required this.preferences,
  });

  factory SessionSettings.fromJson(Map<String, dynamic> json) =>
      _$SessionSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionSettingsToJson(this);
}

@JsonSerializable()
class TimeOfUseSettings {
  final List<TimeSlot> peakHours;
  final List<TimeSlot> offPeakHours;
  final Map<String, double> rateMultipliers;

  const TimeOfUseSettings({
    required this.peakHours,
    required this.offPeakHours,
    required this.rateMultipliers,
  });

  factory TimeOfUseSettings.fromJson(Map<String, dynamic> json) =>
      _$TimeOfUseSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$TimeOfUseSettingsToJson(this);
}

@JsonSerializable()
class TimeSlot {
  final int startHour;
  final int endHour;
  final double rate;

  const TimeSlot({
    required this.startHour,
    required this.endHour,
    required this.rate,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

enum SessionStatus { active, paused, stopped, completed, error }
