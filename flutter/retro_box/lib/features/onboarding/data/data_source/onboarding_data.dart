import 'dart:convert';

import 'package:retro_box/features/onboarding/data/model/onboarding_model.dart';

class OnboardingData {
  static String onboardingData = '''[
    {
      "imagePath": "assets/images/onboarding/onboarding1.svg",
      "title": "Welcome",
      "description": "One of the oldest world games now available on your smartphone device!"
    },
    {
      "imagePath": "assets/images/onboarding/onboarding2.svg",
      "title": "Compete",
      "description": "Play the game with your friends, and prove that you’re a worthy opponent!"
    },
    {
      "imagePath": "assets/images/onboarding/onboarding3.svg",
      "title": "Scoreboard",
      "description": "Earn points and make your own way to the top of the scoreboard!"
    }
  ]''';

  List<OnboardingModel> viewOnboarding() {
    List<dynamic> data = jsonDecode(onboardingData);
    return data
        .map<OnboardingModel>(
            (onboarding) => OnboardingModel.fromJson(onboarding))
        .toList();
  }
}
