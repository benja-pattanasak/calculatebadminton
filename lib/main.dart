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
    ),
  );
  runApp(SplashScreen(store: store));
}
