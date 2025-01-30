class BetDetailModel {
  late int id;
  late int gameID;
  late int betPlayerID;
  late String betPlayerName;
  late int betValue;
  late String betTeamID;
  late String betTeamName;
  map() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['gameID'] = gameID;
    mapping['betPlayerID'] = betPlayerID;
    mapping['betPlayerName'] = betPlayerName;
    mapping['betValue'] = betValue;
    mapping['betTeamID'] = betTeamID;
    mapping['betTeamName'] = betTeamName;
    return mapping;
  }
}
