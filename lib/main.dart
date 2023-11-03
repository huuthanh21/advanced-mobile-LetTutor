import 'package:flutter/material.dart';
import 'package:lettutor/presentation/tutor_detail/tutor_detail_page.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(0, 113, 240, 1),
          primary: const Color.fromRGBO(0, 113, 240, 1),
          secondary: Colors.black,
          tertiary: const Color.fromRGBO(164, 176, 190, 1),
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 14,
          ),
          headlineLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: const TutorDetailPage(),
    );
  }
}
