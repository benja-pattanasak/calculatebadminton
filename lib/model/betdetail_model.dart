class BetDetailModel {
  late int? id;
  late int? gameID;
  late int? betPlayerID;
  late String? betPlayerName;
  late int? betValue;
  late String? betTeamID;
  late String? betTeamName;
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

  BetDetailModel(
      {this.id,
      this.gameID,
      this.betPlayerID,
      this.betPlayerName,
      this.betValue,
      this.betTeamID,
      this.betTeamName});
  factory BetDetailModel.fromMap(Map<String, Object?> map) {
    return BetDetailModel(
        id: map['id'] as int,
        gameID: int.parse(map['gameID'] as String),
        betPlayerID: int.parse(map['betPlayerID'] as String),
        betPlayerName: map['betPlayerName'] as String,
        betValue: map['betValue'] as int,
        betTeamID: map['betTeamID'] as String,
        betTeamName: map['betTeamName'] as String);
  }
}
