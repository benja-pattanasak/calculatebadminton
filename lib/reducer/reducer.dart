import 'package:calculatebadminton/action/action.dart';
import 'package:calculatebadminton/state/state.dart';

GameState GameReducer(GameState state, dynamic action) {
  if (action is GameChangeValue) {
    return state.setValue(listGameModel: action.listGameModel);
  }
  return state;
}

BetDetailState BetDetailReducer(BetDetailState state, dynamic action) {
  if (action is BetDetailChangeValue) {
    return state.setValue(listBetDetailModel: action.listBetDetailModel);
  }
  return state;
}

PlayerGameAddState PlayerGameAddReducer(
    PlayerGameAddState state, dynamic action) {
  if (action is PlayerGameAddChangeValue) {
    return state.SetValue(
      playerName1:
          action.playerName1 == "" ? state.playerName1 : action.playerName1,
      playerName2:
          action.playerName2 == "" ? state.playerName2 : action.playerName2,
      playerName3:
          action.playerName3 == "" ? state.playerName3 : action.playerName3,
      playerName4:
          action.playerName4 == "" ? state.playerName4 : action.playerName4,
      playerID1: action.playerID1 == "" ? state.playerID1 : action.playerID1,
      playerID2: action.playerID2 == "" ? state.playerID2 : action.playerID2,
      playerID3: action.playerID3 == "" ? state.playerID3 : action.playerID3,
      playerID4: action.playerID4 == "" ? state.playerID4 : action.playerID4,
      betID: action.betID == "" ? state.betID : action.betID,
      betName: action.betName == "" ? state.betName : action.betName,
      costShuttlecock: action.costShuttlecock == 0
          ? state.costShuttlecock
          : action.costShuttlecock,
      betTeam1ID:
          action.betTeam1ID == "" ? state.betTeam1ID : action.betTeam1ID,
      betTeam1Name:
          action.betTeam1Name == "" ? state.betTeam1Name : action.betTeam1Name,
      betTeam2ID:
          action.betTeam2ID == "" ? state.betTeam2ID : action.betTeam2ID,
      betTeam2Name:
          action.betTeam2Name == "" ? state.betTeam2Name : action.betTeam2Name,
      betTeamID: action.betTeamID == "" ? state.betTeamID : action.betTeamID,
      betTeamName:
          action.betTeamName == "" ? state.betTeamName : action.betTeamName,
      betAmount: action.betAmount == 0 ? state.betAmount : action.betAmount,
    );
  } else if (action is PlayerGameAddClearValue) {
    return state.SetValue(
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
      costShuttlecock: 0,
      betTeam1ID: "",
      betTeam1Name: "",
      betTeam2ID: "",
      betTeam2Name: "",
      betTeamID: "",
      betTeamName: "",
      betAmount: 0,
    );
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
    playerGameAddState: PlayerGameAddReducer(state.playerGameAddState, action),
    betDetailState: BetDetailReducer(state.betDetailState, action),
    gameState: GameReducer(state.gameState, action),
  );
}
