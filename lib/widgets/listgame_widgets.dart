import 'package:flutter/material.dart';

class ListgameWidgets extends StatelessWidget {
  const ListgameWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "เกมที่ 1",
          style: TextStyle(color: Colors.pink, fontSize: 20),
        ),
        SizedBox(height: 10),
        Text(
          "รายละเอียดเกม",
          style: TextStyle(color: Colors.blue),
        ),
        SizedBox(height: 10),
        Text("ตู่ กับ นัท", style: TextStyle(color: Colors.black)),
        SizedBox(height: 3),
        Text("เจอกับ", style: TextStyle(color: Colors.black)),
        SizedBox(height: 3),
        Text("แจ๊ค กับ ชาญ", style: TextStyle(color: Colors.black)),
        SizedBox(height: 3),
        Text("ค่าลูก 50", style: TextStyle(color: Colors.black)),
        SizedBox(height: 3)
      ],
    );
  }
}
