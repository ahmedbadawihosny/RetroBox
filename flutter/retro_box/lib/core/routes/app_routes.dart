import 'package:flutter/material.dart';
import 'package:retro_box/core/routes/routes_names.dart';

class AppRoute {
  static Route<dynamic> generate(RouteSettings settings) {
    // final args = settings.arguments;

    switch (settings.name) {
      case RoutesName.initial:
      // return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.onboarding:
      // return MaterialPageRoute(builder: (_) => const ());
      // case RoutesName.postDetails:
      // return MaterialPageRoute(builder: (_) => PostDetails(post: args,));
      default:
        throw Exception('Not Found!');
    }
  }
}
