import 'package:json_annotation/json_annotation.dart';

part 'analytics_model.g.dart';

@JsonSerializable()
class UserAnalytics {
  final String userId;
  final AnalyticsPeriod period;
  final ChargingMetrics chargingMetrics;
  final CostMetrics costMetrics;
  final UsagePatterns usagePatterns;
  final EnvironmentalImpact environmentalImpact;
  final List<AnalyticsRecommendation> recommendations;
  final DateTime generatedAt;

  const UserAnalytics({
    required this.userId,
    required this.period,
    required this.chargingMetrics,
    required this.costMetrics,
    required this.usagePatterns,
    required this.environmentalImpact,
    required this.recommendations,
    required this.generatedAt,
  });

  factory UserAnalytics.fromJson(Map<String, dynamic> json) =>
      _$UserAnalyticsFromJson(json);

  Map<String, dynamic> toJson() => _$UserAnalyticsToJson(this);
}

@JsonSerializable()
class AnalyticsPeriod {
  final DateTime startDate;
  final DateTime endDate;

  const AnalyticsPeriod({
    required this.startDate,
    required this.endDate,
  });

  factory AnalyticsPeriod.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsPeriodFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsPeriodToJson(this);
}

@JsonSerializable()
class ChargingMetrics {
  final int totalSessions;
  final double totalEnergyConsumed;
  final Duration totalChargingTime;
  final Duration averageSessionDuration;
  final double averageEnergyPerSession;
  final double averageChargingPower;
  final double chargingEfficiency;
  final double peakPowerUsed;
  final List<TimeSlot> preferredChargingTimes;
  final List<String> mostUsedChargerTypes;

  const ChargingMetrics({
    required this.totalSessions,
    required this.totalEnergyConsumed,
    required this.totalChargingTime,
    required this.averageSessionDuration,
    required this.averageEnergyPerSession,
    required this.averageChargingPower,
    required this.chargingEfficiency,
    required this.peakPowerUsed,
    required this.preferredChargingTimes,
    required this.mostUsedChargerTypes,
  });

  factory ChargingMetrics.fromJson(Map<String, dynamic> json) =>
      _$ChargingMetricsFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingMetricsToJson(this);
}

@JsonSerializable()
class CostMetrics {
  final double totalSpent;
  final double averageCostPerSession;
  final double averageCostPerKwh;
  final List<CostTrend> costTrends;
  final Map<String, double> costBreakdown;
  final double potentialSavings;

  const CostMetrics({
    required this.totalSpent,
    required this.averageCostPerSession,
    required this.averageCostPerKwh,
    required this.costTrends,
    required this.costBreakdown,
    required this.potentialSavings,
  });

  factory CostMetrics.fromJson(Map<String, dynamic> json) =>
      _$CostMetricsFromJson(json);

  Map<String, dynamic> toJson() => _$CostMetricsToJson(this);
}

@JsonSerializable()
class UsagePatterns {
  final List<TimeSlot> preferredChargingTimes;
  final List<String> preferredChargerTypes;
  final Map<String, int> locationPreferences;
  final double averageSessionDuration;
  final int sessionsPerWeek;

  const UsagePatterns({
    required this.preferredChargingTimes,
    required this.preferredChargerTypes,
    required this.locationPreferences,
    required this.averageSessionDuration,
    required this.sessionsPerWeek,
  });

  factory UsagePatterns.fromJson(Map<String, dynamic> json) =>
      _$UsagePatternsFromJson(json);

  Map<String, dynamic> toJson() => _$UsagePatternsToJson(this);
}

@JsonSerializable()
class EnvironmentalImpact {
  final double co2Saved;
  final double treesEquivalent;
  final double gasolineEquivalent;
  final double renewableEnergyPercentage;

  const EnvironmentalImpact({
    required this.co2Saved,
    required this.treesEquivalent,
    required this.gasolineEquivalent,
    required this.renewableEnergyPercentage,
  });

  factory EnvironmentalImpact.fromJson(Map<String, dynamic> json) =>
      _$EnvironmentalImpactFromJson(json);

  Map<String, dynamic> toJson() => _$EnvironmentalImpactToJson(this);
}

@JsonSerializable()
class AnalyticsRecommendation {
  final String title;
  final String description;
  final String type;
  final double potentialSavings;
  final List<String> actions;

  const AnalyticsRecommendation({
    required this.title,
    required this.description,
    required this.type,
    required this.potentialSavings,
    required this.actions,
  });

  factory AnalyticsRecommendation.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsRecommendationFromJson(json);

  Map<String, dynamic> toJson() => _$AnalyticsRecommendationToJson(this);
}

@JsonSerializable()
class CostTrend {
  final DateTime date;
  final double cost;
  final double energy;

  const CostTrend({
    required this.date,
    required this.cost,
    required this.energy,
  });

  factory CostTrend.fromJson(Map<String, dynamic> json) =>
      _$CostTrendFromJson(json);

  Map<String, dynamic> toJson() => _$CostTrendToJson(this);
}

@JsonSerializable()
class TimeSlot {
  final int hour;
  final int minute;
  final int duration;

  const TimeSlot({
    required this.hour,
    required this.minute,
    required this.duration,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

@JsonSerializable()
class ChargingFrequency {
  final int sessionsThisWeek;
  final int sessionsLastWeek;
  final double weeklyAverage;
  final List<int> dailyBreakdown;

  const ChargingFrequency({
    required this.sessionsThisWeek,
    required this.sessionsLastWeek,
    required this.weeklyAverage,
    required this.dailyBreakdown,
  });

  factory ChargingFrequency.fromJson(Map<String, dynamic> json) =>
      _$ChargingFrequencyFromJson(json);

  Map<String, dynamic> toJson() => _$ChargingFrequencyToJson(this);
}
