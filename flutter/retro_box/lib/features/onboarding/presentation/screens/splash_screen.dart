// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_colors.dart';
import 'package:retro_box/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:retro_box/features/xo_game/presentation/screens/xo_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _splashTime();
  }

  Future<void> _splashTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    bool? hasLogin = prefs.getBool('hasLogin') ?? false;
    await Future.delayed(const Duration(seconds: 2));

    if (hasSeenOnboarding) {
      if (hasLogin) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const Scaffold()));
      } else {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => const XoHome()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: splash(),
      ),
    );
  }

  Column splash() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo/logo.png',
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'RetroBox',
          style: TextStyle(
            color: AppColor.black,
            fontSize: 45,
            fontFamily: 'Poppins-Bold',
          ),
        )
      ],
    );
  }
}
