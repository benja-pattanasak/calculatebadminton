class GameModel {
  late int gameID;
  late String team1ID;
  late String team1Name;
  late String team2ID;
  late String team2Name;
  late String typeCostShuttlecock;
  late int numberShuttleCock;
  late String results;
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
}
