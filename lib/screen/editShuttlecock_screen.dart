import 'package:calculatebadminton/repository/game_repository.dart';
import 'package:flutter/material.dart';

class EditshuttlecockScreen extends StatefulWidget {
  const EditshuttlecockScreen({super.key});

  @override
  State<EditshuttlecockScreen> createState() => _EditshuttlecockScreenState();
}

class _EditshuttlecockScreenState extends State<EditshuttlecockScreen> {
  String gameResult = "";
  int _numberShuttleCock = 0;

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
  //               ),
  //             )
  //           ],
  //         );
  //       });
  // }

  // _showAlertShuttleCock(int gameID) {
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
  //                       }
  //                     },
  //                     child: Text('ลดลูกแบด'),
  //                   )
  //                 ],
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
  //                       GameService gameService = GameService();
  //                       Future<dynamic> games = gameService.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         gameResult = game['results'];
  //                       }
  //                       gameService.editGameResult(gameResult, 1);
  //                       setState(() {
  //                         gameResult = "1";
  //                       });
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
  //                       GameService gameService = GameService();
  //                       Future<dynamic> games = gameService.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         gameResult = game['results'];
  //                       }
  //                       gameService.editGameResult(gameResult, 2);
  //                       setState(() {
  //                         gameResult = "2";
  //                       });
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
  //                       GameService gameService = GameService();
  //                       Future<dynamic> games = gameService.getItem(gameID);
  //                       List list = await games;

  //                       for (var game in list) {
  //                         gameResult = game['results'];
  //                       }
  //                       gameService.editGameResult(gameResult, 3);
  //                       setState(() {
  //                         gameResult = "3";
  //                       });
  //                     },
  //                     child: Text('เสมอ'),
  //                   )
  //                 ],
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
                Future<dynamic> games =
                    gameRepository.getItem(int.parse(args['gameID']));
                List list = await games;

                for (var game in list) {
                  _numberShuttleCock = game['numberShuttleCock'];
                }

                _numberShuttleCock++;

                gameRepository.editShuttleCock(
                    int.parse(args['gameID']), _numberShuttleCock);
                Navigator.pop(context,
                    args['gameID'] + "," + _numberShuttleCock.toString());
              },
              child: Text('เพิ่มลูกแบด'),
            ),
            SizedBox(width: 10),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                GameRepository gameRepository = GameRepository();
                Future<dynamic> games =
                    gameRepository.getItem(int.parse(args['gameID']));
                List list = await games;

                for (var game in list) {
                  _numberShuttleCock = game['numberShuttleCock'];
                }

                _numberShuttleCock--;

                gameRepository.editShuttleCock(
                    int.parse(args['gameID']), _numberShuttleCock);
                Navigator.pop(context,
                    args['gameID'] + "," + _numberShuttleCock.toString());
              },
              child: Text('ลดลูกแบด'),
            )
          ],
          //children: listWidget,
        )),
      ],
    ));
  }
}
