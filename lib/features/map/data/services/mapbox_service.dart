import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/config/mapbox_config.dart';

class MapboxService {
  static MapboxMapController? _mapController;

  static MapboxMapController? get mapController => _mapController;

  static void setMapController(MapboxMapController controller) {
    _mapController = controller;
  }

  // Get current location
  static Future<LatLng?> getCurrentLocation() async {
    try {
      // Check permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return null;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }

  // Animate to location
  static Future<void> animateToLocation(LatLng location) async {
    if (_mapController != null) {
      await _mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(location, MapboxConfig.defaultZoom),
      );
    }
  }

  // Add charger markers
  static Future<void> addChargerMarkers(List<ChargerMarker> chargers) async {
    if (_mapController == null) return;

    for (var charger in chargers) {
      await _mapController!.addSymbol(
        SymbolOptions(
          geometry: charger.location,
          iconImage: 'charging-station', // You'll need to add this icon
          iconSize: 1.5,
          iconColor: charger.isAvailable ? '#00FF00' : '#FF0000',
          textField: charger.name,
          textOffset: [0, 1.5],
          textSize: 12,
        ),
        {
          'id': charger.id,
          'name': charger.name,
          'isAvailable': charger.isAvailable,
          'power': charger.power,
          'price': charger.price,
        },
      );
    }
  }

  // Clear all markers
  static Future<void> clearMarkers() async {
    if (_mapController != null) {
      await _mapController!.clearSymbols();
    }
  }
}

class ChargerMarker {
  final String id;
  final String name;
  final LatLng location;
  final bool isAvailable;
  final String power;
  final String price;

  ChargerMarker({
    required this.id,
    required this.name,
    required this.location,
    required this.isAvailable,
    required this.power,
    required this.price,
  });
}
