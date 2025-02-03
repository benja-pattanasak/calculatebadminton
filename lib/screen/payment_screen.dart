import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/model/payment_model.dart';
import 'package:calculatebadminton/model/player_model.dart';
import 'package:calculatebadminton/repository/betdetail_repository.dart';
import 'package:calculatebadminton/repository/game_repository.dart';
import 'package:calculatebadminton/repository/player_repository.dart';
import 'package:calculatebadminton/repository/setting_repository.dart';
import 'package:calculatebadminton/screen/game_screen.dart';
import 'package:calculatebadminton/state/state.dart';
import 'package:calculatebadminton/viewmodel/payment_viewmodel.dart';
import 'package:calculatebadminton/widgets/leftnavigation.dart';
import 'package:calculatebadminton/widgets/showalertbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final store = StoreProvider.of<AppState>(context, listen: false);
      if (store.state.playerState.listPlayerModel.length == 0) {
        List<Map<String, Object?>> data = await PlayerRepository().getAll();
        List<PlayerModel> listPlayerModel =
            data.map((map) => PlayerModel.fromMap(map)).toList();
        store.dispatch(PlayerChangeValue(listPlayerModel));
      }
    });
  }

  String _validateCalculatePayment(List listGame) {
    bool isFirst = true;
    bool isPass = true;
    String listNotSetPaymentResult = "";
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

  _calCulatePayment(PaymentViewmodel vm) async {
    GameRepository gameRepository = GameRepository();
    List listGame = await gameRepository.getListPaymentByPlayID(vm.payPlayerID);
    List listAllGame = await gameRepository.getAll();
    String validateCalculatePayment = _validateCalculatePayment(listAllGame);
    var arrValidateCalculatePayment = validateCalculatePayment.split("|");
    if (arrValidateCalculatePayment[0].toString() == "false") {
      return _showAlertError("เกมที่ " +
          arrValidateCalculatePayment[1].toString() +
          " ยังไม่ได้ใส่ผลการแข่งขัน");
    }
    _calculateGameCount(listGame, vm);
    _calculteShuttleCockCount(listGame, vm);
    _calCulateCostShuttleCock(listGame, vm);
    _calculateBet(vm);
  }

  _calculateBet(PaymentViewmodel vm) async {
    BetDetailRepository betDetailRepository = BetDetailRepository();
    GameRepository gameRepository = GameRepository();
    List listGame = await gameRepository.getAll();
    for (var game in listGame) {
      Future<dynamic> betDetails =
          betDetailRepository.getListBetDetail(game['id'], vm.payPlayerID);
      List listBet = await betDetails;
      for (var bet in listBet) {
        if (game['team1ID'] == bet['betTeamID']) {
          if (game['results'].toString() == "1") {
            vm.costBetExpenses = vm.costBetExpenses + bet['betValue'];
          } else if (game['results'].toString() == "2") {
            vm.costBetRevenue = vm.costBetRevenue + bet['betValue'];
          } else if (game['results'].toString() == "3") {}
        } else {
          if (game['results'].toString() == "1") {
            vm.costBetRevenue = vm.costBetRevenue + bet['betValue'];
          } else if (game['results'].toString() == "2") {
            vm.costBetExpenses = vm.costBetExpenses + bet['betValue'];
          } else if (game['results'].toString() == "3") {}
        }
      }
    }
    if (vm.costBetExpenses > 0) {
      vm.costBetExpenses = vm.costBetExpenses * -1;
    }

    if (listGame.length == 0) {
      vm.costCort = 0;
    }
    vm.costSumary = vm.costCort +
        vm.calculateCostShuttleCock +
        vm.costBetExpenses +
        vm.costBetRevenue;
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(PaymentChangeValue(
      calculateCostShuttleCock: vm.calculateCostShuttleCock,
      costBetExpenses: vm.costBetExpenses,
      costBetRevenue: vm.costBetRevenue,
      costCort: vm.costCort,
      costShuttleCock: vm.costShuttleCock,
      costSumary: vm.costSumary,
      countShuttleCock: vm.countShuttleCock,
      gameCount: vm.gameCount,
      payPlayName: vm.payPlayerName,
      payPlayerID: vm.payPlayerID,
      paymentModel: vm.paymentModel,
    ));
  }

  _calCulateCostShuttleCock(List listGame, PaymentViewmodel vm) {
    double twentyFivePersent = 25 / 100;
    double fiftyPersent = 50 / 100;
    double calculateCostShuttleCockTest = 0;
    for (var game in listGame) {
      if (game['results'].toString() == "0") {
        calculateCostShuttleCockTest = calculateCostShuttleCockTest +
            (game['numberShuttleCock'] *
                vm.costShuttleCock *
                twentyFivePersent);
      } else if (game['results'].toString() == "1") {
        if (game['team1ID'].toString().contains(vm.payPlayerID)) {
          calculateCostShuttleCockTest = calculateCostShuttleCockTest +
              (game['numberShuttleCock'] * vm.costShuttleCock * fiftyPersent);
        }
      } else if (game['results'].toString() == "2") {
        if (game['team1ID'].toString().contains(vm.payPlayerID)) {
        } else {
          calculateCostShuttleCockTest = calculateCostShuttleCockTest +
              (game['numberShuttleCock'] * vm.costShuttleCock * fiftyPersent);
        }
      } else if (game['results'].toString() == "3") {
        calculateCostShuttleCockTest = calculateCostShuttleCockTest +
            (game['numberShuttleCock'] *
                vm.costShuttleCock *
                twentyFivePersent);
      }
    }
    double calculateCostShuttleCock;
    if (calculateCostShuttleCockTest < 1) {
      calculateCostShuttleCock = calculateCostShuttleCockTest;
    } else {
      calculateCostShuttleCock = calculateCostShuttleCockTest * -1;
    }
    vm.calculateCostShuttleCock = calculateCostShuttleCock;
  }

  int _calculteShuttleCockCount(List listGame, PaymentViewmodel vm) {
    int _countShuttleCock = 0;
    for (var game in listGame) {
      if (game['numberShuttleCock'] == null) {
        _countShuttleCock = _countShuttleCock + 1;
      } else {
        _countShuttleCock =
            _countShuttleCock + game['numberShuttleCock'] as int;
      }
    }
    vm.countShuttleCock = _countShuttleCock;
    return _countShuttleCock;
  }

  int _calculateGameCount(listGame, PaymentViewmodel vm) {
    vm.gameCount = listGame.length;
    return listGame.length;
  }

  Future<String> _getSettingValue(PaymentViewmodel vm) async {
    SettingRepository settingRepository = SettingRepository();
    Future<dynamic> listSettings = settingRepository.getAll();
    List list = await listSettings;
    String errorMessage = "";
    if (list.length == 0) {
      errorMessage = errorMessage +
          "ยังไม่ได้ใส่ค่าคอดแบด หรือ ค่าลูกแบด จากเมนูตั้งค่า\n";
    } else {
      for (var listSetting in list) {
        vm.costCort = listSetting['costCort'] * -1;
        vm.costShuttleCock = listSetting['costShuttleCock'];
      }
    }
    if (vm.payPlayerID == "") {
      errorMessage = "";
      errorMessage = errorMessage + "ยังไม่ได้เลือกผู้เล่น";
    }
    GameRepository gameRepository = GameRepository();
    List listGame = await gameRepository.getListPaymentByPlayID(vm.payPlayerID);
    if (listGame.length == 0) {
      vm.costCort = 0;
      errorMessage = "";
      errorMessage = errorMessage + "ต้องเพิ่มเกมอย่างน้อย1เกมก่อนคิดเงิน";
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(PaymentChangeValue(
          calculateCostShuttleCock: 0,
          costBetExpenses: 0,
          costBetRevenue: 0,
          costCort: 0,
          costShuttleCock: 0,
          costSumary: 0,
          countShuttleCock: 0,
          gameCount: 0,
          payPlayName: "",
          payPlayerID: "",
          paymentModel: null));
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameScreen()),
      );
    }
    return errorMessage;
  }

  // _sendMessageToLineGroup(PaymentViewmodel vm) async {
  //   try {
  //     String strPayment;
  //     strPayment = "ผู้เล่น " + vm.payPlayerName + "\n";
  //     strPayment = strPayment + "รายละเอียดเกม\n";
  //     strPayment =
  //         strPayment + "ตีทั้งหมด " + vm.gameCount.toString() + " เกม\n";
  //     strPayment =
  //         strPayment + "ใช้ลูกแบด " + vm.countShuttleCock.toString() + " ลูก\n";
  //     strPayment = strPayment + "รายละเอียดการจ่ายเงิน\n";
  //     strPayment = strPayment +
  //         "ค่าคอดแบด " +
  //         (vm.costCort < 0 ? vm.costCort * -1 : vm.costCort).toString() +
  //         " บาท\n";
  //     strPayment = strPayment +
  //         "ค่าลูกแบด " +
  //         (vm.calculateCostShuttleCock < 0
  //                 ? vm.calculateCostShuttleCock * -1
  //                 : vm.calculateCostShuttleCock)
  //             .toString() +
  //         " บาท\n";
  //     strPayment =
  //         strPayment + "ได้จับนอก " + vm.costBetRevenue.toString() + " บาท\n";
  //     strPayment = strPayment +
  //         "เสียจับนอก " +
  //         (vm.costBetExpenses < 0
  //                 ? vm.costBetExpenses * -1
  //                 : vm.costBetExpenses)
  //             .toString() +
  //         " บาท\n";
  //     if (vm.costSumary > 0) {
  //       strPayment =
  //           strPayment + "รวมต้องได้เงิน " + vm.costSumary.toString() + " บาท";
  //     } else {
  //       strPayment = strPayment +
  //           "รวมต้องจ่ายเงิน " +
  //           (vm.costSumary < 0 ? vm.costSumary * -1 : vm.costSumary)
  //               .toString() +
  //           " บาท";
  //     }
  //     var url = Uri.parse('https://api.line.me/v2/bot/message/multicast');
  //     await http.post(url,
  //         body: jsonEncode({
  //           "to": ["U15d6d18845d9f0efca35e6bacf8c48a3"],
  //           "messages": [
  //             {"type": "text", "text": "$strPayment"}
  //           ]
  //         }),
  //         headers: {
  //           'Content-Type': 'application/json',
  //           'Authorization':
  //               'Bearer SY23l7Amcs4Qo3KkgrvEEbJdkFhjEHgz2cSCaWUz+6jj52npxEn0kHwfhfL4HBNGaqQH7zch2WQ2USUDcOKxaRB+P4bGz4DP+sgERwpOZ+kbxVMFHDaZs8MWY9bLTUd+0Joa/eVtY0SA6QmCcaNeRwdB04t89/1O/w1cDnyilFU='
  //         });
  //   } catch (exception) {
  //     print(exception);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: AppBar(
        title: Text("คิดเงิน"),
      ),
      body: StoreConnector<AppState, PaymentViewmodel>(
        converter: (store) => PaymentViewmodel(
            listPlayerModel: store.state.playerState.listPlayerModel,
            paymentModel: store.state.paymentState.paymentModel as PaymentModel,
            gameCount: store.state.paymentState.gameCount as int,
            payPlayerID: store.state.paymentState.payPlayerID as String,
            payPlayerName: store.state.paymentState.payPlayerName as String,
            calculateCostShuttleCock:
                store.state.paymentState.calculateCostShuttleCock as double,
            costShuttleCock: store.state.paymentState.costShuttleCock as int,
            countShuttleCock: store.state.paymentState.countShuttleCock as int,
            costBetExpenses: store.state.paymentState.costBetExpenses as double,
            costCort: store.state.paymentState.costCort as int,
            costSumary: store.state.paymentState.costSumary as double,
            costBetRevenue: store.state.paymentState.costBetRevenue as double),
        builder: (context, vm) {
          return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            child: SingleChildScrollView(
                child: Column(children: [
              Text(
                "ผู้เล่น",
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 20,
                ),
              ),
              DropdownButton<String>(
                value: vm.payPlayerID == "" ? null : vm.payPlayerID,
                hint: Text("เลือกผู้เล่นที่จะคิดเงิน"),
                items: vm.listPlayerModel.map((PlayerModel item) {
                  return DropdownMenuItem<String>(
                    value: item.id.toString(),
                    child: Text(item.name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  final store = StoreProvider.of<AppState>(context);
                  store.dispatch(PaymentChangeValue(
                      payPlayerID: newValue as String,
                      payPlayName: vm.listPlayerModel
                          .firstWhere((item) => item.id.toString() == newValue)
                          .name,
                      costBetExpenses: 0,
                      costBetRevenue: 0));
                },
              ),
              TextButton(
                  onPressed: () async {
                    vm.gameCount = 0;
                    vm.calculateCostShuttleCock = 0;
                    vm.costShuttleCock = 0;
                    vm.countShuttleCock = 0;
                    vm.costBetExpenses = 0;
                    vm.costCort = 0;
                    vm.costSumary = 0;
                    vm.costBetRevenue = 0;

                    String errorMessage = await _getSettingValue(vm);
                    if (errorMessage != "") {
                      ShowAlertBox().showError(context, errorMessage);
                    }
                    _calCulatePayment(vm);
                    //_sendMessageToLineGroup(vm);
                  },
                  child: Text('คิดเงิน', style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pinkAccent))),
              Column(children: [
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
                Text("ตีทั้งหมด " + vm.gameCount.toString() + " เกม ",
                    style: TextStyle(color: Colors.green, fontSize: 17)),
                SizedBox(
                  height: 10,
                ),
                Text("ใช้ลูกแบด " + vm.countShuttleCock.toString() + " ลูก",
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
                        (vm.costCort < 0 ? vm.costCort * -1 : vm.costCort)
                            .toString() +
                        " บาท",
                    style: TextStyle(color: Colors.green, fontSize: 17)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "ค่าลูกแบด " +
                        (vm.calculateCostShuttleCock < 0
                                ? vm.calculateCostShuttleCock * -1
                                : vm.calculateCostShuttleCock)
                            .toString() +
                        " บาท",
                    style: TextStyle(color: Colors.green, fontSize: 17)),
                SizedBox(
                  height: 10,
                ),
                Text("ได้จับนอก " + vm.costBetRevenue.toString() + " บาท",
                    style: TextStyle(color: Colors.green, fontSize: 17)),
                SizedBox(
                  height: 10,
                ),
                Text(
                    "เสียจับนอก " +
                        (vm.costBetExpenses < 0
                                ? vm.costBetExpenses * -1
                                : vm.costBetExpenses)
                            .toString() +
                        " บาท",
                    style: TextStyle(color: Colors.green, fontSize: 17)),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 30,
                ),
                vm.costSumary > 0
                    ? Text(
                        "รวมต้องได้เงิน " + vm.costSumary.toString() + " บาท",
                        style: TextStyle(color: Colors.blue, fontSize: 25))
                    : Text(
                        "รวมต้องจ่ายเงิน " +
                            (vm.costSumary < 0
                                    ? vm.costSumary * -1
                                    : vm.costSumary)
                                .toString() +
                            " บาท",
                        style: TextStyle(color: Colors.blue, fontSize: 25)),
                Divider(
                  height: 20,
                )
              ]),
            ])),
          );
        },
      ),
    );
  }
}
