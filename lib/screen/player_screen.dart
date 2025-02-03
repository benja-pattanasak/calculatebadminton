import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/model/player_model.dart';
import 'package:calculatebadminton/repository/player_repository.dart';
import 'package:calculatebadminton/state/state.dart';
import 'package:calculatebadminton/viewmodel/playerscreen_viewmodel.dart';
import 'package:calculatebadminton/widgets/showalertbox.dart';
import 'package:calculatebadminton/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  var _playerNameController = TextEditingController();
  var _editPlayerNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<Map<String, Object?>> data = await PlayerRepository().getAll();
      List<PlayerModel> listPlayerModel =
          data.map((map) => PlayerModel.fromMap(map)).toList();
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(PlayerChangeValue(listPlayerModel));
    });
  }

  _editFormDialog(BuildContext context, int playID) {
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
                      backgroundColor: MaterialStateProperty.all(Colors.red))),
              TextButton(
                  onPressed: () async {
                    if (_editPlayerNameController.text == "") {
                      ShowAlertBox showAlertBox = ShowAlertBox();
                      return showAlertBox.showError(
                          context, "1.ยังไม่ได้ใส่ชื่อผู้เล่น");
                    }
                    PlayerModel playerModel = PlayerModel(
                      id: 0,
                      name: "",
                    );
                    playerModel.id = playID;
                    playerModel.name = _editPlayerNameController.text;
                    await PlayerRepository().edit(playerModel);

                    await _getListPlayer(context);

                    Navigator.pop(context);
                    Snackbar.show(context, "แก้ไขผู้เล่นเรียบร้อย");
                  },
                  child: Text('บันทึก'),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      backgroundColor: MaterialStateProperty.all(Colors.blue)))
            ],
            title: Text('แก้ไขผู้เล่น',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                )),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: _editPlayerNameController,
                    decoration: InputDecoration(
                        hintText: 'ชื่อผู้เล่น', labelText: 'ชื่อผู้เล่น'),
                  )
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, playerID) {
    return showDialog(
        context: context,
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
                    await PlayerRepository().delete(playerID);
                    await _getListPlayer(context);
                    Navigator.pop(context);
                    Snackbar.show(context, "ลบผู้เล่นเรียบร้อย");
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

  _getListPlayer(context) async {
    List<Map<String, Object?>> data = await PlayerRepository().getAll();
    List<PlayerModel> listPlayerModel =
        data.map((map) => PlayerModel.fromMap(map)).toList();
    final store = StoreProvider.of<AppState>(context);
    store.dispatch(PlayerChangeValue(listPlayerModel));
  }

  _showDialogAddPlayer() async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Padding(
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    child: Column(
                      children: [
                        Text(
                          "เพิ่มผู้เล่น",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 20,
                          ),
                        ),
                        Divider(
                          height: 20,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: _playerNameController,
                          decoration:
                              InputDecoration(label: Text('ชื่อผู้เล่น')),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('ยกเลิก'),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red))),
                            TextButton(
                              style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blue),
                              onPressed: () async {
                                PlayerRepository playerRepository =
                                    PlayerRepository();
                                PlayerModel playerModel =
                                    PlayerModel(id: 0, name: "");
                                List<Map> maxIdMap =
                                    await playerRepository.getMaxId();
                                maxIdMap.forEach((player) {
                                  playerModel.id = player['id'] == null
                                      ? 1
                                      : (player['id'] as int) + 1;
                                });

                                playerModel.id = playerModel.id;
                                playerModel.name = _playerNameController.text;
                                if (playerModel.name == "") {
                                  return ShowAlertBox().showError(
                                      context, "กรุณาใส่ชื่อผู้เล่น");
                                }
                                await playerRepository.add(playerModel);
                                Navigator.pop(context);

                                await _getListPlayer(context);
                                Snackbar.show(context, "เพิ่มผู้เล่นเรียบร้อย");
                              },
                              child: Text('บันทึก'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var contextBase = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('ผู้เล่น', style: TextStyle(color: Colors.white)),
      ),
      body: StoreConnector<AppState, PlayerViewmodel>(
        converter: (store) => PlayerViewmodel(
            listPlayerModel: store.state.playerState.listPlayerModel),
        builder: (context, vm) {
          if (vm.listPlayerModel.length > 0) {
            return ListView.builder(
                itemCount: vm.listPlayerModel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                    child: Card(
                      elevation: 8.0,
                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _editPlayerNameController.text =
                                vm.listPlayerModel[index].name;
                            _editFormDialog(
                                contextBase, vm.listPlayerModel[index].id);
                          },
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(vm.listPlayerModel[index].name),
                            IconButton(
                                onPressed: () {
                                  _deleteFormDialog(contextBase,
                                      vm.listPlayerModel[index].id);
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
                });
          } else {
            return Text(
              "",
              style: TextStyle(fontSize: 40),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _playerNameController.text = "";
          _showDialogAddPlayer();
        },
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text('เพิ่มผู้เล่น', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }
}
