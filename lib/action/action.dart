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
  final String player1;
  final String player2;
  final String player3;
  final String player4;
  final int costShuttlecock;
  PlayerGameAddChangeValue(this.player1, this.player2, this.player3,
      this.player4, this.costShuttlecock);
}
