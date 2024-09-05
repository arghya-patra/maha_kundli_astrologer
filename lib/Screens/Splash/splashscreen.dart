import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mahakundali_astrologer_app/Screens/Auth/login.dart';
import 'package:mahakundali_astrologer_app/Screens/Home/dashboardScreen.dart';
import 'package:mahakundali_astrologer_app/service/serviceManager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    ServiceManager().getUserID();
    ServiceManager().getTokenID();
    // LocationService().fetchLocation();
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (ServiceManager.userID != '') {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer!.isActive) _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: Image.asset(
        'images/splash_img.webp',
        height: MediaQuery.of(context).size.height,
        fit: BoxFit.fill,
      ),
    );
  }
}
