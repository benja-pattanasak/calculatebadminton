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
            player1: "", player2: "", player3: "", player4: "")),
  );
  runApp(SplashScreen(store: store));
}
