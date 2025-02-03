import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/model/betdetail_model.dart';
import 'package:calculatebadminton/model/game_model.dart';
import 'package:calculatebadminton/repository/betdetail_repository.dart';
import 'package:calculatebadminton/repository/game_repository.dart';
import 'package:calculatebadminton/repository/player_repository.dart';
import 'package:calculatebadminton/screen/game_add_screen.dart';
import 'package:calculatebadminton/screen/player_screen.dart';
import 'package:calculatebadminton/state/state.dart';
import 'package:calculatebadminton/viewmodel/gamescreen_viewmodel.dart';
import 'package:calculatebadminton/widgets/leftnavigation.dart';
import 'package:calculatebadminton/widgets/showalertbox.dart';
import 'package:calculatebadminton/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _load();
    });
  }

  _editResult(gameID, gameResultValue) async {
    GameRepository gameRepository = GameRepository();
    await gameRepository.editGameResult(gameResultValue, gameID);
    Navigator.pop(context);

    final store = StoreProvider.of<AppState>(context);
    int index = store.state.gameState.listGameModel
        .indexWhere((game) => game.gameID == gameID);

    if (index != -1) {
      store.state.gameState.listGameModel[index].results = gameResultValue;
    }
    store.dispatch(
        GameChangeValue(listGameModel: store.state.gameState.listGameModel));
  }

  _editShuttleCock(gameID, numberShuttleCock) async {
    GameRepository gameRepository = GameRepository();
    await gameRepository.editShuttleCock(gameID, numberShuttleCock);
    final store = StoreProvider.of<AppState>(context);
    int index = store.state.gameState.listGameModel
        .indexWhere((game) => game.gameID == gameID);

    if (index != -1) {
      store.state.gameState.listGameModel[index].numberShuttleCock =
          numberShuttleCock;
    }
    store.dispatch(
        GameChangeValue(listGameModel: store.state.gameState.listGameModel));
  }

  _editPlayResult(int gameID) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: [
              SizedBox(height: 20),
              Row(
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
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          await _editResult(gameID, "1");
                          await _load();
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
                          await _editResult(gameID, "2");
                          await _load();
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
                          await _editResult(gameID, "3");
                          await _load();
                        },
                        child: Text('เสมอ'),
                      )
                    ],
                  )),
                ],
              )
            ],
          );
        });
  }

  _load() async {
    List<Map<String, Object?>> data = await GameRepository().getAll();
    List<GameModel> listGameModel =
        data.map((map) => GameModel.fromMap(map)).toList();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(GameChangeValue(listGameModel: listGameModel));

    data = await BetDetailRepository().getAll();
    List<BetDetailModel> listBetDetailModel =
        data.map((map) => BetDetailModel.fromMap(map)).toList();
    store
        .dispatch(BetDetailChangeValue(listBetDetailModel: listBetDetailModel));
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
                    await BetDetailRepository().deleteBetDetail(gameID);
                    await GameRepository().delete(gameID);
                    Navigator.pop(context);
                    await _load();
                    Snackbar.show(context, "ลบข้อมูลเรียบร้อย");
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

  _editShuttlecockFormDialog(
      BuildContext context, gameID, GameModel gameModel) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Column(children: [
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () async {
                      _editShuttleCock(
                          gameID, (gameModel.numberShuttleCock as int) + 1);
                      Navigator.pop(context);
                      await _load();
                    },
                    child: Text('เพิ่มลูกแบด'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green))),
                TextButton(
                    onPressed: () async {
                      if (gameModel.numberShuttleCock == 1) {
                        Navigator.pop(context);
                        String errorMessage =
                            "ไม่สามารถลดลูกแบดได้น้อยกว่า 1 ลูก";
                        ShowAlertBox showAlertBox = ShowAlertBox();
                        return showAlertBox.showError(context, errorMessage);
                      } else {
                        _editShuttleCock(
                            gameID, (gameModel.numberShuttleCock as int) - 1);
                      }
                      Navigator.pop(context);
                      await _load();
                    },
                    child: Text('ลดลูกแบด'),
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.red)))
              ]),
            ],
          );
        });
  }

  List<Widget> _showListBetDetail(int gameID, GameModel gameModel, int index,
      BuildContext buildContext, GameViewmodel vm) {
    var listWidget = <Widget>[];
    var listChildWidget = <Widget>[];

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
    listChildWidget.add(Text(gameModel.team1Name as String,
        style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(Text("เจอกับ", style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(Text(gameModel.team2Name as String,
        style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(Text("ค่าลูก " + typeCostShuttlecock,
        style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 3));
    listChildWidget.add(Text(
        "ใช้ลูกแบด " + gameModel.numberShuttleCock.toString() + " ลูก ",
        style: TextStyle(color: Colors.black)));
    listChildWidget.add(SizedBox(height: 10));
    if (gameModel.typeCostShuttlecock == "1") {
      if (gameID == gameID.toString()) {
        if (gameModel.results == "1") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name.toString() + " แพ้",
              style: TextStyle(color: Colors.black)));
        } else if (gameModel.results == "2") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name.toString() + " ชนะ",
              style: TextStyle(color: Colors.black)));
        } else if (gameModel.results == "3") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name.toString() + " เสมอ",
              style: TextStyle(color: Colors.black)));
        } else {
          listChildWidget.add(Text("ผลการแข่งขัน ยังไม่ได้ใส่ผลการแข่งขัน",
              style: TextStyle(color: Colors.black)));
        }
      } else {
        if (gameModel.results == "1") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name.toString() + " แพ้",
              style: TextStyle(color: Colors.black)));
        } else if (gameModel.results == "2") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name.toString() + " ชนะ",
              style: TextStyle(color: Colors.black)));
        } else if (gameModel.results == "3") {
          listChildWidget.add(Text(
              "ผลการแข่งขัน " + gameModel.team1Name.toString() + " เสมอ",
              style: TextStyle(color: Colors.black)));
        } else {
          listChildWidget.add(Text("ผลการแข่งขัน ยังไม่ได้ใส่ผลการแข่งขัน",
              style: TextStyle(color: Colors.black)));
        }
      }
    }
    bool isFirst = true;
    for (int i = 0; i < vm.listBetDetailModel.length; i++) {
      if (gameID == vm.listBetDetailModel[i].gameID) {
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
          vm.listBetDetailModel[i].betPlayerName.toString(),
          style: TextStyle(color: Colors.green, fontSize: 17),
        ));
        listChildWidget.add(SizedBox(height: 5));
        listChildWidget.add(Text("จับนอกคู่"));
        listChildWidget.add(Text(vm.listBetDetailModel[i].betTeamName == ""
            ? ""
            : vm.listBetDetailModel[i].betTeamName.toString()));
        listChildWidget
            .add(Text(vm.listBetDetailModel[i].betValue.toString() + " บาท"));
        listChildWidget.add(SizedBox(height: 10));
      }
    }
    listChildWidget.add(SizedBox(height: 10));
    listChildWidget.add(Row(
      children: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () async {
            _editShuttlecockFormDialog(context, gameID, gameModel);
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
          onPressed: () {
            _deleteFormDialog(context, gameID);
          },
          child: Text('ลบข้อมูลนี้'),
        )
      ],
    ));
    listWidget.add(Container(
        width: 400,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: AppBar(
        title: Text('รายการเกม', style: TextStyle(color: Colors.white)),
      ),
      body: StoreConnector<AppState, GameViewmodel>(
        converter: (store) => GameViewmodel(
            listGameModel: store.state.gameState.listGameModel,
            listBetDetailModel: store.state.betDetailState.listBetDetailModel),
        builder: (context, vm) {
          if (vm.listGameModel.length > 0) {
            return SingleChildScrollView(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: vm.listGameModel.length,
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _showListBetDetail(
                          vm.listGameModel[index].gameID as int,
                          vm.listGameModel[index],
                          index,
                          context,
                          vm),
                    );
                  }),
            );
          } else {
            return Text(
              "",
              style: TextStyle(fontSize: 40),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          List<Map> countMap = await PlayerRepository().count();
          int listPlayerLength = 0;
          countMap.forEach((player) {
            listPlayerLength = player['count'];
          });
          if (listPlayerLength > 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => GameAddScreen()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlayerScreen()),
            );
            ShowAlertBox().showError(context,
                "ต้องเพิ่มผู้เล่นให้มากกว่า 4 คน เพราะแบดมินตันตีคู่ จะมีอย่างน้อย 4คน");
          }
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          'เพิ่มเกม',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
