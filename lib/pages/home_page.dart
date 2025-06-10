import 'package:flutter/material.dart';
import '../services/weather_services.dart';
import '../models/weather_model.dart';
import '../widgets/cuaca_card.dart';

// halaman utama aplikasi cuaca
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherData> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather(
      'Yogyakarta',
    ); // ambil data cuaca untuk Yogyakarta dari API OpenWeatherMap
    // ganti nama kota jika perlu
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cuaca Jogja')),
      body: FutureBuilder(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            ); // tampilkan indikator pemuatan saat data sedang dimuat
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Terjadi kesalahan: ${snapshot.error}'),
            ); // tampilkan pesan kesalahan jika ada
          } else if (snapshot.hasData) {
            return CuacaCard(
              weather: snapshot.data!,
            ); // tampilkan data cuaca menggunakan widget CuacaCard
          } else {
            return const Center(
              child: Text('Data tidak tersedia'),
            ); // tampilkan pesan jika data tidak tersedia
          }
        },
      ),
    );
  }
}
