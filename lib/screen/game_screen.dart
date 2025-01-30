import 'package:calculatebadminton/screen/game_add_screen.dart';
import 'package:calculatebadminton/widgets/left_navigation.dart';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftNavigation(),
      appBar: AppBar(
        title: Text('รายการเกม', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          // ListView.builder(
          //     physics: const NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     itemCount: listGame == null ? 0 : listGame.length,
          //     itemBuilder: (context, index) {
          //       return Row(
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         children: _showListBetDetail(
          //             listGame[index].gameID, listGame[index], index, context),
          //       );
          //     }),
        ],
      )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GameAddScreen()),
          );
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
