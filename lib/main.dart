import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:video_player_win/video_player_win_plugin.dart';

import 'common/providers/data_provider.dart';
import 'core/app_router.dart';
import 'core/providers/login_provider.dart';
import 'presentation/tutor_list/providers/favorite_tutors_provider.dart';

void main() {
  if (!kIsWeb && Platform.isWindows) WindowsVideoPlayer.registerWith();
  initializeDateFormatting("vi_VN", null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => LoginProvider()),
        Provider(create: (_) => TutorDataProvider()),
        Provider(create: (_) => BookingDataProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteTutorsProvider()),
      ],
      child: MaterialApp.router(
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
        routerConfig: router,
        //home: const CourseDetailPage(),
      ),
    );
  }
}
