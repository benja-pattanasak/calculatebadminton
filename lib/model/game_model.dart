class GameModel {
  late int? gameID;
  late String? team1ID;
  late String? team1Name;
  late String? team2ID;
  late String? team2Name;
  late String? typeCostShuttlecock;
  late int? numberShuttleCock;
  late String? results;
  map() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = gameID;
    mapping['team1ID'] = team1ID;
    mapping['team1Name'] = team1Name;
    mapping['team2ID'] = team2ID;
    mapping['team2Name'] = team2Name;
    mapping['typeCostShuttlecock'] = typeCostShuttlecock;
    mapping['numberShuttleCock'] = numberShuttleCock;
    mapping['results'] = results;
    return mapping;
  }

  GameModel(
      {this.gameID,
      this.team1ID,
      this.team1Name,
      this.team2ID,
      this.team2Name,
      this.typeCostShuttlecock,
      this.numberShuttleCock,
      this.results});
  factory GameModel.fromMap(Map<String, Object?> map) {
    return GameModel(
        gameID: map['id'] as int,
        team1ID: map['team1ID'] as String,
        team1Name: map['team1Name'] as String,
        team2ID: map['team2ID'] as String,
        team2Name: map['team2Name'] as String,
        typeCostShuttlecock: map['typeCostShuttlecock'] as String,
        numberShuttleCock: map['numberShuttleCock'] as int,
        results: map['results'] as String);
  }
}
