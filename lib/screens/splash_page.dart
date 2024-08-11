import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterrecorder/shared/text_styles.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
        context,
        "/record",
        (route) => false
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.camera,
                  size: 150,
                ),
                SizedBox(height: 12),
                Text(
                  "Recorder Apps",
                  style: extra.black.semiBold,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
