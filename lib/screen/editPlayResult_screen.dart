import 'package:calculatebadminton/repository/game_repository.dart';
import 'package:flutter/material.dart';

class EditplayresultScreen extends StatefulWidget {
  const EditplayresultScreen({super.key});

  @override
  State<EditplayresultScreen> createState() => _EditplayresultScreenState();
}

class _EditplayresultScreenState extends State<EditplayresultScreen> {
  String gameResult = "";
  //int _numberShuttleCock = 0;

  // _showAlertError(String errorMessage) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (param) {
  //         return AlertDialog(
  //           actionsAlignment: MainAxisAlignment.center,
  //           actions: [
  //             Container(
  //               alignment: Alignment.center,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     "พบข้อผิดพลาดดังนี้",
  //                     style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
  //                   ),
  //                   SizedBox(height: 10),
  //                   Text(errorMessage),
  //                   SizedBox(height: 10),
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       backgroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.blue),
  //                       foregroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.white),
  //                     ),
  //                     onPressed: () async {
  //                       Navigator.pop(context);
  //                     },
  //                     child: Text('ปิด'),
  //                   ),
  //                 ],
  //                 //children: listWidget,
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  // _showAlertShuttleCock(int gameID) {
  //   // Navigator.pop(context);
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (param) {
  //         return AlertDialog(
  //           actionsAlignment: MainAxisAlignment.center,
  //           actions: [
  //             Container(
  //               alignment: Alignment.center,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       backgroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.blue),
  //                       foregroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.white),
  //                     ),
  //                     onPressed: () async {
  //                       Navigator.pop(context);
  //                       GameService gameService = GameService();
  //                       Future<dynamic> games = gameService.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         _numberShuttleCock = game['numberShuttleCock'];
  //                       }
  //                       setState(() {
  //                         _numberShuttleCock++;
  //                       });

  //                       gameService.editShuttleCock(gameID, _numberShuttleCock);

  //                       //_showSuccessSnackBar(Text("เพิ่มลูกแบดเรียบร้อย"));
  //                     },
  //                     child: Text('เพิ่มลูกแบด'),
  //                   ),
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       backgroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.blue),
  //                       foregroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.white),
  //                     ),
  //                     onPressed: () async {
  //                       GameService gameService = GameService();
  //                       Future<dynamic> games = gameService.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         _numberShuttleCock = game['numberShuttleCock'];
  //                       }
  //                       if (_numberShuttleCock == 1) {
  //                         String errorMessage =
  //                             "ไม่สามารถลดลูกแบดได้น้อยกว่า 1 ลูก";
  //                         return _showAlertError(errorMessage);
  //                       } else {
  //                         setState(() {
  //                           _numberShuttleCock--;
  //                         });
  //                         gameService.editShuttleCock(
  //                             gameID, _numberShuttleCock);
  //                         //_showSuccessSnackBar(Text("ลดลูกแบดเรียบร้อย"));
  //                       }
  //                     },
  //                     child: Text('ลดลูกแบด'),
  //                   )
  //                 ],
  //                 //children: listWidget,
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  // _showAlertPlayResult(int gameID) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: true,
  //       builder: (param) {
  //         return AlertDialog(
  //           actionsAlignment: MainAxisAlignment.center,
  //           actions: [
  //             Container(
  //               alignment: Alignment.center,
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       backgroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.blue),
  //                       foregroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.white),
  //                     ),
  //                     onPressed: () async {
  //                       Navigator.pop(context);
  //                       GameRepository gameRepository = GameRepository();
  //                       Future<dynamic> games = gameRepository.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         gameResult = game['results'];
  //                       }
  //                       gameRepository.editGameResult(gameResult, 1);
  //                       setState(() {
  //                         gameResult = "1";
  //                       });
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                           content: Text('แก้ไขผลการแข่งขันเรียบร้อย'),
  //                           duration: Duration(
  //                               seconds: 3), // ระยะเวลาในการแสดง SnackBar
  //                         ),
  //                       );
  //                     },
  //                     child: Text('แพ้'),
  //                   ),
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       backgroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.blue),
  //                       foregroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.white),
  //                     ),
  //                     onPressed: () async {
  //                       Navigator.pop(context);
  //                       GameRepository gameRepository = GameRepository();
  //                       Future<dynamic> games = gameRepository.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         gameResult = game['results'];
  //                       }
  //                       gameRepository.editGameResult(gameResult, 2);
  //                       setState(() {
  //                         gameResult = "2";
  //                       });
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                           content: Text('แก้ไขผลการแข่งขันเรียบร้อย'),
  //                           duration: Duration(
  //                               seconds: 3), // ระยะเวลาในการแสดง SnackBar
  //                         ),
  //                       );
  //                     },
  //                     child: Text('ชนะ'),
  //                   ),
  //                   TextButton(
  //                     style: ButtonStyle(
  //                       backgroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.blue),
  //                       foregroundColor:
  //                           MaterialStateProperty.all<Color>(Colors.white),
  //                     ),
  //                     onPressed: () async {
  //                       Navigator.pop(context);
  //                       GameRepository gameRepository = GameRepository();
  //                       Future<dynamic> games = gameRepository.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         gameResult = game['results'];
  //                       }
  //                       gameRepository.editGameResult(gameResult, 3);
  //                       setState(() {
  //                         gameResult = "3";
  //                       });
  //                       ScaffoldMessenger.of(context).showSnackBar(
  //                         SnackBar(
  //                           content: Text('แก้ไขผลการแข่งขันเรียบร้อย'),
  //                           duration: Duration(
  //                               seconds: 3), // ระยะเวลาในการแสดง SnackBar
  //                         ),
  //                       );
  //                     },
  //                     child: Text('เสมอ'),
  //                   )
  //                 ],
  //                 //children: listWidget,
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

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
