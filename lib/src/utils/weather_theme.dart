import 'package:flutter/material.dart';

class WeatherTheme {
  static Color getBackgroundColor(String weatherIcon) {
    // First two characters of the icon code represent the weather condition
    String condition = weatherIcon.substring(0, 2);

    switch (condition) {
      case '01': // clear sky
        return Colors.blue[100]!;
      case '02': // few clouds
      case '03': // scattered clouds
      case '04': // broken clouds
        return Colors.blueGrey[100]!;
      case '09': // shower rain
      case '10': // rain
        return Colors.indigo[100]!;
      case '11': // thunderstorm
        return Colors.deepPurple[100]!;
      case '13': // snow
        return Colors.blue[50]!;
      case '50': // mist
        return Colors.grey[300]!;
      default:
        return Colors.blue[50]!;
    }
  }

  static Color getTextColor(String weatherIcon) {
    String condition = weatherIcon.substring(0, 2);
    switch (condition) {
      case '11': // thunderstorm
      case '09': // shower rain
      case '10': // rain
        return Colors.white;
      default:
        return Colors.black87;
    }
  }

  static LinearGradient getGradient(String weatherIcon) {
    Color baseColor = getBackgroundColor(weatherIcon);
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [baseColor, baseColor.withOpacity(0.6)],
    );
  }
}
