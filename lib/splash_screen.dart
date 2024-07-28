import 'dart:async';

import 'package:collabera_test_jitendra/routers/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    Timer(const Duration(seconds: 2), () async {
      Get.offAllNamed(productlistscreen);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
