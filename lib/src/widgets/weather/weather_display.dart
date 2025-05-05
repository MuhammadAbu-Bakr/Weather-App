import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models/weather_model.dart';
import '../../utils/helpers/weather_helper.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherData weather;

  const WeatherDisplay({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        SvgPicture.asset(
          WeatherHelper.getWeatherIcon(weather.iconCode),
          width: 120,
          height: 120,
          color: Theme.of(context).primaryColor,
        ),
        const SizedBox(height: 16),
        Text(
          '${weather.temperature.round()}°',
          style: Theme.of(context).textTheme.headline2?.copyWith(
                fontWeight: FontWeight.w300,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          weather.description.capitalize(),
          style: Theme.of(context).textTheme.headline5?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Feels like ${weather.feelsLike.round()}°',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              WeatherDetailCard(
                icon: Icons.water_drop,
                title: 'Humidity',
                value: '${weather.humidity}%',
                color: Colors.blue,
              ),
              WeatherDetailCard(
                icon: Icons.air,
                title: 'Wind Speed',
                value: '${weather.windSpeed.toStringAsFixed(1)} km/h',
                color: Colors.green,
              ),
              WeatherDetailCard(
                icon: Icons.speed,
                title: 'Pressure',
                value: '${weather.pressure} hPa',
                color: Colors.orange,
              ),
              WeatherDetailCard(
                icon: Icons.thermostat,
                title: 'Feels Like',
                value: '${weather.feelsLike.round()}°',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}