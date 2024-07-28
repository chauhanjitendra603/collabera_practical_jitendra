import 'package:collabera_test_jitendra/routers/nav_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:sizing/sizing.dart';

import 'routers/router_constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Set status bar color to white
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));
    return const MyHome();
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return SizingBuilder(
        builder: () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fade,
              useInheritedMediaQuery: true,
              initialRoute: splashscreen,
              getPages: NavRouter.generateRoute,
            ));
  }
}
