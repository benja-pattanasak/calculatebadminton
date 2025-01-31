import 'package:flutter/material.dart';

class EditshuttlecockScreen extends StatefulWidget {
  const EditshuttlecockScreen({super.key});

  @override
  State<EditshuttlecockScreen> createState() => _EditshuttlecockScreenState();
}

class _EditshuttlecockScreenState extends State<EditshuttlecockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {},
              child: Text('เพิ่มลูกแบด'),
            ),
            SizedBox(width: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {},
              child: Text('ลดลูกแบด'),
            )
          ],
        )),
      ],
    ));
  }
}
