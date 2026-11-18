import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const SamsadKidsApp());
}

class SamsadKidsApp extends StatelessWidget {
  const SamsadKidsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samsad Kids',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const SamsadKidsHomeScreen(),
    );
  }
}
