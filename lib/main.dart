import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const EssenzaApp());
}

class EssenzaApp extends StatelessWidget {
  const EssenzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Essenza',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8E6E53),
        ),
        scaffoldBackgroundColor: const Color(0xFFF8F5F2),
      ),
      home: const SplashScreen(),
    );
  }
}