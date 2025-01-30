import 'dart:convert';
import 'package:calculatebadminton/model/player_model.dart';
import 'package:calculatebadminton/repository/betdetail_repository.dart';
import 'package:calculatebadminton/repository/game_repository.dart';
import 'package:calculatebadminton/repository/player_repository.dart';
import 'package:calculatebadminton/repository/setting_repository.dart';
import 'package:calculatebadminton/widgets/left_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String strPayment = "";
  String playerID = "";
  int gameCount = 0;
  int countShuttleCock = 0;
  int costCort = 0;
  int costShuttleCock = 0;
  int paymentCostShuttleCock = 0;
  double costBetRevenue = 0;
  double costBetExpenses = 0;
  double costSumary = 0;
  String listNotSetPaymentResult = "";
  double calculateCostShuttleCock = 0;
  double calculateCostShuttleCockTest = 0;
  String playerName = "";
  @override
  void initState() {
    super.initState();
  }

  // _getList() async {
  //   GameRepository gameRepository = GameRepository();
  //   return await gameRepository.getAll();
  // }

  // _getListGame() async {
  //   Future<dynamic> getlistGame = _getList();
  //   List list = await getlistGame;
  // }

  @override
  dispose() {
    super.dispose();
  }

  int _calculateGameCount(List listGame) {
    setState(() {
      gameCount = listGame.length;
    });
    return listGame.length;
  }

  int _calculteShuttleCockCount(List listGame) {
    int _countShuttleCock = 0;
    for (var game in listGame) {
      if (game['numberShuttleCock'] == null) {
        _countShuttleCock = _countShuttleCock + 1;
      } else {
        _countShuttleCock =
            _countShuttleCock + int.parse(game['numberShuttleCock']);
      }
    }
    setState(() {
      countShuttleCock = _countShuttleCock;
    });
    return _countShuttleCock;
  }

  Future<String> _getSettingValue() async {
    SettingRepository settingRepository = SettingRepository();
    Future<dynamic> listSettings = settingRepository.getAll();
    List list = await listSettings;
    String errorMessage = "";
    if (list.length == 0) {
      errorMessage = errorMessage +
          "ยังไม่ได้ใส่ค่าคอดแบด หรือ ค่าลูกแบด จากเมนูตั้งค่า\n";
    } else {
      for (var listSetting in list) {
        setState(() {
          costCort = listSetting['costCort'] * -1;
          costShuttleCock = listSetting['costShuttleCock'];
        });
      }
    }
    if (playerID == "") {
      errorMessage = "";
      errorMessage = errorMessage + "ยังไม่ได้เลือกผู้เล่น";
    }
    GameRepository gameRepository = GameRepository();
    List listGame = await gameRepository.getListPaymentByPlayID(playerID);
    if (listGame.length == 0) {
      costCort = 0;
    }
    return errorMessage;
  }

  _showAlertError(String errorMessage) {
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
                    Text(
                      "พบข้อผิดพลาดดังนี้",
                      style: TextStyle(color: Colors.pinkAccent, fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(errorMessage),
                    SizedBox(height: 10),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text('ปิด'),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }

  _calculateBet(List listGame) async {
    BetDetailRepository betDetailRepository = BetDetailRepository();
    GameRepository gameRepository = GameRepository();
    List listGame = await gameRepository.getAll();
    for (var game in listGame) {
      Future<dynamic> betDetails =
          betDetailRepository.getListBetDetail(game['id'], playerID);
      List listBet = await betDetails;
      setState(() {
        for (var bet in listBet) {
          if (game['team1ID'] == bet['betTeamID']) {
            if (game['results'].toString() == "1") {
              costBetExpenses = costBetExpenses + bet['betValue'];
            } else if (game['results'].toString() == "2") {
              costBetRevenue = costBetRevenue + bet['betValue'];
            } else if (game['results'].toString() == "3") {}
          } else {
            if (game['results'].toString() == "1") {
              costBetRevenue = costBetRevenue + bet['betValue'];
            } else if (game['results'].toString() == "2") {
              costBetExpenses = costBetExpenses + bet['betValue'];
            } else if (game['results'].toString() == "3") {}
          }
        }
      });
    }
    if (costBetExpenses > 0) {
      costBetExpenses = costBetExpenses * -1;
    }

    // setState(() {
    //   for (var betDetail in list) {
    //     if (listGame['team1ID'].toString() ==
    //         betDetail['betTeamID'].toString()) {
    //       if (listGame['results'].toString() == "1") {
    //         costBetExpenses = double.parse(betDetail['betValue'].toString());
    //       } else if (listGame['results'].toString() == "2") {
    //         costBetRevenue = double.parse(betDetail['betValue'].toString());
    //       }
    //     } else {
    //       if (listGame['results'].toString() == "1") {
    //         costBetRevenue = double.parse(betDetail['betValue'].toString());
    //       } else if (listGame['results'].toString() == "2") {
    //         costBetExpenses = double.parse(betDetail['betValue'].toString());
    //       }
    //     }
    //   }
    // });
    if (listGame.length == 0) {
      costCort = 0;
    }
    setState(() {
      costSumary = costCort +
          calculateCostShuttleCock +
          costBetExpenses +
          costBetRevenue;

      strPayment = "ผู้เล่น " + playerName + "\n";
      strPayment = strPayment + "รายละเอียดเกม\n";
      strPayment = strPayment + "ตีทั้งหมด " + gameCount.toString() + " เกม\n";
      strPayment =
          strPayment + "ใช้ลูกแบด " + countShuttleCock.toString() + " ลูก\n";
      strPayment = strPayment + "รายละเอียดการจ่ายเงิน\n";
      strPayment = strPayment +
          "ค่าคอดแบด " +
          (costCort < 0 ? costCort * -1 : costCort).toString() +
          " บาท\n";
      strPayment = strPayment +
          "ค่าลูกแบด " +
          (calculateCostShuttleCock < 0
                  ? calculateCostShuttleCock * -1
                  : calculateCostShuttleCock)
              .toString() +
          " บาท\n";
      strPayment =
          strPayment + "ได้จับนอก " + costBetRevenue.toString() + " บาท\n";
      strPayment = strPayment +
          "เสียจับนอก " +
          (costBetExpenses < 0 ? costBetExpenses * -1 : costBetExpenses)
              .toString() +
          " บาท\n";
      if (costSumary > 0) {
        strPayment = strPayment + "รวมต้องได้เงิน $costSumary บาท";
      } else {
        strPayment = strPayment +
            "รวมต้องจ่ายเงิน " +
            (costSumary < 0 ? costSumary * -1 : costSumary).toString() +
            " บาท";
      }
    });
  }

  _calCulateCostShuttleCock(List listGame) {
    try {
      double twentyFivePersent = 25 / 100;
      double fiftyPersent = 50 / 100;
      calculateCostShuttleCockTest = 0;
      for (var game in listGame) {
        if (game['results'].toString() == "0") {
          calculateCostShuttleCockTest = calculateCostShuttleCockTest +
              (game['numberShuttleCock'] * costShuttleCock * twentyFivePersent);
        } else if (game['results'].toString() == "1") {
          if (game['team1ID'].toString().contains(playerID)) {
            calculateCostShuttleCockTest = calculateCostShuttleCockTest +
                (game['numberShuttleCock'] * costShuttleCock * fiftyPersent);
          }
        } else if (game['results'].toString() == "2") {
          if (game['team1ID'].toString().contains(playerID)) {
          } else {
            calculateCostShuttleCockTest = calculateCostShuttleCockTest +
                (game['numberShuttleCock'] * costShuttleCock * fiftyPersent);
          }
        } else if (game['results'].toString() == "3") {
          calculateCostShuttleCockTest = calculateCostShuttleCockTest +
              (game['numberShuttleCock'] * costShuttleCock * twentyFivePersent);
        }
      }
    } catch (exception) {
      print('$exception');
    }
  }

  //   setState(() {
  //     // calculateCostShuttleCock = calculateCostShuttleCockTest < 0
  //     //     ? calculateCostShuttleCockTest * -1
  //     //     : calculateCostShuttleCockTest;
  //     if (calculateCostShuttleCockTest < 1) {
  //       calculateCostShuttleCock = calculateCostShuttleCockTest;
  //     } else {
  //       calculateCostShuttleCock = calculateCostShuttleCockTest * -1;
  //     }
  //   });
  // }

  String _validateCalculatePayment(List listGame) {
    bool isFirst = true;
    bool isPass = true;
    listNotSetPaymentResult = "";
    for (var game in listGame) {
      if (game['typeCostShuttlecock'].toString() == "2") {
      } else {
        if (game['results'].toString() == "0") {
          if (isFirst) {
            listNotSetPaymentResult += game['id'].toString();
            isFirst = false;
          } else {
            listNotSetPaymentResult += "," + game['id'].toString();
            isFirst = false;
          }
          isPass = false;
        }
      }
    }
    return isPass.toString().toLowerCase() + "|" + listNotSetPaymentResult;
  }

  _calCulatePayment() async {
    setState(() {
      costSumary = 0;
      calculateCostShuttleCock = 0;
      costBetExpenses = 0;
      costBetRevenue = 0;
    });
    GameRepository gameRepository = GameRepository();
    List listGame = await gameRepository.getListPaymentByPlayID(playerID);
    List listAllGame = await gameRepository.getAll();
    String validateCalculatePayment = _validateCalculatePayment(listAllGame);
    var arrValidateCalculatePayment = validateCalculatePayment.split("|");
    if (arrValidateCalculatePayment[0].toString() == "false") {
      return _showAlertError("เกมที่ " +
          arrValidateCalculatePayment[1].toString() +
          " ยังไม่ได้ใส่ผลการแข่งขัน");
    }

    _calculateGameCount(listGame);
    _calculteShuttleCockCount(listGame);
    _calCulateCostShuttleCock(listGame);
    _calculateBet(listGame);
  }

  _sendMessageToLineGroup() async {
    try {
      var url = Uri.parse('https://api.line.me/v2/bot/message/multicast');
      // var response = await http.post(url,
      await http.post(url,
          body: jsonEncode({
            "to": ["U4f66d9015b4e54788cbb90bff5a647fc"],
            "messages": [
              {"type": "text", "text": "$strPayment"}
            ]
          }),
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'Bearer QbsfzwaqSmgJOg32ld4gQzXMlFcR94Mg8IVDYUSMKGNBJ7bSaOufM6zXbFtFqhv5j3FnEeFCQjpQz0Jjqksh8h9Glcume/uBZ2XzxMsDQjoT1/ga0wlB6H6v+CSb0+2O25OeoseelQz3xaV8HxENdAdB04t89/1O/w1cDnyilFU='
          });
      // body: jsonEncode({
      //   "to": ["U4f66d9015b4e54788cbb90bff5a647fc"],
      //   "messages": [
      //     {"type": "text", "text": "$strPayment"}
      //   ]
      // }),
    } catch (exception) {
      print(exception);
    }
  }

  // _genListWidgetPayment() {
  //   List<Widget> listPayment = [];
  // }

  Future<List<PlayerModel>> getListPlayer(filter) async {
    var _playerService = PlayerRepository();
    List<PlayerModel> _playList = [];
    List<Map> playerList = await _playerService.getAll();
    playerList.forEach((player) {
      var playerModel = PlayerModel(id: 0, name: "");
      playerModel.id = player['id'];
      playerModel.name = player['name'];
      _playList.add(playerModel);
    });
    return _playList;
  }

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
          // FindDropdown<PlayerModel>(
          //   label: "ผู้เล่น",
          //   showSearchBox: false,
          //   showClearButton: false,
          //   dropdownItemBuilder: (context, item, isSelected) {
          //     return ListTile(
          //       leading: CircleAvatar(
          //           backgroundColor: Colors.white,
          //           child: Icon(
          //             MdiIcons.badminton,
          //             color: Colors.black,
          //             size: 25,
          //           )),
          //       title: Text(item.name.toString()),
          //       trailing: isSelected ? Icon(Icons.check) : null,
          //       selected: isSelected,
          //     );
          //   },
          //   dropdownBuilder: (BuildContext context, PlayerModel? item) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Theme.of(context).dividerColor),
          //         borderRadius: BorderRadius.circular(5),
          //         color: Colors.white,
          //       ),
          //       child: (item == null)
          //           ? ListTile(
          //               leading: CircleAvatar(),
          //               title: Text("No item selected"))
          //           : ListTile(
          //               leading: CircleAvatar(
          //                   backgroundColor: Colors.white,
          //                   child: Icon(
          //                     MdiIcons.badminton,
          //                     color: Colors.black,
          //                     size: 25,
          //                   )),
          //               title: Text(item.name),
          //             ),
          //     );
          //   },
          //   onFind: (String filter) => getListPlayer(filter),
          //   onChanged: (PlayerModel? player) {
          //     if (mounted) {
          //       setState(() {
          //         playerID = player!.id.toString();
          //         playerName = player.name;
          //       });
          //     }
          //   },
          // ),
          TextButton(
              onPressed: () async {
                try {
                  String errorMessage = await _getSettingValue();
                  if (errorMessage != "") {
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
                                    Text(
                                      "พบข้อผิดพลาดดังนี้",
                                      style: TextStyle(
                                          color: Colors.pinkAccent,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 10),
                                    // Text(errorMessage),
                                    SizedBox(height: 10),
                                    Text(errorMessage),
                                    SizedBox(height: 10),
                                    TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.blue),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      },
                                      child: Text('ปิด'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  }
                  _calCulatePayment();
                  _sendMessageToLineGroup();
                } catch (ex) {
                  throw ex;
                }
              },
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
          Text("ตีทั้งหมด " + gameCount.toString() + " เกม ",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Text("ใช้ลูกแบด " + countShuttleCock.toString() + " ลูก",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Text("รายละเอียดการจ่ายเงิน",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Text(
              "ค่าคอดแบด " +
                  (costCort < 0 ? costCort * -1 : costCort).toString() +
                  " บาท",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Text(
              "ค่าลูกแบด " +
                  (calculateCostShuttleCock < 0
                          ? calculateCostShuttleCock * -1
                          : calculateCostShuttleCock)
                      .toString() +
                  " บาท",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Text("ได้จับนอก " + costBetRevenue.toString() + " บาท",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Text(
              "เสียจับนอก " +
                  (costBetExpenses < 0 ? costBetExpenses * -1 : costBetExpenses)
                      .toString() +
                  " บาท",
              style: TextStyle(color: Colors.green, fontSize: 17)),
          SizedBox(
            height: 10,
          ),
          Divider(
            height: 30,
          ),
          costSumary > 0
              ? Text("รวมต้องได้เงิน $costSumary บาท",
                  style: TextStyle(color: Colors.blue, fontSize: 25))
              : Text(
                  "รวมต้องจ่ายเงิน " +
                      (costSumary < 0 ? costSumary * -1 : costSumary)
                          .toString() +
                      " บาท",
                  style: TextStyle(color: Colors.blue, fontSize: 25)),
          Divider(
            height: 20,
          ),
        ])),
      ),
    );
  }
}
