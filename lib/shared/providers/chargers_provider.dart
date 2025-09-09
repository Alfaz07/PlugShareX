import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/charger_model.dart' as shared;

final chargersProvider =
    StateNotifierProvider<ChargersNotifier, List<shared.ChargerModel>>((ref) {
  final notifier = ChargersNotifier();
  notifier.loadChargers();
  return notifier;
});

class ChargersNotifier extends StateNotifier<List<shared.ChargerModel>> {
  ChargersNotifier() : super(const []);

  static const String _storageKey = 'chargers_json_v1';

  Future<void> loadChargers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString == null || jsonString.isEmpty) return;
    final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;
    final loaded = decoded
        .map((e) => shared.ChargerModel.fromJson(e as Map<String, dynamic>))
        .toList();
    state = loaded;
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(state.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }

  Future<void> addCharger(shared.ChargerModel charger) async {
    state = [...state, charger];
    await _persist();
  }

  Future<void> toggleAvailability(String chargerId, bool isAvailable) async {
    state = state
        .map(
            (c) => c.id == chargerId ? c.copyWith(isAvailable: isAvailable) : c)
        .toList();
    await _persist();
  }
}

