import 'package:calculatebadminton/model/betdetail_model.dart';
import 'package:calculatebadminton/model/game_model.dart';
import 'package:calculatebadminton/model/payment_model.dart';
import 'package:calculatebadminton/model/player_model.dart';

class PaymentState {
  PaymentModel? paymentModel;
  int? gameCount;
  String? payPlayerID;
  String? payPlayerName;
  int? countShuttleCock;
  int? costShuttleCock;
  double? calculateCostShuttleCock;
  double? costBetExpenses;
  int? costCort;
  double? costSumary;
  double? costBetRevenue;
  PaymentState(
      {this.paymentModel,
      this.gameCount,
      this.payPlayerID,
      this.payPlayerName,
      this.countShuttleCock,
      this.costShuttleCock,
      this.calculateCostShuttleCock,
      this.costBetExpenses,
      this.costCort,
      this.costSumary,
      this.costBetRevenue});
  PaymentState setValue(
      {PaymentModel? paymentModel,
      int? gameCount,
      String? payPlayerID,
      String? payPlayerName,
      int? countShuttleCock,
      int? costShuttleCock,
      double? calculateCostShuttleCock,
      double? costBetExpenses,
      int? costCort,
      double? costSumary,
      double? costBetRevenue}) {
    return PaymentState(
      paymentModel: paymentModel ?? this.paymentModel,
      gameCount: gameCount ?? this.gameCount,
      payPlayerID: payPlayerID ?? this.payPlayerID,
      payPlayerName: payPlayerName ?? this.payPlayerName,
      countShuttleCock: countShuttleCock ?? this.countShuttleCock,
      costShuttleCock: costShuttleCock ?? this.costShuttleCock,
      calculateCostShuttleCock:
          calculateCostShuttleCock ?? this.calculateCostShuttleCock,
      costBetExpenses: costBetExpenses ?? this.costBetExpenses,
      costCort: costCort ?? this.costCort,
      costSumary: costSumary ?? this.costSumary,
      costBetRevenue: costBetRevenue ?? this.costBetRevenue,
    );
  }
}

class GameState {
  List<GameModel> listGameModel;
  GameState({this.listGameModel = const []});
  GameState setValue({List<GameModel>? listGameModel}) {
    return GameState(listGameModel: listGameModel ?? this.listGameModel);
  }
}

class BetDetailState {
  List<BetDetailModel> listBetDetailModel;
  BetDetailState({this.listBetDetailModel = const []});
  BetDetailState setValue({List<BetDetailModel>? listBetDetailModel}) {
    return BetDetailState(
        listBetDetailModel: listBetDetailModel ?? this.listBetDetailModel);
  }
}

class PlayerState {
  final List<PlayerModel> listPlayerModel;
  PlayerState({this.listPlayerModel = const []});
  PlayerState copyWith({List<PlayerModel>? listPlayerModel}) {
    return PlayerState(
        listPlayerModel: listPlayerModel ?? this.listPlayerModel);
  }
}

class PlayerGameAddState {
  final String playerName1;
  final String playerName2;
  final String playerName3;
  final String playerName4;
  final String playerID1;
  final String playerID2;
  final String playerID3;
  final String playerID4;
  final String betID;
  final String betName;
  final int costShuttlecock;
  final String betTeam1ID;
  final String betTeam1Name;
  final String betTeam2ID;
  final String betTeam2Name;
  final String betTeamID;
  final String betTeamName;
  final int betAmount;
  PlayerGameAddState({
    this.playerName1 = "",
    this.playerName2 = "",
    this.playerName3 = "",
    this.playerName4 = "",
    this.playerID1 = "",
    this.playerID2 = "",
    this.playerID3 = "",
    this.playerID4 = "",
    this.betID = "",
    this.betName = "",
    this.costShuttlecock = 0,
    this.betTeam1ID = "",
    this.betTeam1Name = "",
    this.betTeam2ID = "",
    this.betTeam2Name = "",
    this.betTeamID = "",
    this.betTeamName = "",
    this.betAmount = 0,
  });

  PlayerGameAddState SetValue(
      {String? playerName1,
      String? playerName2,
      String? playerName3,
      String? playerName4,
      String? playerID1,
      String? playerID2,
      String? playerID3,
      String? playerID4,
      String? betID,
      String? betName,
      int? costShuttlecock,
      String? betTeam1ID,
      String? betTeam1Name,
      String? betTeam2ID,
      String? betTeam2Name,
      String? betTeamID,
      String? betTeamName,
      int? betAmount}) {
    return PlayerGameAddState(
      playerName1: playerName1 ?? this.playerName1,
      playerName2: playerName2 ?? this.playerName2,
      playerName3: playerName3 ?? this.playerName3,
      playerName4: playerName4 ?? this.playerName4,
      playerID1: playerID1 ?? this.playerID1,
      playerID2: playerID2 ?? this.playerID2,
      playerID3: playerID3 ?? this.playerID3,
      playerID4: playerID4 ?? this.playerID4,
      betID: betID ?? this.betID,
      betName: betName ?? this.betName,
      costShuttlecock: costShuttlecock ?? this.costShuttlecock,
      betTeam1ID: betTeam1ID ?? this.betTeam1ID,
      betTeam1Name: betTeam1Name ?? this.betTeam1Name,
      betTeam2ID: betTeam2ID ?? this.betTeam2ID,
      betTeam2Name: betTeam2Name ?? this.betTeam2Name,
      betTeamID: betTeamID ?? this.betTeamID,
      betTeamName: betTeamName ?? this.betTeamName,
      betAmount: betAmount ?? this.betAmount,
    );
  }
}

class CounterState {
  final int count;
  CounterState({required this.count});
}

class UserState {
  final String name;
  UserState({required this.name});
}

class AppState {
  final CounterState counterState;
  final UserState userState;
  final PlayerState playerState;
  final PlayerGameAddState playerGameAddState;
  final BetDetailState betDetailState;
  final GameState gameState;
  final PaymentState paymentState;
  AppState(
      {required this.counterState,
      required this.userState,
      required this.playerState,
      required this.playerGameAddState,
      required this.betDetailState,
      required this.gameState,
      required this.paymentState});
}
