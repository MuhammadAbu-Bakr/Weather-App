class WeatherModel {
  final String cityName;
  final double temperature;
  final double feelsLike;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int pressure;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      pressure: json['main']['pressure'],
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
}

class WeatherForecast {
  final DateTime date;
  final double temperature;
  final String description;
  final String icon;
  final double windSpeed;
  final int humidity;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
      humidity: json['main']['humidity'],
    );
  }
}
