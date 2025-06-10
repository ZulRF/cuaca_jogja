import 'package:flutter/material.dart';
import '../models/weather_model.dart';

class CuacaCard extends StatelessWidget {
  final WeatherData weather;

  const CuacaCard({super.key, required this.weather});

  String _formatTime(DateTime dateTime) {
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getWindDirection(int degrees) {
    List<String> directions = ['U', 'TL', 'T', 'BD', 'S', 'BT', 'B', 'TG'];
    int index = ((degrees + 22.5) / 45).floor() % 8;
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Card Weather utama
          Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Kota dan Negara
                  Text(
                    '${weather.cityName}, ${weather.country}',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Ikon Weather dan Suhu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                        width: 80,
                        height: 80,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.wb_sunny,
                            size: 80,
                            color: Colors.orange,
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      Column(
                        children: [
                          Text(
                            '${weather.temperature.round()}°C',
                            style: Theme.of(
                              context,
                            ).textTheme.displayLarge?.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Terasa ${weather.feelsLike.round()}°C',
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Deskripsi Cuaca
                  Text(
                    weather.description.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  // Suhu Minimum dan Maksimum
                  Text(
                    'Min: ${weather.tempMin.round()}°C / Max: ${weather.tempMax.round()}°C',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Detail Cuaca Card
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detail Cuaca',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Row Pertama dari Detail
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.water_drop,
                          label: 'Kelembaban',
                          value: '${weather.humidity}%',
                          color: Colors.blue,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.compress,
                          label: 'Tekanan',
                          value: '${weather.pressure} hPa',
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Row Kedua dari Detail
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.air,
                          label: 'Angin',
                          value:
                              '${weather.windSpeed} m/s ${_getWindDirection(weather.windDirection)}',
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.visibility,
                          label: 'Jarak Pandang',
                          value:
                              '${(weather.visibility / 1000).toStringAsFixed(1)} km',
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Row ketiga dari Detail
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          icon: Icons.cloud,
                          label: 'Awan',
                          value: '${weather.cloudiness}%',
                          color: Colors.blueGrey,
                        ),
                      ),
                      Expanded(
                        child: Container(), // Space kosong
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Matahari Card
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Matahari',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSunTimeItem(
                          icon: Icons.wb_sunny,
                          label: 'Terbit',
                          time: _formatTime(weather.sunrise),
                          color: Colors.orange,
                        ),
                      ),
                      Expanded(
                        child: _buildSunTimeItem(
                          icon: Icons.nights_stay,
                          label: 'Terbenam',
                          time: _formatTime(weather.sunset),
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membangun item detail cuaca
  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Widget untuk membangun item waktu matahari
  Widget _buildSunTimeItem({
    required IconData icon,
    required String label,
    required String time,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          time,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
