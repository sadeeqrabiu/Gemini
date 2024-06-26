import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/core/api_section/const.dart';
import 'package:gemini/src/chat%20/home_screen.dart';
import 'package:gemini/src/section.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  Gemini.init(apiKey: GEMINI_AI_KEY);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root of Gemini application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.comfortaaTextTheme(),
        useMaterial3: true,
      ),
      home:  const Section(),
    );
  }
}