import 'package:flutter/material.dart';
import 'pages/home_page.dart';

// mulai dari sini
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cuaca Jogja',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomePage(), // memanggil HomePage sebagai halaman utama
    );
  }
}
