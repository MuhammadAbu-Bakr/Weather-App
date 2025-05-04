class WeatherData {
  final String city;
  final int temperature;
  final int feelsLike;
  final String condition;
  final String description;
  final int humidity;
  final double windSpeed;
  final int pressure;
  final String iconCode;

  WeatherData({
    required this.city,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
    required this.iconCode,
  });

  String get weatherIcon {
    switch (condition.toLowerCase()) {
      case 'clear':
        return 'assets/sunny.svg';
      case 'clouds':
        return 'assets/cloudy.svg';
      case 'rain':
        return 'assets/rainy.svg';
      case 'snow':
        return 'assets/snowy.svg';
      case 'thunderstorm':
        return 'assets/thunder.svg';
      default:
        return 'assets/partly_cloudy.svg';
    }
  }

  Color get backgroundColor {
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
}