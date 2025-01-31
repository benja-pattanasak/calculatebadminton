import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/model/player_model.dart';
import 'package:calculatebadminton/repository/player_repository.dart';
import 'package:calculatebadminton/state/state.dart';
import 'package:calculatebadminton/viewmodel/gameaddscreen_viewmodel.dart';
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

  _showFormBet(
      BuildContext context, GameAddScreenViewmodel vm, Store<AppState> store) {
    return showDialog(
        useSafeArea: false,
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
                      backgroundColor: MaterialStateProperty.all(Colors.red))),
              TextButton(
                  onPressed: () {},
                  child: Text('บันทึก'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)))
            ],
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ผู้จับนอก",
                    style: TextStyle(fontSize: 17),
                  ),
                  DropdownButton<String>(
                    value: vm.player1 == ""
                        ? vm.listPlayerModel[0].name
                        : vm.player1,
                    hint: Text("ผู้จับนอก"),
                    items: vm.listPlayerModel.map((PlayerModel item) {
                      return DropdownMenuItem<String>(
                        value: item.name,
                        child: Text(item.name),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      store.dispatch(PlayerGameAddChangeValue(
                          newValue as String,
                          vm.player2,
                          vm.player3,
                          vm.player4,
                          vm.costShuttlecock));
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    onChanged: (String value) {
                      // betValue = value;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(label: Text('จำนวนเงิน')),
                  ),
                ],
              ),
            ),
          );
        });
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
                    player1: store.state.playerGameAddState.player1,
                    player2: store.state.playerGameAddState.player2,
                    player3: store.state.playerGameAddState.player3,
                    player4: store.state.playerGameAddState.player4,
                    costShuttlecock:
                        store.state.playerGameAddState.costShuttlecock),
                builder: (context, vm) {
                  if (vm.listPlayerModel.length > 0) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ผู้เล่นที่ 1",
                            style: TextStyle(fontSize: 17),
                          ),
                          DropdownButton<String>(
                            value: vm.player1 == ""
                                ? vm.listPlayerModel[0].name
                                : vm.player1,
                            hint: Text("เลือกประเทศ"),
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.name,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  newValue as String,
                                  vm.player2,
                                  vm.player3,
                                  vm.player4,
                                  vm.costShuttlecock));
                            },
                          ),
                          Text(
                            "ผู้เล่นที่ 2",
                            style: TextStyle(fontSize: 17),
                          ),
                          DropdownButton<String>(
                            value: vm.player2 == ""
                                ? vm.listPlayerModel[0].name
                                : vm.player2,
                            hint: Text("เลือกประเทศ"),
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.name,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  vm.player1,
                                  newValue as String,
                                  vm.player3,
                                  vm.player4,
                                  vm.costShuttlecock));
                            },
                          ),
                          Text(
                            "ผู้เล่นที่ 3",
                            style: TextStyle(fontSize: 17),
                          ),
                          DropdownButton<String>(
                            value: vm.player3 == ""
                                ? vm.listPlayerModel[0].name
                                : vm.player3,
                            hint: Text("เลือกประเทศ"), // ข้อความเริ่มต้น
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.name,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  vm.player1,
                                  vm.player2,
                                  newValue as String,
                                  vm.player4,
                                  vm.costShuttlecock));
                            },
                          ),
                          Text(
                            "ผู้เล่นที่ 4",
                            style: TextStyle(fontSize: 17),
                          ),
                          DropdownButton<String>(
                            value: vm.player4 == ""
                                ? vm.listPlayerModel[0].name
                                : vm.player4,
                            hint: Text("เลือกประเทศ"), // ข้อความเริ่มต้น
                            items: vm.listPlayerModel.map((PlayerModel item) {
                              return DropdownMenuItem<String>(
                                value: item.name,
                                child: Text(item.name),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              store.dispatch(PlayerGameAddChangeValue(
                                  vm.player1,
                                  vm.player2,
                                  vm.player3,
                                  newValue as String,
                                  vm.costShuttlecock));
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                vm.player1 + " คู่กับ " + vm.player2,
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
                                vm.player3 + " คู่กับ " + vm.player4,
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
                                      vm.player1,
                                      vm.player2,
                                      vm.player3,
                                      vm.player4,
                                      val as int));
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
                                      vm.player1,
                                      vm.player2,
                                      vm.player3,
                                      vm.player4,
                                      val as int));
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
                                  _showFormBet(context, vm, store);
                                },
                                child: Text('เพิ่มจับนอก'),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
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
