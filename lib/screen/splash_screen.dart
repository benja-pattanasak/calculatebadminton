import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:calculatebadminton/screen/home_screen.dart';
import 'package:calculatebadminton/state/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:redux/redux.dart';

class SplashScreen extends StatelessWidget {
  final Store<AppState> store;
  SplashScreen({required this.store});
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
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
        ));
  }
}
