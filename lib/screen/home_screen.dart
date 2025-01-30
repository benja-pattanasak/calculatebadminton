import 'package:calculatebadminton/screen/cleardata_screen.dart';
import 'package:calculatebadminton/screen/game_screen.dart';
import 'package:calculatebadminton/screen/payment_screen.dart';
import 'package:calculatebadminton/screen/player_screen.dart';
import 'package:calculatebadminton/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final screens = [
    GameScreen(),
    PlayerScreen(),
    PaymentScreen(),
    SettingScreen(),
    CleardataScreen(),
  ];
  int currentIndex = 0;
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.pinkAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.badminton,
              ),
              label: 'เกม'),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility_sharp), label: 'ผู้เล่น'),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), label: 'คิดเงิน'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'ตั้งค่า'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'เคลียข้อมูล')
        ],
      ),
    );
  }
}
