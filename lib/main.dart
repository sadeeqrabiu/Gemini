import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini/core/api_section/const.dart';
import 'package:gemini/src/home_screen.dart';

void main() {
  Gemini.init(apiKey: GEMINI_AI_KEY);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root of Gemini application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
      ),

      home:  const HomeScreen(),
    );
  }
}