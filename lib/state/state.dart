import 'package:calculatebadminton/model/player_model.dart';

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
