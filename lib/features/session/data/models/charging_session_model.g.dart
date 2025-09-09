// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'charging_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChargingSessionModel _$ChargingSessionModelFromJson(
        Map<String, dynamic> json) =>
    ChargingSessionModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      chargerId: json['chargerId'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] == null
          ? null
          : DateTime.parse(json['endTime'] as String),
      duration: json['duration'] == null
          ? null
          : Duration(microseconds: (json['duration'] as num).toInt()),
      chargingData:
          ChargingData.fromJson(json['chargingData'] as Map<String, dynamic>),
      averageChargingPower: (json['averageChargingPower'] as num).toDouble(),
      chargingEfficiency: (json['chargingEfficiency'] as num).toDouble(),
      costBreakdown:
          CostBreakdown.fromJson(json['costBreakdown'] as Map<String, dynamic>),
      status: $enumDecode(_$SessionStatusEnumMap, json['status']),
      events: (json['events'] as List<dynamic>)
          .map((e) => SessionEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
      settings:
          SessionSettings.fromJson(json['settings'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$ChargingSessionModelToJson(
        ChargingSessionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'chargerId': instance.chargerId,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime?.toIso8601String(),
      'duration': instance.duration?.inMicroseconds,
      'chargingData': instance.chargingData,
      'averageChargingPower': instance.averageChargingPower,
      'chargingEfficiency': instance.chargingEfficiency,
      'costBreakdown': instance.costBreakdown,
      'status': _$SessionStatusEnumMap[instance.status]!,
      'events': instance.events,
      'settings': instance.settings,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

const _$SessionStatusEnumMap = {
  SessionStatus.active: 'active',
  SessionStatus.paused: 'paused',
  SessionStatus.stopped: 'stopped',
  SessionStatus.completed: 'completed',
  SessionStatus.error: 'error',
};

ChargingData _$ChargingDataFromJson(Map<String, dynamic> json) => ChargingData(
      totalEnergyDelivered: (json['totalEnergyDelivered'] as num).toDouble(),
      maxPowerReached: (json['maxPowerReached'] as num).toDouble(),
      averagePower: (json['averagePower'] as num).toDouble(),
      powerReadings: (json['powerReadings'] as List<dynamic>)
          .map((e) => PowerReading.fromJson(e as Map<String, dynamic>))
          .toList(),
      chargingCurve:
          ChargingCurve.fromJson(json['chargingCurve'] as Map<String, dynamic>),
      energyMetrics:
          EnergyMetrics.fromJson(json['energyMetrics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChargingDataToJson(ChargingData instance) =>
    <String, dynamic>{
      'totalEnergyDelivered': instance.totalEnergyDelivered,
      'maxPowerReached': instance.maxPowerReached,
      'averagePower': instance.averagePower,
      'powerReadings': instance.powerReadings,
      'chargingCurve': instance.chargingCurve,
      'energyMetrics': instance.energyMetrics,
    };

PowerReading _$PowerReadingFromJson(Map<String, dynamic> json) => PowerReading(
      timestamp: DateTime.parse(json['timestamp'] as String),
      power: (json['power'] as num).toDouble(),
      voltage: (json['voltage'] as num).toDouble(),
      current: (json['current'] as num).toDouble(),
    );

Map<String, dynamic> _$PowerReadingToJson(PowerReading instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp.toIso8601String(),
      'power': instance.power,
      'voltage': instance.voltage,
      'current': instance.current,
    };

ChargingCurve _$ChargingCurveFromJson(Map<String, dynamic> json) =>
    ChargingCurve(
      points: (json['points'] as List<dynamic>)
          .map((e) => CurvePoint.fromJson(e as Map<String, dynamic>))
          .toList(),
      efficiency: (json['efficiency'] as num).toDouble(),
    );

Map<String, dynamic> _$ChargingCurveToJson(ChargingCurve instance) =>
    <String, dynamic>{
      'points': instance.points,
      'efficiency': instance.efficiency,
    };

CurvePoint _$CurvePointFromJson(Map<String, dynamic> json) => CurvePoint(
      batteryLevel: (json['batteryLevel'] as num).toDouble(),
      power: (json['power'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$CurvePointToJson(CurvePoint instance) =>
    <String, dynamic>{
      'batteryLevel': instance.batteryLevel,
      'power': instance.power,
      'timestamp': instance.timestamp.toIso8601String(),
    };

EnergyMetrics _$EnergyMetricsFromJson(Map<String, dynamic> json) =>
    EnergyMetrics(
      totalEnergy: (json['totalEnergy'] as num).toDouble(),
      energyEfficiency: (json['energyEfficiency'] as num).toDouble(),
      carbonFootprint: (json['carbonFootprint'] as num).toDouble(),
      costSavings: (json['costSavings'] as num).toDouble(),
    );

Map<String, dynamic> _$EnergyMetricsToJson(EnergyMetrics instance) =>
    <String, dynamic>{
      'totalEnergy': instance.totalEnergy,
      'energyEfficiency': instance.energyEfficiency,
      'carbonFootprint': instance.carbonFootprint,
      'costSavings': instance.costSavings,
    };

CostBreakdown _$CostBreakdownFromJson(Map<String, dynamic> json) =>
    CostBreakdown(
      energyCost: (json['energyCost'] as num).toDouble(),
      timeCost: (json['timeCost'] as num).toDouble(),
      serviceFee: (json['serviceFee'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      totalCost: (json['totalCost'] as num).toDouble(),
      pricePerKwh: (json['pricePerKwh'] as num).toDouble(),
    );

Map<String, dynamic> _$CostBreakdownToJson(CostBreakdown instance) =>
    <String, dynamic>{
      'energyCost': instance.energyCost,
      'timeCost': instance.timeCost,
      'serviceFee': instance.serviceFee,
      'tax': instance.tax,
      'totalCost': instance.totalCost,
      'pricePerKwh': instance.pricePerKwh,
    };

CostComponent _$CostComponentFromJson(Map<String, dynamic> json) =>
    CostComponent(
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$CostComponentToJson(CostComponent instance) =>
    <String, dynamic>{
      'name': instance.name,
      'amount': instance.amount,
      'currency': instance.currency,
    };

SessionEvent _$SessionEventFromJson(Map<String, dynamic> json) => SessionEvent(
      type: json['type'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      data: json['data'] as Map<String, dynamic>,
      description: json['description'] as String,
    );

Map<String, dynamic> _$SessionEventToJson(SessionEvent instance) =>
    <String, dynamic>{
      'type': instance.type,
      'timestamp': instance.timestamp.toIso8601String(),
      'data': instance.data,
      'description': instance.description,
    };

SessionSettings _$SessionSettingsFromJson(Map<String, dynamic> json) =>
    SessionSettings(
      targetBatteryLevel: (json['targetBatteryLevel'] as num).toDouble(),
      autoStop: json['autoStop'] as bool,
      timeOfUse:
          TimeOfUseSettings.fromJson(json['timeOfUse'] as Map<String, dynamic>),
      preferences: json['preferences'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$SessionSettingsToJson(SessionSettings instance) =>
    <String, dynamic>{
      'targetBatteryLevel': instance.targetBatteryLevel,
      'autoStop': instance.autoStop,
      'timeOfUse': instance.timeOfUse,
      'preferences': instance.preferences,
    };

TimeOfUseSettings _$TimeOfUseSettingsFromJson(Map<String, dynamic> json) =>
    TimeOfUseSettings(
      peakHours: (json['peakHours'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      offPeakHours: (json['offPeakHours'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      rateMultipliers: (json['rateMultipliers'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$TimeOfUseSettingsToJson(TimeOfUseSettings instance) =>
    <String, dynamic>{
      'peakHours': instance.peakHours,
      'offPeakHours': instance.offPeakHours,
      'rateMultipliers': instance.rateMultipliers,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      startHour: (json['startHour'] as num).toInt(),
      endHour: (json['endHour'] as num).toInt(),
      rate: (json['rate'] as num).toDouble(),
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'startHour': instance.startHour,
      'endHour': instance.endHour,
      'rate': instance.rate,
    };
