import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('YOUR_API_KEY');
  Weather? _weather;

  _fetchWeather() async {
    // String cityName = await _weatherService.getCurrentCity();
    String cityName = 'London';
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      throw Exception('Failed to load weather data');
    }
  }

  String getWeatherIcon(String mainCondition) {
    switch (mainCondition) {
      case 'Thunderstorm':
        return '/thunderstorm.json';
      case 'Drizzle':
        return '/drizzle.json';
      case 'Rain':
        return '/rain.json';
      case 'Snow':
        return '/snow.json';
      case 'Clear':
        return '/clear.json';
      case 'Clouds':
        return '/storm.json';
      default:
        return '/unknown.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E88E5),
              Color(0xFF1976D2),
              Color(0xFF0D47A1),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _weather!.cityName,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Lottie.asset(
                getWeatherIcon(_weather!.mainCondition),
                height: 300,
                width: 300,
              ),
              const SizedBox(height: 20),
              Text(
                "${_weather!.temperature}°C",
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _weather!.mainCondition,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
