import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/state/state.dart';

PlayerGameAddState PlayerGameAddReducer(
    PlayerGameAddState state, dynamic action) {
  if (action is PlayerGameAddChangeValue) {
    return state.SetValue(
        playerName1:
            action.playerName1 == "" ? state.playerID1 : action.playerName1,
        playerName2:
            action.playerName2 == "" ? state.playerID2 : action.playerName2,
        playerName3:
            action.playerName3 == "" ? state.playerID3 : action.playerName3,
        playerName4:
            action.playerName4 == "" ? state.playerID4 : action.playerName4,
        playerID1: action.playerID1 == "" ? state.playerID1 : action.playerID1,
        playerID2: action.playerID2 == "" ? state.playerID2 : action.playerID2,
        playerID3: action.playerID3 == "" ? state.playerID3 : action.playerID3,
        playerID4: action.playerID4 == "" ? state.playerID4 : action.playerID4,
        costShuttlecock: action.costShuttlecock == 0
            ? state.costShuttlecock
            : action.costShuttlecock);
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
  if (action is PlayerChangeValue) {
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
