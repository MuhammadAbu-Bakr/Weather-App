import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  String _unitSystem = 'metric';
  bool _notificationsEnabled = true;

  bool get isDarkMode => _isDarkMode;
  String get unitSystem => _unitSystem;
  bool get notificationsEnabled => _notificationsEnabled;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    _unitSystem = prefs.getString('unitSystem') ?? 'metric';
    _notificationsEnabled = prefs.getBool('notifications') ?? true;
    notifyListeners();
  }

  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', value);
    notifyListeners();
  }

  Future<void> setUnitSystem(String value) async {
    _unitSystem = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('unitSystem', value);
    notifyListeners();
  }

  Future<void> setNotificationsEnabled(bool value) async {
    _notificationsEnabled = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications', value);
    notifyListeners();
  }

  String formatTemperature(double temperature) {
    if (_unitSystem == 'imperial') {
      return '${((temperature * 9 / 5) + 32).round()}°F';
    }
    return '${temperature.round()}°C';
  }
}
