import 'package:calculatebadminton/model/betdetail_model.dart';
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
  String betName;
  String betID;
  int costShuttlecock;
  List<PlayerModel> listPlayerModel = [];
  String betTeam1ID;
  String betTeam1Name;
  String betTeam2ID;
  String betTeam2Name;
  String betTeamID;
  String betTeamName;
  int betAmount;
  List<BetDetailModel> listBetDetailModel;
  GameAddScreenViewmodel(
      {required this.playerName1,
      required this.playerName2,
      required this.playerName3,
      required this.playerName4,
      required this.playerID1,
      required this.playerID2,
      required this.playerID3,
      required this.playerID4,
      required this.betID,
      required this.betName,
      required this.listPlayerModel,
      required this.costShuttlecock,
      required this.betTeam1ID,
      required this.betTeam1Name,
      required this.betTeam2ID,
      required this.betTeam2Name,
      required this.betTeamID,
      required this.betTeamName,
      required this.betAmount,
      required this.listBetDetailModel}) {}
}
