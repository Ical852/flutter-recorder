import 'package:flutter/material.dart';
import 'package:flutterrecorder/screens/splash_page.dart';
import 'package:flutterrecorder/screens/video_recorder_pages/video_recorder_page.dart';
import 'package:flutterrecorder/screens/video_upload_pages/video_upload_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => SplashPage(),
        "/record": (context) => VideoRecorderPage(),
        "/upload": (context) => VideoUploadPage(),
      },
    );
  }
}
