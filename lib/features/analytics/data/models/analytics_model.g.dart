// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAnalytics _$UserAnalyticsFromJson(Map<String, dynamic> json) =>
    UserAnalytics(
      userId: json['userId'] as String,
      period: AnalyticsPeriod.fromJson(json['period'] as Map<String, dynamic>),
      chargingMetrics: ChargingMetrics.fromJson(
          json['chargingMetrics'] as Map<String, dynamic>),
      costMetrics:
          CostMetrics.fromJson(json['costMetrics'] as Map<String, dynamic>),
      usagePatterns:
          UsagePatterns.fromJson(json['usagePatterns'] as Map<String, dynamic>),
      environmentalImpact: EnvironmentalImpact.fromJson(
          json['environmentalImpact'] as Map<String, dynamic>),
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) =>
              AnalyticsRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      generatedAt: DateTime.parse(json['generatedAt'] as String),
    );

Map<String, dynamic> _$UserAnalyticsToJson(UserAnalytics instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'period': instance.period,
      'chargingMetrics': instance.chargingMetrics,
      'costMetrics': instance.costMetrics,
      'usagePatterns': instance.usagePatterns,
      'environmentalImpact': instance.environmentalImpact,
      'recommendations': instance.recommendations,
      'generatedAt': instance.generatedAt.toIso8601String(),
    };

AnalyticsPeriod _$AnalyticsPeriodFromJson(Map<String, dynamic> json) =>
    AnalyticsPeriod(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$AnalyticsPeriodToJson(AnalyticsPeriod instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
    };

ChargingMetrics _$ChargingMetricsFromJson(Map<String, dynamic> json) =>
    ChargingMetrics(
      totalSessions: (json['totalSessions'] as num).toInt(),
      totalEnergyConsumed: (json['totalEnergyConsumed'] as num).toDouble(),
      totalChargingTime:
          Duration(microseconds: (json['totalChargingTime'] as num).toInt()),
      averageSessionDuration: Duration(
          microseconds: (json['averageSessionDuration'] as num).toInt()),
      averageEnergyPerSession:
          (json['averageEnergyPerSession'] as num).toDouble(),
      averageChargingPower: (json['averageChargingPower'] as num).toDouble(),
      chargingEfficiency: (json['chargingEfficiency'] as num).toDouble(),
      peakPowerUsed: (json['peakPowerUsed'] as num).toDouble(),
      preferredChargingTimes: (json['preferredChargingTimes'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      mostUsedChargerTypes: (json['mostUsedChargerTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ChargingMetricsToJson(ChargingMetrics instance) =>
    <String, dynamic>{
      'totalSessions': instance.totalSessions,
      'totalEnergyConsumed': instance.totalEnergyConsumed,
      'totalChargingTime': instance.totalChargingTime.inMicroseconds,
      'averageSessionDuration': instance.averageSessionDuration.inMicroseconds,
      'averageEnergyPerSession': instance.averageEnergyPerSession,
      'averageChargingPower': instance.averageChargingPower,
      'chargingEfficiency': instance.chargingEfficiency,
      'peakPowerUsed': instance.peakPowerUsed,
      'preferredChargingTimes': instance.preferredChargingTimes,
      'mostUsedChargerTypes': instance.mostUsedChargerTypes,
    };

CostMetrics _$CostMetricsFromJson(Map<String, dynamic> json) => CostMetrics(
      totalSpent: (json['totalSpent'] as num).toDouble(),
      averageCostPerSession: (json['averageCostPerSession'] as num).toDouble(),
      averageCostPerKwh: (json['averageCostPerKwh'] as num).toDouble(),
      costTrends: (json['costTrends'] as List<dynamic>)
          .map((e) => CostTrend.fromJson(e as Map<String, dynamic>))
          .toList(),
      costBreakdown: (json['costBreakdown'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      potentialSavings: (json['potentialSavings'] as num).toDouble(),
    );

Map<String, dynamic> _$CostMetricsToJson(CostMetrics instance) =>
    <String, dynamic>{
      'totalSpent': instance.totalSpent,
      'averageCostPerSession': instance.averageCostPerSession,
      'averageCostPerKwh': instance.averageCostPerKwh,
      'costTrends': instance.costTrends,
      'costBreakdown': instance.costBreakdown,
      'potentialSavings': instance.potentialSavings,
    };

UsagePatterns _$UsagePatternsFromJson(Map<String, dynamic> json) =>
    UsagePatterns(
      preferredChargingTimes: (json['preferredChargingTimes'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      preferredChargerTypes: (json['preferredChargerTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      locationPreferences:
          Map<String, int>.from(json['locationPreferences'] as Map),
      averageSessionDuration:
          (json['averageSessionDuration'] as num).toDouble(),
      sessionsPerWeek: (json['sessionsPerWeek'] as num).toInt(),
    );

Map<String, dynamic> _$UsagePatternsToJson(UsagePatterns instance) =>
    <String, dynamic>{
      'preferredChargingTimes': instance.preferredChargingTimes,
      'preferredChargerTypes': instance.preferredChargerTypes,
      'locationPreferences': instance.locationPreferences,
      'averageSessionDuration': instance.averageSessionDuration,
      'sessionsPerWeek': instance.sessionsPerWeek,
    };

EnvironmentalImpact _$EnvironmentalImpactFromJson(Map<String, dynamic> json) =>
    EnvironmentalImpact(
      co2Saved: (json['co2Saved'] as num).toDouble(),
      treesEquivalent: (json['treesEquivalent'] as num).toDouble(),
      gasolineEquivalent: (json['gasolineEquivalent'] as num).toDouble(),
      renewableEnergyPercentage:
          (json['renewableEnergyPercentage'] as num).toDouble(),
    );

Map<String, dynamic> _$EnvironmentalImpactToJson(
        EnvironmentalImpact instance) =>
    <String, dynamic>{
      'co2Saved': instance.co2Saved,
      'treesEquivalent': instance.treesEquivalent,
      'gasolineEquivalent': instance.gasolineEquivalent,
      'renewableEnergyPercentage': instance.renewableEnergyPercentage,
    };

AnalyticsRecommendation _$AnalyticsRecommendationFromJson(
        Map<String, dynamic> json) =>
    AnalyticsRecommendation(
      title: json['title'] as String,
      description: json['description'] as String,
      type: json['type'] as String,
      potentialSavings: (json['potentialSavings'] as num).toDouble(),
      actions:
          (json['actions'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AnalyticsRecommendationToJson(
        AnalyticsRecommendation instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'potentialSavings': instance.potentialSavings,
      'actions': instance.actions,
    };

CostTrend _$CostTrendFromJson(Map<String, dynamic> json) => CostTrend(
      date: DateTime.parse(json['date'] as String),
      cost: (json['cost'] as num).toDouble(),
      energy: (json['energy'] as num).toDouble(),
    );

Map<String, dynamic> _$CostTrendToJson(CostTrend instance) => <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'cost': instance.cost,
      'energy': instance.energy,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      hour: (json['hour'] as num).toInt(),
      minute: (json['minute'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'hour': instance.hour,
      'minute': instance.minute,
      'duration': instance.duration,
    };

ChargingFrequency _$ChargingFrequencyFromJson(Map<String, dynamic> json) =>
    ChargingFrequency(
      sessionsThisWeek: (json['sessionsThisWeek'] as num).toInt(),
      sessionsLastWeek: (json['sessionsLastWeek'] as num).toInt(),
      weeklyAverage: (json['weeklyAverage'] as num).toDouble(),
      dailyBreakdown: (json['dailyBreakdown'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$ChargingFrequencyToJson(ChargingFrequency instance) =>
    <String, dynamic>{
      'sessionsThisWeek': instance.sessionsThisWeek,
      'sessionsLastWeek': instance.sessionsLastWeek,
      'weeklyAverage': instance.weeklyAverage,
      'dailyBreakdown': instance.dailyBreakdown,
    };
