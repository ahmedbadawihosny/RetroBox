import 'package:flutter/material.dart';
import 'package:retro_box/core/routes/routes_names.dart';
import 'package:retro_box/features/app/presentation/screens/home.dart';
import 'package:retro_box/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:retro_box/features/onboarding/presentation/screens/splash_screen.dart';
import 'package:retro_box/features/xo_game/presentation/screens/xo_game_session.dart';
import 'package:retro_box/features/xo_game/presentation/screens/xo_home.dart';
import 'package:retro_box/features/xo_game/presentation/screens/xo_rules.dart';

class AppRoute {
  static Route<dynamic> generate(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case RoutesName.initial:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case RoutesName.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case RoutesName.xoHome:
        return MaterialPageRoute(builder: (_) => const XoHome());
      case RoutesName.xoRules:
        final String args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => XoRules(
                  session: args,
                ));
      case RoutesName.xoGameSession:
        final String args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => XoGameSession(
                  session: args,
                ));
      // case RoutesName.postDetails:
      // return MaterialPageRoute(builder: (_) => PostDetails(post: args,));
      default:
        throw Exception('Not Found!');
    }
  }
}
