import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:hive_flutter/adapters.dart';

import 'commonwidget/splashscreen.dart';
import 'constant/textStyle.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('milestone_box');
  await Hive.openBox('user_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Baby Milestone App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (__) {
        return const OnBoardScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                maxRadius: 40,
                backgroundColor: backGBcolor,
                child: Animate(
                    effects: [
                      const SlideEffect(curve: Curves.bounceIn),
                      FadeEffect(delay: 500.ms),
                    ],
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Icon(
                        FontAwesomeIcons.babyCarriage,
                        color: Colors.white,
                      ),
                    ))),
            Animate(
              effects: [
                FadeEffect(delay: 600.ms),
                const SlideEffect(curve: Curves.bounceIn),
              ],
              child: Text(
                'Baby Tracker',
                style: appStyle(
                  color: backGBcolor,
                  size: 40,
                  fw: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
