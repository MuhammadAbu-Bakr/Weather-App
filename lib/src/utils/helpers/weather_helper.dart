import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants/app_constants.dart';

class WeatherHelper {
  
  static String getWeatherIcon(String conditionCode) {
    return 'assets/icons/${AppConstants.weatherConditions[conditionCode] ?? 'unknown'}.svg';
  }

  
  static Color getWeatherBackgroundColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return Colors.amber.shade100;
      case 'clouds':
        return Colors.blueGrey.shade100;
      case 'rain':
        return Colors.blue.shade100;
      case 'snow':
        return Colors.blue.shade50;
      case 'thunderstorm':
        return Colors.indigo.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  
  static String formatTemperature(double temp, String unit) {
    return '${temp.round()}°${unit == 'metric' ? 'C' : 'F'}';
  }

  
  static String formatWindSpeed(double speed, String unit) {
    return unit == 'metric'
        ? '${speed.toStringAsFixed(1)} km/h'
        : '${(speed * 0.621371).toStringAsFixed(1)} mph';
  }

  
  static String formatForecastDate(DateTime date) {
    return DateFormat('EEE, MMM d').format(date);
  }

  
  static String formatTime(int timestamp) {
    return DateFormat.Hm().format(
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
    );
  }

  
  static String getWeatherDescription(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'Perfect weather for outdoor activities';
      case 'clouds':
        return 'Partly cloudy skies';
      case 'rain':
        return 'Don\'t forget your umbrella';
      case 'snow':
        return 'Bundle up, it\'s snowing!';
      case 'thunderstorm':
        return 'Stay indoors if possible';
      default:
        return 'Weather conditions normal';
    }
  }
}