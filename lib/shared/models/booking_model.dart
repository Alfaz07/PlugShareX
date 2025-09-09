// Firebase temporarily disabled
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'booking_model.g.dart';

// Mock GeoPoint class for development
class GeoPoint {
  final double latitude;
  final double longitude;

  GeoPoint(this.latitude, this.longitude);
}

// Mock GeoPoint converter
class GeoPointConverter implements JsonConverter<GeoPoint, Map<String, dynamic>> {
  const GeoPointConverter();

  @override
  GeoPoint fromJson(Map<String, dynamic> json) {
    return GeoPoint(json['latitude'] as double, json['longitude'] as double);
  }

  @override
  Map<String, dynamic> toJson(GeoPoint geoPoint) {
    return {
      'latitude': geoPoint.latitude,
      'longitude': geoPoint.longitude,
    };
  }
}

@JsonSerializable()
class BookingModel {
  final String id;
  final String userId;
  final String chargerId;
  final String hostId;
  @GeoPointConverter()
  final GeoPoint location;
  final DateTime startTime;
  final DateTime endTime;
  final double duration; // in hours
  final double totalCost;
  final String status; // pending, confirmed, cancelled, completed
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.chargerId,
    required this.hostId,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.duration,
    required this.totalCost,
    required this.status,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  BookingModel copyWith({
    String? id,
    String? userId,
    String? chargerId,
    String? hostId,
    GeoPoint? location,
    DateTime? startTime,
    DateTime? endTime,
    double? duration,
    double? totalCost,
    String? status,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      chargerId: chargerId ?? this.chargerId,
      hostId: hostId ?? this.hostId,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      totalCost: totalCost ?? this.totalCost,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'BookingModel(id: $id, userId: $userId, chargerId: $chargerId, hostId: $hostId, location: $location, startTime: $startTime, endTime: $endTime, duration: $duration, totalCost: $totalCost, status: $status, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingModel &&
        other.id == id &&
        other.userId == userId &&
        other.chargerId == chargerId &&
        other.hostId == hostId &&
        other.location.latitude == location.latitude &&
        other.location.longitude == location.longitude &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.duration == duration &&
        other.totalCost == totalCost &&
        other.status == status &&
        other.notes == notes &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        chargerId.hashCode ^
        hostId.hashCode ^
        location.latitude.hashCode ^
        location.longitude.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        duration.hashCode ^
        totalCost.hashCode ^
        status.hashCode ^
        notes.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode;
  }
}
