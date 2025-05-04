import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/services/weather_repository.dart';
import 'package:weather_app/src/widgets/weather/forecast_day_item.dart';

class ForecastScreen extends StatefulWidget {
  final WeatherRepository weatherRepository;

  const ForecastScreen({Key? key, required this.weatherRepository}) : super(key: key);

  @override
  _ForecastScreenState createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  List<WeatherForecast> _forecasts = [];
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchForecast();
  }

  Future<void> _fetchForecast() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final position = await widget.weatherRepository.getCurrentLocation();
      final forecasts = await widget.weatherRepository.getFiveDayForecast(
        position.latitude,
        position.longitude,
      );
      setState(() => _forecasts = forecasts);
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('5-Day Forecast'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: SpinKitFadingCircle(color: Colors.blue))
          : RefreshIndicator(
              onRefresh: _fetchForecast,
              child: _errorMessage.isNotEmpty
                  ? Center(child: Text(_errorMessage))
                  : ListView.builder(
                      itemCount: _forecasts.length,
                      itemBuilder: (context, index) {
                        return ForecastDayItem(forecast: _forecasts[index]);
                      },
                    ),
            ),
    );
  }
}