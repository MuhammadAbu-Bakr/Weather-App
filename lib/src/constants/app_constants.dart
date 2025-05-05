class AppConstants {
  // API Configuration
  static const String openWeatherApiKey = '5ac508a4a4b2ee56faed57e9f848506c'; 
  static const String openWeatherBaseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String openWeatherImageUrl = 'https://openweathermap.org/img/wn';
  static const String openWeatherUnits = 'metric';

  // App Configuration
  static const String appName = 'Weather Forecast';
  static const String defaultCity = 'London';
  static const double defaultLatitude = 51.5074;
  static const double defaultLongitude = -0.1278;

  // Weather Condition Codes
  static const Map<String, String> weatherConditionIcons = {
    '01d': 'clear_sky_day',
    '01n': 'clear_sky_night',
    '02d': 'few_clouds_day',
    '02n': 'few_clouds_night',
    '03d': 'scattered_clouds',
    '03n': 'scattered_clouds',
    '04d': 'broken_clouds',
    '04n': 'broken_clouds',
    '09d': 'shower_rain',
    '09n': 'shower_rain',
    '10d': 'rain_day',
    '10n': 'rain_night',
    '11d': 'thunderstorm',
    '11n': 'thunderstorm',
    '13d': 'snow',
    '13n': 'snow',
    '50d': 'mist',
    '50n': 'mist',
  };

  // Weather Condition Backgrounds
  static const Map<String, String> weatherConditionBackgrounds = {
    'clear': 'assets/backgrounds/clear_sky.jpg',
    'clouds': 'assets/backgrounds/clouds.jpg',
    'rain': 'assets/backgrounds/rain.jpg',
    'snow': 'assets/backgrounds/snow.jpg',
    'thunderstorm': 'assets/backgrounds/thunderstorm.jpg',
    'default': 'assets/backgrounds/default.jpg',
  };

  // Timeouts
  static const int apiTimeout = 30; // seconds
  static const int locationTimeout = 10; // seconds

  // Local Storage Keys
  static const String lastCityKey = 'last_city';
  static const String darkModeKey = 'dark_mode';
  static const String unitSystemKey = 'unit_system';
}