import 'package:convertify/feature/presentation/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Convertify',
      theme: AppTheme.dark,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
