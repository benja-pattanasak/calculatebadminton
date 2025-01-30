class BetTempModel {
  late int betPlayerID;
  late String betPlayerName;
  late String team1ID;
  late String team1Name;
  late String team2ID;
  late String team2Name;
  late int betValue;
  map() {
    var mapping = Map<String, dynamic>();
    mapping['betPlayerID'] = betPlayerID;
    mapping['betPlayerName'] = betPlayerName;
    mapping['team1ID'] = team1ID;
    mapping['team1Name'] = team1Name;
    mapping['team2ID'] = team2ID;
    mapping['team2Name'] = team2Name;
    mapping['betValue'] = betValue;
    return mapping;
  }
}
