import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LeftNavigation extends StatefulWidget {
  const LeftNavigation({super.key});

  @override
  State<LeftNavigation> createState() => _LeftNavigationState();
}

class _LeftNavigationState extends State<LeftNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  MdiIcons.badminton,
                  color: Colors.black,
                  size: 50,
                ),
              ),
              accountName: Text(
                'Benja Pattanasak(Jay)',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                'lifeisprogrammer@gmail.com',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
