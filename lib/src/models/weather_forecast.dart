class WeatherForecast {
  final DateTime date;
  final double temperature;
  final String condition;
  final int humidity;
  final String icon;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.icon,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000),
      temperature: json['main']['temp'].toDouble(),
      condition: json['weather'][0]['main'],
      humidity: json['main']['humidity'],
      icon: json['weather'][0]['icon'],
    );
  }
}flutter pub get