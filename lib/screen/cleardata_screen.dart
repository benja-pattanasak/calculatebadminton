import 'package:calculatebadminton/repository/betdetail_repository.dart';
import 'package:calculatebadminton/repository/game_repository.dart';
import 'package:calculatebadminton/widgets/left_navigation.dart';
import 'package:flutter/material.dart';

class CleardataScreen extends StatefulWidget {
  const CleardataScreen({super.key});

  @override
  State<CleardataScreen> createState() => _CleardataScreenState();
}

class _CleardataScreenState extends State<CleardataScreen> {
  _deleteFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('ยกเลิก'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green))),
              TextButton(
                  onPressed: () async {
                    GameRepository gameRepository = GameRepository();
                    await gameRepository.deleteAllGame();
                    BetDetailRepository betDetailRepository =
                        BetDetailRepository();
                    await betDetailRepository.deleteAllBetDetail();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('ลบข้อมูลเรียบร้อย'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: Text('ลบข้อมูล'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.red)))
            ],
            title: Text(
                'ต้องการลบข้อมูลทั้งหมดเพื่อเริ่มต้นคิดเงินใหม่ใช่หรือไม่'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: LeftNavigation(),
        appBar: AppBar(
          title: Text('เคลียข้อมูล', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              //key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green),
                    onPressed: () async {
                      _deleteFormDialog(context);
                    },
                    child: Text(
                      'ลบข้อมูลทั้งหมดเพื่อเริ่มต้นคิดเงินใหม่',
                    ),
                  )
                ],
              ),
            )));
  }
}
