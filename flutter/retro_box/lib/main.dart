// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_box/core/routes/app_routes.dart';
import 'package:retro_box/core/routes/routes_names.dart';
import 'package:retro_box/core/services/service_locator.dart';
import 'package:retro_box/features/xo_game/presentation/provider/xo_game_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();
  // await getIt<CacheHelper>().init();

  // runApp(
  //   DevicePreview(
  //     builder: (context) => MyApp(),
  //     enabled: !kReleaseMode,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => XoGameController()),
        // ChangeNotifierProvider(create: (_) => ChessController()),
        // ChangeNotifierProvider(create: (_) => SudokuController()),
      ],
      child: MaterialApp(
        title: 'RetroBox',
        debugShowCheckedModeBanner: false,
        // locale: DevicePreview.locale(context),
        // builder: DevicePreview.appBuilder,
        initialRoute: RoutesName.initial,
        onGenerateRoute: AppRoute.generate,
      ),
    );
  }
}
