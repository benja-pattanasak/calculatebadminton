import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/model/betdetail_model.dart';
import 'package:calculatebadminton/model/player_model.dart';
import 'package:calculatebadminton/repository/betdetail_repository.dart';
import 'package:calculatebadminton/repository/player_repository.dart';
import 'package:calculatebadminton/state/state.dart';
import 'package:calculatebadminton/viewmodel/gameaddscreen_viewmodel.dart';
import 'package:calculatebadminton/widgets/showalertbox.dart';
import 'package:calculatebadminton/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class GameAddScreen extends StatefulWidget {
  const GameAddScreen({super.key});

  @override
  State<GameAddScreen> createState() => _GameAddScreenState();
}

class _GameAddScreenState extends State<GameAddScreen> {
  @override
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

  _showFormBet() {
    final store = StoreProvider.of<AppState>(context, listen: false);
    return showDialog(
        useSafeArea: false,
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return StoreConnector<AppState, GameAddScreenViewmodel>(
            converter: (store) => GameAddScreenViewmodel(
                listPlayerModel: store.state.playerState.listPlayerModel,
                playerName1: store.state.playerGameAddState.playerName1,
                playerName2: store.state.playerGameAddState.playerName2,
                playerName3: store.state.playerGameAddState.playerName3,
                playerName4: store.state.playerGameAddState.playerName4,
                playerID1: store.state.playerGameAddState.playerID1,
                playerID2: store.state.playerGameAddState.playerID2,
                playerID3: store.state.playerGameAddState.playerID3,
                playerID4: store.state.playerGameAddState.playerID4,
                betID: store.state.playerGameAddState.betID,
                betName: store.state.playerGameAddState.betName,
                costShuttlecock: store.state.playerGameAddState.costShuttlecock,
                betTeam1ID: store.state.playerGameAddState.betTeam1ID,
                betTeam1Name: store.state.playerGameAddState.betTeam1Name,
                betTeam2ID: store.state.playerGameAddState.betTeam2ID,
                betTeam2Name: store.state.playerGameAddState.betTeam2Name,
                betTeamName: store.state.playerGameAddState.betTeamName,
                betTeamID: store.state.playerGameAddState.betTeamID,
                betAmount: store.state.playerGameAddState.betAmount,
                listBetDetailModel:
                    store.state.betDetailState.listBetDetailModel),
            builder: (context, vm) {
              return AlertDialog(
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('ยกเลิก'),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red))),
                  TextButton(
                      onPressed: () async {
                        if (vm.betID == "") {
                          ShowAlertBox()
                              .showError(context, "กรุณาเลือกผู้จับนอก");
                          return;
                        }
                        if (vm.betTeamID == "") {
                          ShowAlertBox().showError(context, "กรุณาเลือกทีม");
                          return;
                        }
                        if (vm.betAmount == 0) {
                          ShowAlertBox()
                              .showError(context, "กรุณาใส่จำนวนเงิน");
                          return;
                        }
                        BetDetailRepository betDetailRepository =
                            BetDetailRepository();
                        BetDetailModel betDetailModel = BetDetailModel();
                        List<Map> maxIdMap =
                            await betDetailRepository.getMaxId();
                        maxIdMap.forEach((betdetail) {
                          betDetailModel.id = betdetail['id'] == null
                              ? 1
                              : (betdetail['id'] as int) + 1;
                        });
                        betDetailModel.betPlayerID = int.parse(vm.betID);
                        betDetailModel.betPlayerName = vm.betName;
                        betDetailModel.betTeamID = vm.betTeamID;
                        betDetailModel.betTeamName = vm.betTeamName;
                        betDetailModel.betValue = vm.betAmount;
                        betDetailModel.gameID = 0;
                        vm.listBetDetailModel.add(betDetailModel);
                        store.dispatch(BetDetailChangeValue(
                            listBetDetailModel: vm.listBetDetailModel));
                        Navigator.pop(context);
                        Snackbar.show(context, "เพิ่มจับนอกเรียบร้อย");
                      },
                      child: Text('บันทึก'),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)))
                ],
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "ผู้จับนอก",
                        style:
                            TextStyle(fontSize: 17, color: Colors.pinkAccent),
                      ),
                      DropdownButton<String>(
                        value: vm.betID == "" ? null : vm.betID.toString(),
                        hint: Text("เลือกผู้จับนอก"),
                        items: vm.listPlayerModel.map((PlayerModel item) {
                          return DropdownMenuItem<String>(
                            value: item.id.toString(),
                            child: Text(item.name),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          store.dispatch(PlayerGameAddChangeValue(
                              betID: newValue as String,
                              betName: vm.listPlayerModel
                                  .firstWhere(
                                      (item) => item.id.toString() == newValue)
                                  .name));
                        },
                      ),
                      Text(
                        "ทีม",
                        style:
                            TextStyle(fontSize: 17, color: Colors.pinkAccent),
                      ),
                      DropdownButton<String>(
                        value: vm.betTeamID == "" ? null : vm.betTeamID,
                        hint: Text("เลือกทีม"),
                        items: [
                          DropdownMenuItem(
                            value: vm.betTeam1ID,
                            child: Text(vm.betTeam1Name),
                          ),
                          DropdownMenuItem(
                            value: vm.betTeam2ID,
                            child: Text(vm.betTeam2Name),
                          ),
                        ],
                        onChanged: (String? newValue) {
                          store.dispatch(PlayerGameAddChangeValue(
                              betTeamID: newValue as String,
                              betTeamName: newValue == vm.betTeam1ID
                                  ? vm.betTeam1Name
                                  : vm.betTeam2Name));
                        },
                      ),
                      Text(
                        "จำนวนเงิน",
                        style:
                            TextStyle(fontSize: 17, color: Colors.pinkAccent),
                      ),
                      TextField(
                        onChanged: (String value) {
                          store.dispatch(PlayerGameAddChangeValue(
                            betAmount: int.parse(value),
                          ));
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }

  _SetTeam(Store<AppState> store, PlayerGameAddState vm) {
    if (vm.playerID1 != "" &&
        vm.playerID2 != "" &&
        vm.playerID3 != "" &&
        vm.playerID4 != "") {
      store.dispatch(PlayerGameAddChangeValue(
          betTeam1ID: vm.playerID1 + vm.playerID2,
          betTeam2ID: vm.playerID3 + vm.playerID4,
          betTeam1Name: vm.playerName1 + " คู่กับ " + vm.playerName2,
          betTeam2Name: vm.playerName3 + " คู่กับ " + vm.playerName4));
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          title: Text("เพิ่มเกม", style: TextStyle(color: Colors.white))),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: EdgeInsets.all(4),
            children: <Widget>[
              StoreConnector<AppState, GameAddScreenViewmodel>(
                converter: (store) => GameAddScreenViewmodel(
                    listPlayerModel: store.state.playerState.listPlayerModel,
                    playerName1: store.state.playerGameAddState.playerName1,
                    playerName2: store.state.playerGameAddState.playerName2,
                    playerName3: store.state.playerGameAddState.playerName3,
                    playerName4: store.state.playerGameAddState.playerName4,
                    playerID1: store.state.playerGameAddState.playerID1,
                    playerID2: store.state.playerGameAddState.playerID2,
                    playerID3: store.state.playerGameAddState.playerID3,
                    playerID4: store.state.playerGameAddState.playerID4,
                    betID: store.state.playerGameAddState.betID,
                    betName: store.state.playerGameAddState.betName,
                    costShuttlecock:
                        store.state.playerGameAddState.costShuttlecock,
                    betTeam1ID: store.state.playerGameAddState.betTeam1ID,
                    betTeam1Name: store.state.playerGameAddState.betTeam1Name,
                    betTeam2ID: store.state.playerGameAddState.betTeam2ID,
                    betTeam2Name: store.state.playerGameAddState.betTeam2Name,
                    betTeamID: store.state.playerGameAddState.betTeamID,
                    betTeamName: store.state.playerGameAddState.betTeamName,
                    betAmount: store.state.playerGameAddState.betAmount,
                    listBetDetailModel:
                        store.state.betDetailState.listBetDetailModel),
                builder: (context, vm) {
                  if (vm.listPlayerModel.length > 0) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ผู้เล่นที่ 1",
                            style: TextStyle(
                                fontSize: 17, color: Colors.pinkAccent),
                          ),
                          DropdownButton<String>(
                            value: vm.playerID1 == ""
                                ? null
                                : vm.playerID1.toString(),
                            hint: Text("เลือกผู้เล่นที่ 1"),
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  playerID1: newValue as String,
                                  playerName1: vm.listPlayerModel
                                      .firstWhere((item) =>
                                          item.id.toString() == newValue)
                                      .name));
                              _SetTeam(store, store.state.playerGameAddState);
                            },
                          ),
                          Text(
                            "ผู้เล่นที่ 2",
                            style: TextStyle(
                                fontSize: 17, color: Colors.pinkAccent),
                          ),
                          DropdownButton<String>(
                            value: vm.playerID2 == ""
                                ? null
                                : vm.playerID2.toString(),
                            hint: Text("เลือกผู้เล่นที่ 2"),
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  playerID2: newValue as String,
                                  playerName2: vm.listPlayerModel
                                      .firstWhere((item) =>
                                          item.id.toString() == newValue)
                                      .name));
                              _SetTeam(store, store.state.playerGameAddState);
                            },
                          ),
                          Text(
                            "ผู้เล่นที่ 3",
                            style: TextStyle(
                                fontSize: 17, color: Colors.pinkAccent),
                          ),
                          DropdownButton<String>(
                            value: vm.playerID3 == ""
                                ? null
                                : vm.playerID3.toString(),
                            hint: Text("เลือกผู้เล่นที่ 3"), // ข้อความเริ่มต้น
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  playerID3: newValue as String,
                                  playerName3: vm.listPlayerModel
                                      .firstWhere((item) =>
                                          item.id.toString() == newValue)
                                      .name));
                              _SetTeam(store, store.state.playerGameAddState);
                            },
                          ),
                          Text(
                            "ผู้เล่นที่ 4",
                            style: TextStyle(
                                fontSize: 17, color: Colors.pinkAccent),
                          ),
                          DropdownButton<String>(
                            value: vm.playerID4 == ""
                                ? null
                                : vm.playerID4.toString(),
                            hint: Text("เลือกผู้เล่นที่ 4"), // ข้อความเริ่มต้น
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.id.toString(),
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  playerID4: newValue as String,
                                  playerName4: vm.listPlayerModel
                                      .firstWhere((item) =>
                                          item.id.toString() == newValue)
                                      .name));
                              _SetTeam(store, store.state.playerGameAddState);
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                vm.betTeam1Name == "" ? "" : vm.betTeam1Name,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.pinkAccent),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "พบกับ",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                vm.betTeam2Name == "" ? "" : vm.betTeam2Name,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.pinkAccent),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Divider(
                            height: 20,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "ค่าลูกแบด",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.pinkAccent),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            children: <Widget>[
                              RadioListTile(
                                value: 1,
                                groupValue: vm.costShuttlecock,
                                title: Text("แพ้จ่าย"),
                                onChanged: (val) {
                                  store.dispatch(PlayerGameAddChangeValue(
                                      costShuttlecock: val as int));
                                },
                                activeColor: Colors.black,
                                selected: false,
                              ),
                              RadioListTile(
                                value: 2,
                                groupValue: vm.costShuttlecock,
                                title: Text("หาร"),
                                onChanged: (val) {
                                  store.dispatch(PlayerGameAddChangeValue(
                                      costShuttlecock: val as int));
                                },
                                activeColor: Colors.black,
                                selected: true,
                              )
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "จับนอก",
                                style: TextStyle(
                                    fontSize: 17, color: Colors.pinkAccent),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.pinkAccent),
                                onPressed: () {
                                  if (vm.playerID1 == "") {
                                    ShowAlertBox().showError(
                                        context, "กรุณาเลือกผู้เล่นที่ 1");
                                    return;
                                  }
                                  if (vm.playerID2 == "") {
                                    ShowAlertBox().showError(
                                        context, "กรุณาเลือกผู้เล่นที่ 2");
                                    return;
                                  }
                                  if (vm.playerID3 == "") {
                                    ShowAlertBox().showError(
                                        context, "กรุณาเลือกผู้เล่นที่ 3");
                                    return;
                                  }
                                  if (vm.playerID4 == "") {
                                    ShowAlertBox().showError(
                                        context, "กรุณาเลือกผู้เล่นที่ 4");
                                    return;
                                  }
                                  _showFormBet();
                                },
                                child: Text('เพิ่มจับนอก'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: vm.listBetDetailModel.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          top: 8.0, left: 0.0, right: 0.0),
                                      child: Card(
                                        elevation: 8.0,
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Text(vm
                                                          .listBetDetailModel[
                                                              index]
                                                          .betPlayerName +
                                                      " จับนอกคู่\n" +
                                                      vm
                                                          .listBetDetailModel[
                                                              index]
                                                          .betTeamName +
                                                      "\n"
                                                          "จำนวน " +
                                                      vm
                                                          .listBetDetailModel[
                                                              index]
                                                          .betValue
                                                          .toString() +
                                                      " บาท"),
                                                  SizedBox(
                                                    height: 20,
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    vm.listBetDetailModel
                                                        .removeAt(index);
                                                    store.dispatch(
                                                        BetDetailChangeValue(
                                                            listBetDetailModel:
                                                                vm.listBetDetailModel));
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ]);
                  } else {
                    return Text("ยังไม่ได้เพิ่มผู้เล่น");
                  }
                },
              ),
              Column(
                children: [],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () async {},
                child: Text('เพิ่มเกม'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
