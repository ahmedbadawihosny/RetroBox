// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:retro_box/core/constants/app_colors.dart';
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
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    // await Future.delayed(const Duration(seconds: 10));

    // if (hasSeenOnboarding) {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (_) => const Scaffold()));
    // } else {
    //   Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(builder: (_) => const Placeholder()));
    // }
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
