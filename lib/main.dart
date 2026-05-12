import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:totalUnit/services/consent_service.dart';
import 'package:totalUnit/feature/presentation/screen/main_screen.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (Platform.isAndroid || Platform.isIOS) {
    try {
      await ConsentService.initConsent();
      await MobileAds.instance.initialize();
      debugPrint("AdMob & UMP αρχικοποιήθηκαν επιτυχώς.");
    } catch (e) {
      debugPrint("Σφάλμα κατά την αρχικοποίηση διαφημίσεων: $e");
    }
  } else {
    debugPrint("Οι διαφημίσεις παρακάμπτονται: Μη υποστηριζόμενη πλατφόρμα.");
  }
  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOTAL UNIT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0B10),
        primaryColor: const Color(0xFF0B0B10),
      ),
      home: const MainScreen(),
    );
  }
}