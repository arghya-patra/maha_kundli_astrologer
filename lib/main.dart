import 'package:flutter/material.dart';
import 'package:mahakundali_astrologer_app/Screens/Splash/splashscreen.dart';
import 'package:mahakundali_astrologer_app/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mahakundli Astrologer',
      debugShowCheckedModeBanner: false,
      theme: Constants.lightTheme,
      darkTheme: Constants.darkTheme,
      themeMode: ThemeMode.system,
      home: SplashScreen(),
    );
  }
}
