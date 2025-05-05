import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/weather_model.dart';
import '../../utils/helpers/weather_helper.dart';

class ForecastDayItem extends StatelessWidget {
  final WeatherForecast forecast;

  const ForecastDayItem({
    Key? key,
    required this.forecast,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                WeatherHelper.formatForecastDate(forecast.date),
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Icon(
              _getWeatherIcon(),
              color: _getWeatherColor(),
              size: 30,
            ),
            const SizedBox(width: 16),
            Text(
              '${forecast.temperature.round()}°',
              style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              '${forecast.humidity}%',
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getWeatherIcon() {
    switch (forecast.condition.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.beach_access;
      case 'snow':
        return Icons.ac_unit;
      case 'thunderstorm':
        return Icons.flash_on;
      default:
        return Icons.wb_cloudy;
    }
  }

  Color _getWeatherColor() {
    switch (forecast.condition.toLowerCase()) {
      case 'clear':
        return Colors.amber;
      case 'clouds':
        return Colors.blueGrey;
      case 'rain':
        return Colors.blue;
      case 'snow':
        return Colors.lightBlue;
      case 'thunderstorm':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}