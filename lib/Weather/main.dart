import 'package:flutter/material.dart';
import 'package:demo1/weather/forecast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const Forecast(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      primaryColor: const Color(0xFF254117), // A nice green shade
      hintColor: Colors.blueAccent,
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black54, fontSize: 18),
        bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
      ),
    );
  }
}
