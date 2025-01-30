import 'package:calculatebadminton/main.dart';
import 'package:calculatebadminton/model/player_model.dart';
import 'package:calculatebadminton/repository/player_repository.dart';
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
        store.dispatch(PlayerCopyWith(listPlayerModel));
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
                  onPressed: () {
                    // String betIDValidate = "";
                    // String betValueValidate = "";
                    // String teamValidate = "";
                    // if (betID == null) {
                    //   betIDValidate = "ยังไม่ได้เลือกผู้จับนอก";
                    // }
                    // if (betValue == null) {
                    //   betValueValidate = "ยังไม่ใส่จำนวนเงิน";
                    // }
                    // if (team1ID == null) {
                    //   teamValidate = "ยังไม่ได้เลือกเกม";
                    // }
                    // if (betIDValidate + betValueValidate + teamValidate != "") {
                    //   List<String> listError = List<String>();
                    //   listError.add(betIDValidate);
                    //   listError.add(betValueValidate);
                    //   listError.add(teamValidate);
                    //   return _showAlertBox(listError);
                    // }

                    // if (mounted) {
                    //   setState(() {
                    //     var betTempModel = BetTempModel();
                    //     betTempModel.betPlayerID = int.parse(betID);
                    //     betTempModel.betPlayerName = betName;
                    //     betTempModel.betValue = int.parse(betValue);
                    //     betTempModel.team1ID = team1ID;
                    //     betTempModel.team1Name = team1Name;
                    //     betTempModel.team2ID = team2ID;
                    //     betTempModel.team2Name = team2Name;
                    //     listBetTempModel.add(betTempModel);
                    //   });
                    // }
                    // // Navigator.of(context).pop(context);
                    // Navigator.pop(context);
                  },
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
                      store.dispatch(PlayerGameAddCopyWith(
                          newValue as String,
                          vm.player2,
                          vm.player3,
                          vm.player4,
                          vm.costShuttlecock));
                    },
                  ),
                  // FindDropdown<PlayerModel>(
                  //   label: "ผู้จับนอก",
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
                  //   dropdownBuilder: (BuildContext context, PlayerModel item) {
                  //     return Container(
                  //       decoration: BoxDecoration(
                  //         border:
                  //             Border.all(color: Theme.of(context).dividerColor),
                  //         borderRadius: BorderRadius.circular(5),
                  //         color: Colors.white,
                  //       ),
                  //       child: (item == null)
                  //           ? ListTile(
                  //               leading: CircleAvatar(
                  //                   backgroundColor: Colors.white,
                  //                   child: Icon(
                  //                     MdiIcons.badminton,
                  //                     color: Colors.black,
                  //                     size: 25,
                  //                   )),
                  //               title: Text("No item selected"))
                  //           : ListTile(
                  //               leading: CircleAvatar(
                  //                   backgroundImage: NetworkImage(item.name)),
                  //               title: Text(item.name),
                  //             ),
                  //     );
                  //   },
                  //   onFind: (String filter) => getListPlayer(filter),
                  //   onChanged: (PlayerModel player) {
                  //     if (mounted) {
                  //       setState(() {
                  //         betID = player.id.toString();
                  //         betName = player.name;
                  //       });
                  //     }
                  //   },
                  // ),
                  SizedBox(
                    height: 30,
                  ),
                  // DropdownSearch<String>(
                  //   dropdownSearchDecoration: InputDecoration(
                  //     hintText: "",
                  //     labelText: "เกม",
                  //     helperText: '',
                  //     contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  //     border: OutlineInputBorder(),
                  //   ),
                  //   mode: Mode.MENU,
                  //   showSelectedItems: false,
                  //   items: ["$team1", "$team2"],
                  //   onChanged: (String team) {
                  //     if (mounted) {
                  //       setState(() {
                  //         if (team == team1) {
                  //           team1ID = "\$" +
                  //               playerTempModel.player1ID.toString() +
                  //               "\$\$" +
                  //               playerTempModel.player2ID.toString() +
                  //               "\$";
                  //           team1Name = team1;
                  //           team2ID = "\$" +
                  //               playerTempModel.player3ID.toString() +
                  //               "\$\$" +
                  //               playerTempModel.player4ID.toString() +
                  //               "\$";
                  //           team2Name = team2;
                  //         } else {
                  //           team1ID = "\$" +
                  //               playerTempModel.player3ID.toString() +
                  //               "\$\$" +
                  //               playerTempModel.player4ID.toString() +
                  //               "\$";
                  //           team1Name = team2;
                  //           team2ID = "\$" +
                  //               playerTempModel.player1ID.toString() +
                  //               "\$\$" +
                  //               playerTempModel.player2ID.toString() +
                  //               "\$";
                  //           team2Name = team1;
                  //         }
                  //       });
                  //     }
                  //   },
                  //   selectedItem: "",
                  // ),
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
                              store.dispatch(PlayerGameAddCopyWith(
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
                              store.dispatch(PlayerGameAddCopyWith(
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
                              store.dispatch(PlayerGameAddCopyWith(
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
                              store.dispatch(PlayerGameAddCopyWith(
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
                                  store.dispatch(PlayerGameAddCopyWith(
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
                                  store.dispatch(PlayerGameAddCopyWith(
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
                children: [
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: listBetTempModel.length,
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding:
                  //             EdgeInsets.only(top: 8.0, left: 0.0, right: 0.0),
                  //         child: Card(
                  //           elevation: 8.0,
                  //           child: ListTile(
                  //             title: Row(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: <Widget>[
                  //                 Row(
                  //                   children: [
                  //                     SizedBox(
                  //                       height: 20,
                  //                     ),
                  //                     Text(listBetTempModel[index]
                  //                             .betPlayerName +
                  //                         " จับนอกคู่\n" +
                  //                         listBetTempModel[index].team1Name +
                  //                         "\n"
                  //                             "จำนวน " +
                  //                         listBetTempModel[index]
                  //                             .betValue
                  //                             .toString() +
                  //                         " บาท"),
                  //                     SizedBox(
                  //                       height: 20,
                  //                     )
                  //                   ],
                  //                 ),
                  //                 IconButton(
                  //                     onPressed: () {
                  //                       if (mounted) {
                  //                         setState(() {
                  //                           listBetTempModel.remove(
                  //                               listBetTempModel[index]);
                  //                         });
                  //                       }
                  //                     },
                  //                     icon: Icon(
                  //                       Icons.delete,
                  //                       color: Colors.red,
                  //                     ))
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }),
                ],
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
                onPressed: () async {
                  // String typeCostShuttlecockValidate = "";
                  // String countPlayerValidate = "";
                  // if (typeCostShuttlecock == 0) {
                  //   typeCostShuttlecockValidate = "ยังไม่เลือกค่าลูกแบด";
                  // }
                  // if (countPlayer == 0) {
                  //   countPlayerValidate = "ยังไม่เลือกผู้เล่น";
                  // } else {
                  //   if (countPlayer > 4) {
                  //     countPlayerValidate = "เลือกผู้เล่นมากกว่า 4 คน";
                  //   }
                  //   if (countPlayer < 4) {
                  //     countPlayerValidate = "เลือกผู้เล่นน้อยกว่า 4 คน";
                  //   }
                  // }
                  // if (typeCostShuttlecockValidate + countPlayerValidate != "") {
                  //   List<String> listError = [];
                  //   listError.add(typeCostShuttlecockValidate);
                  //   listError.add(countPlayerValidate);
                  //   return _showAlertBox(listError);
                  // }
                  // var game = GameModel();
                  // game.team1ID = "\$" +
                  //     playerTempModel.player1ID.toString() +
                  //     "\$" +
                  //     "\$" +
                  //     playerTempModel.player2ID.toString() +
                  //     "\$";
                  // game.team2ID = "\$" +
                  //     playerTempModel.player3ID.toString() +
                  //     "\$" +
                  //     "\$" +
                  //     playerTempModel.player4ID.toString() +
                  //     "\$";
                  // game.team1Name = playerTempModel.player1Name +
                  //     " คู่กับ " +
                  //     playerTempModel.player2Name;
                  // game.team2Name = playerTempModel.player3Name +
                  //     " คู่กับ " +
                  //     playerTempModel.player4Name;
                  // game.typeCostShuttlecock = typeCostShuttlecock.toString();
                  // game.numberShuttleCock = 1;
                  // game.results = "0";
                  // var gameRepository = GameRepository();
                  // int gameID = await gameRepository.add(game);
                  // var betDetailRepository = BetDetailRepository();
                  // if (listBetTempModel.length > 0) {
                  //   for (int i = 0; i < listBetTempModel.length; i++) {
                  //     var betDetail = BetDetailModel();
                  //     betDetail.betPlayerID = listBetTempModel[i].betPlayerID;
                  //     betDetail.betPlayerName =
                  //         listBetTempModel[i].betPlayerName;
                  //     betDetail.betValue = listBetTempModel[i].betValue;
                  //     betDetail.betTeamID = listBetTempModel[i].team1ID;
                  //     betDetail.betTeamName = listBetTempModel[i].team1Name;
                  //     betDetail.gameID = gameID;
                  //     await betDetailRepository.add(betDetail);
                  //   }
                  //}

                  //Navigator.of(context).pop(context);
                  //Navigator.pop(context, "false");

                  //Navigator.push(context,
                  // MaterialPageRoute(builder: (context) => GameScreen()));
                  //   .then((value) {
                  // setState(() {});
                  //});

                  // Navigator.pop(context,
                  //     MaterialPageRoute(builder: (context) => GameScreen()));
                  // setState(() {
                  //   Navigator.pop(context,
                  //       MaterialPageRoute(builder: (context) => GameScreen()));
                  // });
                  // Navigator.of(context).pop(
                  //     MaterialPageRoute(builder: (context) => GameScreen())
                  //         .setState(() {}));
                },
                child: Text('เพิ่มเกม'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
