import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../secrets/api_key.dart';

// Fungsi untuk mengambil data cuaca dari API OpenWeatherMap
Future<WeatherData> fetchWeather(String city) async {
  final url = Uri.parse(
    'https://api.openweathermap.org/data/2.5/weather?q=$city&units=metric&appid=$openWeatherApiKey',
  );

  final res = await http.get(url);
  if (res.statusCode == 200) {
    return WeatherData.fromJson(json.decode(res.body));
  } else {
    throw Exception('Failed to fetch weather');
  }
}
