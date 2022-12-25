import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/core/functions/navigator.dart';
import '/core/services/services_locator.dart' as di;
import '../../../../core/utils/routes/routes_manager.dart';
import '../../../data/data_source/auth/local/auth_local_data_source.dart';
import 'components/bottom_text.dart';
import 'components/splash_icon.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  _startDelay() {
    _timer = Timer(const Duration(seconds: 1), _goNext);
  }

  _goNext() {
    di.sl<BaseAuthLocalDataSource>().getUser() != null
        ? navigateAndRemove(context, Routes.mainLayoutRoute)
        : navigateAndRemove(context, Routes.landingRoute);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness:Brightness.dark,
      ),
    );
    return Scaffold(
      body: Column(
        children: const [
          SplashIcon(),
          BottomText(),
          SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}


