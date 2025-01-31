import 'package:calculatebadminton/repository/game_repository.dart';
import 'package:flutter/material.dart';

class EditplayresultScreen extends StatefulWidget {
  const EditplayresultScreen({super.key});

  @override
  State<EditplayresultScreen> createState() => _EditplayresultScreenState();
}

class _EditplayresultScreenState extends State<EditplayresultScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
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
              onPressed: () async {
                GameRepository gameRepository = GameRepository();
                gameRepository.editGameResult("1", int.parse(args['gameID']));
                Navigator.pop(context, args['gameID'].toString() + ",1");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('แก้ไขผลการแข่งขันเรียบร้อย'),
                    duration:
                        Duration(seconds: 3), // ระยะเวลาในการแสดง SnackBar
                  ),
                );
              },
              child: Text('แพ้'),
            ),
            SizedBox(width: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                GameRepository gameRepository = GameRepository();
                gameRepository.editGameResult("2", int.parse(args['gameID']));
                Navigator.pop(context, args['gameID'].toString() + ",2");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('แก้ไขผลการแข่งขันเรียบร้อย'),
                    duration:
                        Duration(seconds: 3), // ระยะเวลาในการแสดง SnackBar
                  ),
                );
              },
              child: Text('ชนะ'),
            ),
            SizedBox(width: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                GameRepository gameRepository = GameRepository();
                gameRepository.editGameResult("3", int.parse(args['gameID']));
                Navigator.pop(context, args['gameID'].toString() + ",3");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('แก้ไขผลการแข่งขันเรียบร้อย'),
                    duration:
                        Duration(seconds: 3), // ระยะเวลาในการแสดง SnackBar
                  ),
                );
              },
              child: Text('เสมอ'),
            )
          ],
          //children: listWidget,s
        )),
      ],
    ));
  }
}
