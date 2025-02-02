import 'package:calculatebadminton/model/betdetail_model.dart';
import 'package:calculatebadminton/model/game_model.dart';

class GameViewmodel {
  List<GameModel> listGameModel = [];
  List<BetDetailModel> listBetDetailModel = [];
  GameViewmodel(
      {required this.listGameModel, required this.listBetDetailModel}) {}
}
