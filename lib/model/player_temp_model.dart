class PlayerTempModel {
  late int player1ID;
  late String player1Name;
  late int player2ID;
  late String player2Name;
  late int player3ID;
  late String player3Name;
  late int player4ID;
  late String player4Name;
  map() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = player1ID;
    mapping['player1Name'] = player1Name;
    mapping['player2ID'] = player2ID;
    mapping['player2Name'] = player2Name;
    mapping['player3ID'] = player3ID;
    mapping['player3Name'] = player3Name;
    mapping['player4ID'] = player4ID;
    mapping['player4Name'] = player4Name;
    return mapping;
  }
}
