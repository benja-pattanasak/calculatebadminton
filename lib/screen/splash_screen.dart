import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:calculatebadminton/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
          duration: 1500,
          splash: Icon(
            MdiIcons.badminton,
            color: Colors.white,
            size: 150,
          ),
          nextScreen: HomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.pinkAccent),
      theme: ThemeData(
          primaryColor: Colors.pinkAccent,
          appBarTheme: AppBarTheme(color: Colors.pinkAccent)),
    );
  }
}
