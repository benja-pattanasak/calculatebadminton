import 'package:calculatebadminton/model/betdetail_model.dart';
import 'package:calculatebadminton/model/game_model.dart';
import 'package:calculatebadminton/model/payment_model.dart';
import 'package:calculatebadminton/model/player_model.dart';

class PaymentChangeValue {
  PaymentModel? paymentModel;
  int? gameCount;
  String? payPlayerID;
  String? payPlayName;
  int? countShuttleCock;
  int? costShuttleCock;
  double? calculateCostShuttleCock;
  double? costBetExpenses;
  int? costCort;
  double? costSumary;
  double? costBetRevenue;
  PaymentChangeValue(
      {this.paymentModel,
      this.gameCount,
      this.payPlayerID,
      this.payPlayName,
      this.countShuttleCock,
      this.costShuttleCock,
      this.calculateCostShuttleCock,
      this.costBetExpenses,
      this.costCort,
      this.costSumary,
      this.costBetRevenue});
}

class GameChangeValue {
  List<GameModel>? listGameModel;
  GameChangeValue({this.listGameModel});
}

class BetDetailChangeValue {
  List<BetDetailModel>? listBetDetailModel;
  BetDetailChangeValue({this.listBetDetailModel});
}

class UpdateUserAction {
  final String newName;
  UpdateUserAction(this.newName);
}

class PlayerChangeValue {
  final List<PlayerModel> listPlayerModel;
  PlayerChangeValue(this.listPlayerModel);
}

class PlayerGameAddChangeValue {
  final String? playerName1;
  final String? playerName2;
  final String? playerName3;
  final String? playerName4;
  final String? playerID1;
  final String? playerID2;
  final String? playerID3;
  final String? playerID4;
  final String? betID;
  final String? betName;
  final int? costShuttlecock;
  final String? betTeam1ID;
  final String? betTeam1Name;
  final String? betTeam2ID;
  final String? betTeam2Name;
  final String? betTeamID;
  final String? betTeamName;
  final int? betAmount;
  PlayerGameAddChangeValue(
      {this.playerName1,
      this.playerName2,
      this.playerName3,
      this.playerName4,
      this.playerID1,
      this.playerID2,
      this.playerID3,
      this.playerID4,
      this.betID,
      this.betName,
      this.costShuttlecock,
      this.betTeam1ID,
      this.betTeam1Name,
      this.betTeam2ID,
      this.betTeam2Name,
      this.betTeamID,
      this.betTeamName,
      this.betAmount});
}

class PlayerGameAddClearValue {}
