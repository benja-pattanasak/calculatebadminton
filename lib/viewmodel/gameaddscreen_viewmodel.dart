import 'package:calculatebadminton/model/player_model.dart';

class GameAddScreenViewmodel {
  String playerName1;
  String playerName2;
  String playerName3;
  String playerName4;
  String playerID1;
  String playerID2;
  String playerID3;
  String playerID4;
  int costShuttlecock;
  List<PlayerModel> listPlayerModel = [];
  GameAddScreenViewmodel(
      {required this.playerName1,
      required this.playerName2,
      required this.playerName3,
      required this.playerName4,
      required this.playerID1,
      required this.playerID2,
      required this.playerID3,
      required this.playerID4,
      required this.listPlayerModel,
      required this.costShuttlecock}) {}
}
