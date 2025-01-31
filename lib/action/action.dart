import 'package:calculatebadminton/model/player_model.dart';

class UpdateUserAction {
  final String newName;
  UpdateUserAction(this.newName);
}

class PlayerCopyWith {
  final List<PlayerModel> listPlayerModel;
  PlayerCopyWith(this.listPlayerModel);
}

class PlayerGameAddCopyWith {
  final String player1;
  final String player2;
  final String player3;
  final String player4;
  final int costShuttlecock;
  PlayerGameAddCopyWith(this.player1, this.player2, this.player3, this.player4,
      this.costShuttlecock);
}
