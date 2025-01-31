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
  final String playerName1;
  final String playerName2;
  final String playerName3;
  final String playerName4;
  final String playerID1;
  final String playerID2;
  final String playerID3;
  final String playerID4;
  final int costShuttlecock;
  PlayerGameAddState(
      {this.playerName1 = "",
      this.playerName2 = "",
      this.playerName3 = "",
      this.playerName4 = "",
      this.playerID1 = "",
      this.playerID2 = "",
      this.playerID3 = "",
      this.playerID4 = "",
      this.costShuttlecock = 0});
  PlayerGameAddState SetValue(
      {String? playerName1,
      String? playerName2,
      String? playerName3,
      String? playerName4,
      String? playerID1,
      String? playerID2,
      String? playerID3,
      String? playerID4,
      int? costShuttlecock}) {
    return PlayerGameAddState(
      playerName1: playerName1 ?? this.playerName1,
      playerName2: playerName2 ?? this.playerName2,
      playerName3: playerName3 ?? this.playerName3,
      playerName4: playerName4 ?? this.playerName4,
      playerID1: playerID1 ?? this.playerID1,
      playerID2: playerID2 ?? this.playerID2,
      playerID3: playerID3 ?? this.playerID3,
      playerID4: playerID4 ?? this.playerID4,
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
