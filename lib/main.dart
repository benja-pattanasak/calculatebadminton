import 'package:calculatebadminton/model/payment_model.dart';
import 'package:calculatebadminton/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:calculatebadminton/state/state.dart';
import 'package:calculatebadminton/reducer/reducer.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(
        counterState: CounterState(count: 0),
        userState: UserState(name: "Test"),
        playerState: PlayerState(listPlayerModel: List.empty()),
        playerGameAddState: PlayerGameAddState(
            playerName1: "",
            playerName2: "",
            playerName3: "",
            playerName4: "",
            playerID1: "",
            playerID2: "",
            playerID3: "",
            playerID4: "",
            betID: "",
            betName: "",
            betTeam1ID: "",
            betTeam1Name: "",
            betTeam2ID: "",
            betTeam2Name: "",
            costShuttlecock: 0),
        betDetailState: BetDetailState(listBetDetailModel: []),
        gameState: GameState(listGameModel: []),
        paymentState: PaymentState(
            paymentModel: PaymentModel(playerID: 0, playerName: ""),
            calculateCostShuttleCock: 0,
            costBetExpenses: 0,
            costBetRevenue: 0,
            costCort: 0,
            costShuttleCock: 0,
            costSumary: 0,
            countShuttleCock: 0,
            gameCount: 0,
            payPlayerID: "",
            payPlayerName: "")),
  );
  runApp(SplashScreen(store: store));
}
