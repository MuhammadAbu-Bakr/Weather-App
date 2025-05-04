extension StringExtensions on String {
  
  String capitalize() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  
  String get temperatureUnitName {
    switch (toLowerCase()) {
      case 'c':
      case '°c':
        return 'Celsius';
      case 'f':
      case '°f':
        return 'Fahrenheit';
      case 'k':
        return 'Kelvin';
      default:
        return this;
    }
  }

  
  String toWeatherCondition() {
    return replaceAll('_', ' ').capitalize();
  }

  
  bool get isValidCityName {
    final regex = RegExp(r'^[a-zA-Z\s\-]+$');
    return regex.hasMatch(this) && length > 1;
  }
}