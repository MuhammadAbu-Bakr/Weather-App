class AppConstants {
  static const String openWeatherApiKey = 'YOUR_API_KEY'; // Replace with your actual API key
  static const String weatherBaseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String weatherIconUrl = 'https://openweathermap.org/img/wn';
  
  // Weather condition codes mapping
  static Map<String, String> weatherConditions = {
    '01d': 'clear_sky',
    '02d': 'few_clouds',
    '03d': 'scattered_clouds',
    '04d': 'broken_clouds',
    '09d': 'shower_rain',
    '10d': 'rain',
    '11d': 'thunderstorm',
    '13d': 'snow',
    '50d': 'mist',
    // Night icons
    '01n': 'clear_sky_night',
    '02n': 'few_clouds_night',
    '03n': 'scattered_clouds_night',
    '04n': 'broken_clouds_night',
    
  };
}