import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/state/state.dart';

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

AppState appReducer(AppState state, dynamic action) {
  return AppState(
      counterState: counterReducer(state.counterState, action),
      userState: userReducer(state.userState, action),
      playerState: playerReducer(state.playerState, action),
      playerGameAddState:
          PlayerGameAddReducer(state.playerGameAddState, action));
}
