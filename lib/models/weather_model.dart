// File ini mendefinisikan model data cuaca yang digunakan dalam aplikasi.
class WeatherData {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final int pressure;
  final String description;
  final String mainWeather;
  final String icon;
  final double windSpeed;
  final int windDirection;
  final int visibility;
  final int cloudiness;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.pressure,
    required this.description,
    required this.mainWeather,
    required this.icon,
    required this.windSpeed,
    required this.windDirection,
    required this.visibility,
    required this.cloudiness,
    required this.sunrise,
    required this.sunset,
  });
  // contructor untuk membuat objek WeatherData dari JSON
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      country: json['sys']['country'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      description: json['weather'][0]['description'],
      mainWeather: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      windSpeed: json['wind']['speed'].toDouble(),
      windDirection: json['wind']['deg'] ?? 0,
      visibility: json['visibility'] ?? 0,
      cloudiness: json['clouds']['all'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        json['sys']['sunrise'] * 1000,
      ),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000),
    );
  }
}
