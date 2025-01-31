import 'package:calculatebadminton/model/player_model.dart';

class UpdateUserAction {
  final String newName;
  UpdateUserAction(this.newName);
}

class PlayerChangeValue {
  final List<PlayerModel> listPlayerModel;
  PlayerChangeValue(this.listPlayerModel);
}

class PlayerGameAddChangeValue {
  final String? playerName1;
  final String? playerName2;
  final String? playerName3;
  final String? playerName4;
  final String? playerID1;
  final String? playerID2;
  final String? playerID3;
  final String? playerID4;
  final int? costShuttlecock;
  PlayerGameAddChangeValue(
      {this.playerName1,
      this.playerName2,
      this.playerName3,
      this.playerName4,
      this.playerID1,
      this.playerID2,
      this.playerID3,
      this.playerID4,
      this.costShuttlecock});
}
