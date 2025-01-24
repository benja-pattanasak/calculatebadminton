import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameService gameService;
  BetDetailService betDetailService;
  List<GameModel> listGame;
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  List<BetDetailModel> listBetDetailModel;
  int numberShuttleCock;
  String gameResult;
  String updateRowNumber;
  int _numberShuttleCock;
  @override
  void initState() {
    super.initState();
    listBetDetailModel = List<BetDetailModel>();
    gameService = GameService();
    betDetailService = BetDetailService();
    listGame = List<GameModel>();
    _getListBetDetail();
    _getListGame();
  }

  @override
  dispose() {
    gameService = null;
    betDetailService = null;
    listGame.clear();
    listBetDetailModel.clear();
    super.dispose();
  }

  _getListBetDetail() async {
    listBetDetailModel.clear();
    List<Map> getItemByGameIDTemp = await betDetailService.getAll();
    List list = await getItemByGameIDTemp;
    for (var betdetail in list) {
      BetDetailModel betDetailModel = BetDetailModel();
      betDetailModel.betPlayerID = int.parse(betdetail["betPlayerID"]);
      betDetailModel.betPlayerName = betdetail["betPlayerName"];
      betDetailModel.betTeamID = betdetail["betTeamID"];
      betDetailModel.betTeamName = betdetail["betTeamName"];
      betDetailModel.betValue = betdetail["betValue"];
      betDetailModel.id = betdetail["id"];
      betDetailModel.gameID = int.parse(betdetail["gameID"]);
      listBetDetailModel.add(betDetailModel);
    }
  }

  _showSuccessSnackBar(message) {
    var _snackBar = SnackBar(content: message);
    //_globalKey.currentState.showSnackBar(_snackBar);
  }

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

  _showAlertShuttleCock(int gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          numberShuttleCock = game['numberShuttleCock'];
                        }
                        setState(() {
                          numberShuttleCock++;
                        });

                        await gameService.editShuttleCock(
                            gameID, numberShuttleCock);

                        _showSuccessSnackBar(Text("เพิ่มลูกแบดเรียบร้อย"));
                      },
                      child: Text('เพิ่มลูกแบด'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          numberShuttleCock = game['numberShuttleCock'];
                        }
                        if (numberShuttleCock == 1) {
                          String errorMessage =
                              "ไม่สามารถลดลูกแบดได้น้อยกว่า 1 ลูก";
                          ShowAlertBox showAlertBox = ShowAlertBox();
                          return showAlertBox.ShowError(context, errorMessage);
                        } else {
                          setState(() {
                            numberShuttleCock--;
                          });
                          await gameService.editShuttleCock(
                              gameID, numberShuttleCock);
                          _showSuccessSnackBar(Text("ลดลูกแบดเรียบร้อย"));
                        }
                      },
                      child: Text('ลดลูกแบด'),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  _showAlertPlayResult(int gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          gameResult = game['results'];
                        }
                        await gameService.editGameResult(gameResult, 1);
                        setState(() {
                          gameResult = "1";
                        });

                        _showSuccessSnackBar(
                            Text("แก้ไขผลการแข่งขันเรียบร้อย"));
                      },
                      child: Text('แพ้'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          gameResult = game['results'];
                        }
                        await gameService.editGameResult(gameResult, 2);
                        setState(() {
                          gameResult = "2";
                        });
                        _showSuccessSnackBar(
                            Text("แก้ไขผลการแข่งขันเรียบร้อย"));
                      },
                      child: Text('ชนะ'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          gameResult = game['results'];
                        }
                        await gameService.editGameResult(gameResult, 3);
                        setState(() {
                          gameResult = "3";
                        });
                        _showSuccessSnackBar(
                            Text("แก้ไขผลการแข่งขันเรียบร้อย"));
                      },
                      child: Text('เสมอ'),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  _editPlayResult(int gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                //key: _globalKey,
                children: [
                  Center(
                      child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          GameService gameService = GameService();
                          await gameService.editGameResult("1", gameID);
                          Navigator.pop(context);
                          listGame.clear();
                          setState(() {
                            gameResult = "1";
                          });
                          _getListBetDetail();
                          _getListGame();
                        },
                        child: Text('แพ้'),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          GameService gameService = GameService();
                          await gameService.editGameResult("2", gameID);
                          Navigator.pop(context);
                          listGame.clear();
                          setState(() {
                            gameResult = "2";
                          });
                          _getListBetDetail();
                          _getListGame();
                        },
                        child: Text('ชนะ'),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          GameService gameService = GameService();
                          await gameService.editGameResult("3", gameID);
                          Navigator.pop(context);
                          listGame.clear();
                          setState(() {
                            gameResult = "3";
                          });
                          _getListBetDetail();
                          _getListGame();
                        },
                        child: Text('เสมอ'),
                      )
                    ],
                    //children: listWidget,s
                  )),
                ],
              )
            ],
          );
        });
  }

  List<Widget> _showListBetDetail(
      int gameID, GameModel gameModel, int index, BuildContext buildContext) {
    var listWidget = <Widget>[];
    var listChildWidget = <Widget>[];

    String strGameDetail = "";
    String typeCostShuttlecock = "";
    if (gameModel.typeCostShuttlecock == "1") {
      typeCostShuttlecock = "แพ้จ่าย";
    } else {
      typeCostShuttlecock = "หาร";
    }
    listChildWidget.add(SizedBox(height: 10));
    listChildWidget.add(Text(
      "เกมที่ " + (index + 1).toString(),
      style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
    ));
    listChildWidget.add(SizedBox(height: 10));
    listChildWidget.add(Text(
      "รายละเอียดเกม",
      style: TextStyle(color: Colors.blue),
    ));
    listChildWidget.add(SizedBox(height: 10));
    listChildWidget
        .add(Text(gameModel.team1Name, style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(Text("เจอกับ", style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget
        .add(Text(gameModel.team2Name, style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(Text("ค่าลูก " + typeCostShuttlecock,
        style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    // if (numberShuttleCock == null) {
    //   List<String> listUpdateRowNumber = updateRowNumber.toString().split(',');
    //   if (listUpdateRowNumber[0].toString() == gameID.toString()) {
    //     listChildWidget.add(Text(
    //         "ใช้ลูกแบด " + listUpdateRowNumber[1].toString() + " ลูก ",
    //         style: TextStyle(color: Colors.black)));
    //   } else {
    listChildWidget.add(Text(
        "ใช้ลูกแบด " + gameModel.numberShuttleCock.toString() + " ลูก ",
        style: TextStyle(color: Colors.black)));
    //   }
    // }
    listChildWidget.add(SizedBox(height: 10));
    if (gameModel.typeCostShuttlecock == "1") {
      if (gameID == gameID.toString()) {
        if (gameResult == "1") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name + " แพ้",
              style: TextStyle(color: Colors.black)));
        } else if (gameResult == "2") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name + " ชนะ",
              style: TextStyle(color: Colors.black)));
        } else if (gameResult == "3") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name + " เสมอ",
              style: TextStyle(color: Colors.black)));
        } else {
          listChildWidget.add(Text("ผลการแข่งขัน ยังไม่ได้ใส่ผลการแข่งขัน",
              style: TextStyle(color: Colors.black)));
        }
      } else {
        if (gameModel.results == "1") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name + " แพ้",
              style: TextStyle(color: Colors.black)));
        } else if (gameModel.results == "2") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name + " ชนะ",
              style: TextStyle(color: Colors.black)));
        } else if (gameModel.results == "3") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name + " เสมอ",
              style: TextStyle(color: Colors.black)));
        } else {
          listChildWidget.add(Text("ผลการแข่งขัน ยังไม่ได้ใส่ผลการแข่งขัน",
              style: TextStyle(color: Colors.black)));
        }
      }
    }
    bool isFirst = true;
    for (int i = 0; i < listBetDetailModel.length; i++) {
      if (gameID == listBetDetailModel[i].gameID) {
        if (isFirst) {
          listChildWidget.add(SizedBox(height: 10));
          listChildWidget.add(Text(
            "รายละเอียดจับนอก",
            style: TextStyle(color: Colors.blue),
          ));
          listChildWidget.add(SizedBox(height: 5));
          isFirst = false;
        }
        listChildWidget.add(Text(
          listBetDetailModel[i].betPlayerName,
          style: TextStyle(color: Colors.green, fontSize: 17),
        ));
        listChildWidget.add(SizedBox(height: 5));
        listChildWidget.add(Text("จับนอกคู่"));
        listChildWidget.add(Text(listBetDetailModel[i].betTeamName == null
            ? ""
            : listBetDetailModel[i].betTeamName));
        listChildWidget
            .add(Text(listBetDetailModel[i].betValue.toString() + " บาท"));
        listChildWidget.add(SizedBox(height: 10));
      }
    }
    listChildWidget.add(SizedBox(height: 10));
    String strListBetDetail = "";
    //if (gameID == gameID.toString()) {

    //}
    // if (listBetDetailModel.length > 0) {
    if (gameModel.typeCostShuttlecock == "1") {
      listChildWidget.add(Row(
        children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              // Map<String, dynamic> args = {"gameID": gameID.toString()};
              // String returnNumberShutterCock = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     settings:
              //         RouteSettings(arguments: args // ส่งค่าไปใน  arguments
              //             ),
              //     builder: (context) => EditShuttlecockScreen(),
              //  ),
              //);
              //setState(() {
              //  updateRowNumber = returnNumberShutterCock;
              //});
              _editShuttlecockFormDialog(context, gameID);
            },
            child: Text('ลูกแบด'),
          ),
          SizedBox(
            width: 5,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              // Map<String, dynamic> args = {"gameID": gameID.toString()};
              // String returnPlayResult = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     settings:
              //         RouteSettings(arguments: args // ส่งค่าไปใน  arguments
              //             ),
              //     builder: (context) => EditPlayResultScreen(),
              //   ),
              // );
              // setState(() {
              //   updateRowNumber = returnPlayResult;
              // });
              //jay
              // _editPlayResult(
              //   context,
              // );
              _editPlayResult(gameID);
            },
            child: Text('ผลการแข่งขัน'),
          ),
          SizedBox(
            width: 5,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              _deleteFormDialog(context, gameID);
            },
            child: Text('ลบข้อมูลนี้'),
          )
        ],
      ));
    } else {
      listChildWidget.add(Row(
        children: [
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              // Map<String, dynamic> args = {"gameID": gameID.toString()};
              // String returnNumberShutterCock = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     settings:
              //         RouteSettings(arguments: args // ส่งค่าไปใน  arguments
              //             ),
              //     builder: (context) => EditShuttlecockScreen(),
              //   ),
              // );
              // setState(() {
              //   updateRowNumber = returnNumberShutterCock;
              // });
              _editShuttlecockFormDialog(context, gameID);
            },
            child: Text('ลูกแบด'),
          ),
          SizedBox(
            width: 5,
          ),
          SizedBox(
            width: 5,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            onPressed: () async {
              _deleteFormDialog(context, gameID);
            },
            child: Text('ลบข้อมูลนี้'),
          )
        ],
      ));
    }

    listWidget.add(Container(
        width: 350,
        child: Padding(
          padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
          child: Card(
            elevation: 8.0,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listChildWidget,
                  ),
                ],
              ),
            ),
          ),
        )));
    return listWidget;
  }

  _getListGame() async {
    listGame.clear();
    List<Map> listMapGame = await gameService.getAll();
    List list = await listMapGame;
    for (var game in list) {
      var gameModel = GameModel();
      gameModel.gameID = game["id"];
      gameModel.team1ID = game["team1ID"];
      gameModel.team1Name = game["team1Name"];
      gameModel.team2ID = game["team2ID"];
      gameModel.team2Name = game["team2Name"];
      gameModel.typeCostShuttlecock = game["typeCostShuttlecock"];
      gameModel.numberShuttleCock = game["numberShuttleCock"];
      gameModel.results = game["results"];
      listGame.add(gameModel);
    }
    setState(() {
      listGame = listGame;
    });
    // listMapGame.forEach((game) {
    //   var gameModel = GameModel();
    //   gameModel.gameID = game["id"];
    //   gameModel.team1ID = game["team1ID"];
    //   gameModel.team1Name = game["team1Name"];
    //   gameModel.team2ID = game["team2ID"];
    //   gameModel.team2Name = game["team2Name"];
    //   gameModel.typeCostShuttlecock = game["typeCostShuttlecock"];
    //   gameModel.numberShuttleCock = game["numberShuttleCock"];
    //   gameModel.results = game["results"];
    //   setState(() {
    //     listGame.add(gameModel);
    //   });
    //});
  }

  _deleteFormDialog(BuildContext context, gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
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
                    await betDetailService.deleteBetDetail(gameID);
                    await gameService.delete(gameID);
                    Navigator.pop(context);
                    listGame.clear();
                    await _getListBetDetail();
                    await _getListGame();
                    _showSuccessSnackBar(Text('ลบข้อมูลเรียบร้อย'));
                  },
                  child: Text('ลบข้อมูล'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.red)))
            ],
            title: Text('ต้องการลบรายการนี้ใช่หรือไม่'),
          );
        });
  }

  _showAlertPlayResultEdit(int gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        GameService gameService = GameService();
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          gameResult = game['results'];
                        }
                        await gameService.editGameResult(gameResult, 1);
                        setState(() {
                          gameResult = "1";
                        });
                      },
                      child: Text('แพ้'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        GameService gameService = GameService();
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          gameResult = game['results'];
                        }
                        await gameService.editGameResult(gameResult, 2);
                        setState(() {
                          gameResult = "2";
                        });
                      },
                      child: Text('ชนะ'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        GameService gameService = GameService();
                        Future<dynamic> games =
                            await gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          gameResult = game['results'];
                        }
                        await gameService.editGameResult(gameResult, 3);
                        setState(() {
                          gameResult = "3";
                        });
                      },
                      child: Text('เสมอ'),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  _showAlertShuttleCockEdit(int gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                        GameService gameService = GameService();
                        Future<dynamic> games = gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          _numberShuttleCock = game['numberShuttleCock'];
                        }
                        setState(() {
                          _numberShuttleCock++;
                        });

                        gameService.editShuttleCock(gameID, _numberShuttleCock);
                      },
                      child: Text('เพิ่มลูกแบด'),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        GameService gameService = GameService();
                        Future<dynamic> games = gameService.getItem(gameID);
                        List list = await games;

                        for (var game in list) {
                          _numberShuttleCock = game['numberShuttleCock'];
                        }
                        if (_numberShuttleCock == 1) {
                          String errorMessage =
                              "ไม่สามารถลดลูกแบดได้น้อยกว่า 1 ลูก";
                          ShowAlertBox showAlertBox = ShowAlertBox();
                          return showAlertBox.ShowError(context, errorMessage);
                        } else {
                          setState(() {
                            _numberShuttleCock--;
                          });
                          gameService.editShuttleCock(
                              gameID, _numberShuttleCock);
                        }
                      },
                      child: Text('ลดลูกแบด'),
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  _editShuttlecockFormDialog(BuildContext context, gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              TextButton(
                  onPressed: () async {
                    GameService gameService = GameService();
                    Future<dynamic> games = gameService.getItem(gameID);
                    List list = await games;

                    for (var game in list) {
                      _numberShuttleCock = game['numberShuttleCock'];
                    }

                    _numberShuttleCock++;

                    gameService.editShuttleCock(gameID, _numberShuttleCock);
                    Navigator.pop(context);
                    listGame.clear();
                    await _getListBetDetail();
                    await _getListGame();
                  },
                  child: Text('เพิ่มลูกแบด'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.green))),
              TextButton(
                  onPressed: () async {
                    GameService gameService = GameService();
                    Future<dynamic> games = gameService.getItem(gameID);
                    List list = await games;

                    for (var game in list) {
                      _numberShuttleCock = game['numberShuttleCock'];
                    }
                    if (_numberShuttleCock == 1) {
                      Navigator.pop(context);
                      String errorMessage =
                          "ไม่สามารถลดลูกแบดได้น้อยกว่า 1 ลูก";
                      ShowAlertBox showAlertBox = ShowAlertBox();
                      return showAlertBox.ShowError(context, errorMessage);
                    } else {
                      _numberShuttleCock--;

                      gameService.editShuttleCock(gameID, _numberShuttleCock);
                    }
                    Navigator.pop(context);
                    listGame.clear();
                    await _getListBetDetail();
                    await _getListGame();
                  },
                  child: Text('ลดลูกแบด'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.red)))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _globalKey,
      drawer: LeftNavigation(),
      appBar: AppBar(
        title: Text('รายการเกม'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listGame == null ? 0 : listGame.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _showListBetDetail(
                      listGame[index].gameID, listGame[index], index, context),
                );
              }),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Map<String, dynamic> args = {"gameID": ""};
          String isRefresh = await Navigator.push(
            context,
            MaterialPageRoute(
              settings: RouteSettings(arguments: args // ส่งค่าไปใน  arguments
                  ),
              builder: (context) => GameAddScreen(),
            ),
          );
          // if (isRefresh == "false") {

          // }
          await _getListBetDetail();
          await _getListGame();
        },
        icon: Icon(Icons.add),
        label: Text('เพิ่มเกม'),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
