import 'package:calculatebadminton/widgets/left_navigation.dart';
import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: AppBar(
        title: Text("คิดเงิน", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
        child: SingleChildScrollView(
            child: Column(children: [
          TextButton(
              onPressed: () {},
              child: Text('คิดเงิน'),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all(Colors.pinkAccent))),
          Divider(
            height: 10,
          ),
          Text(
            "รายละเอียดเกม",
            style: TextStyle(color: Colors.pinkAccent, fontSize: 25),
          ),
          Divider(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          // Text("ตีทั้งหมด " + gameCount.toString() + " เกม ",
          //     style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          // Text("ใช้ลูกแบด " + countShuttleCock.toString() + " ลูก",
          //     style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Text("รายละเอียดการจ่ายเงิน",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          // Text(
          //     "ค่าคอดแบด " +
          //         (costCort < 0 ? costCort * -1 : costCort).toString() +
          //         " บาท",
          //     style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          // Text(
          //     "ค่าลูกแบด " +
          //         (calculateCostShuttleCock < 0
          //                 ? calculateCostShuttleCock * -1
          //                 : calculateCostShuttleCock)
          //             .toString() +
          //         " บาท",
          //     style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          // Text("ได้จับนอก " + costBetRevenue.toString() + " บาท",
          //     style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          // Text(
          //     "เสียจับนอก " +
          //         (costBetExpenses < 0 ? costBetExpenses * -1 : costBetExpenses)
          //             .toString() +
          //         " บาท",
          //     style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 30,
          ),
          // costSumary > 0
          //     ? Text("รวมต้องได้เงิน $costSumary บาท",
          //         style: TextStyle(color: Colors.blue, fontSize: 25))
          //     : Text(
          //         "รวมต้องจ่ายเงิน " +
          //             (costSumary < 0 ? costSumary * -1 : costSumary)
          //                 .toString() +
          //             " บาท",
          //         style: TextStyle(color: Colors.blue, fontSize: 25)),
          Divider(
            height: 20,
          ),
        ])),
      ),
    );
  }
}
