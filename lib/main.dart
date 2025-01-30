import 'package:calculatebadminton/model/player_model.dart';
import 'package:calculatebadminton/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

//state
class PlayerState {
  final List<PlayerModel> listPlayerModel;
  PlayerState({this.listPlayerModel = const []});
  PlayerState copyWith({List<PlayerModel>? listPlayerModel}) {
    return PlayerState(
        listPlayerModel: listPlayerModel ?? this.listPlayerModel);
  }
}

class PlayerGameAddState {
  final String player1;
  final String player2;
  final String player3;
  final String player4;
  final int costShuttlecock;
  PlayerGameAddState(
      {this.player1 = "",
      this.player2 = "",
      this.player3 = "",
      this.player4 = "",
      this.costShuttlecock = 0});
  PlayerGameAddState copyWith(
      {String? player1,
      String? player2,
      String? player3,
      String? player4,
      int? costShuttlecock}) {
    return PlayerGameAddState(
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      player3: player3 ?? this.player3,
      player4: player4 ?? this.player4,
      costShuttlecock: costShuttlecock ?? this.costShuttlecock,
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
  AppState(
      {required this.counterState,
      required this.userState,
      required this.playerState,
      required this.playerGameAddState});
}

//reducer

PlayerGameAddState PlayerGameAddReducer(
    PlayerGameAddState state, dynamic action) {
  if (action is PlayerGameAddCopyWith) {
    return state.copyWith(
        player1: action.player1,
        player2: action.player2,
        player3: action.player3,
        player4: action.player4,
        costShuttlecock: action.costShuttlecock);
  }
  return state;
}

CounterState counterReducer(CounterState state, dynamic action) {
  if (action == 'INCREMENT') {
    return CounterState(count: state.count + 1);
  }
  return state;
}

UserState userReducer(UserState state, dynamic action) {
  if (action is UpdateUserAction) {
    return UserState(name: action.newName);
  }
  return state;
}

PlayerState playerReducer(PlayerState state, dynamic action) {
  if (action is PlayerCopyWith) {
    return state.copyWith(listPlayerModel: action.listPlayerModel);
  }
  return state;
}

//action
class UpdateUserAction {
  final String newName;
  UpdateUserAction(this.newName);
}

class PlayerCopyWith {
  final List<PlayerModel> listPlayerModel;
  PlayerCopyWith(this.listPlayerModel);
}

class PlayerGameAddCopyWith {
  final String player1;
  final String player2;
  final String player3;
  final String player4;
  final int costShuttlecock;
  PlayerGameAddCopyWith(this.player1, this.player2, this.player3, this.player4,
      this.costShuttlecock);
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      counterState: counterReducer(state.counterState, action),
      userState: userReducer(state.userState, action),
      playerState: playerReducer(state.playerState, action),
      playerGameAddState:
          PlayerGameAddReducer(state.playerGameAddState, action));
}

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
