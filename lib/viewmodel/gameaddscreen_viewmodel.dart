import 'package:calculatebadminton/model/player_model.dart';

class GameAddScreenViewmodel {
  String player1;
  String player2;
  String player3;
  String player4;
  int costShuttlecock;
  List<PlayerModel> listPlayerModel = [];
  GameAddScreenViewmodel(
      {required this.player1,
      required this.player2,
      required this.player3,
      required this.player4,
      required this.listPlayerModel,
      required this.costShuttlecock}) {}
}
