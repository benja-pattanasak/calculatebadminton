import 'package:calculatebadminton/database/repository.dart';
import 'package:calculatebadminton/model/game_model.dart';

class GameRepository {
  late Repository _repository;
  GameRepository() {
    _repository = Repository();
  }

  add(GameModel game) async {
    return await _repository.add('game', game.map());
  }

  getAll() async {
    return await _repository.getAll('game');
  }

  getAllAndBetDetail() async {
    String sql =
        "select * from  game left join betdetail on game.id=betdetail.gameID ";
    return await _repository.getListByRawQeury(sql);
  }

  getItem(gameID) async {
    return await _repository.getItem('game', gameID);
  }

  edit(GameModel game) async {
    return await _repository.edit('game', game.map());
  }

  delete(gameID) async {
    return await _repository.delete('game', gameID);
  }

  deleteAllGame() async {
    String sql = "delete from game";
    return await _repository.getListByRawQeury(sql);
  }

  getListPaymentByPlayID(playerID) async {
    String sql = "select * from  game where team1ID||team2ID like '%" +
        playerID.toString() +
        "%'";
    return await _repository.getListByRawQeury(sql);
  }

  editShuttleCock(int gameID, int numberShuttleCock) async {
    String sql = "update game set numberShuttleCock=" +
        numberShuttleCock.toString() +
        " where id=" +
        gameID.toString();
    return await _repository.getListByRawQeury(sql);
  }

  editGameResult(String gameResult, int gameID) async {
    String sql = "update game set results=" +
        gameResult +
        " where id=" +
        gameID.toString();
    return await _repository.getListByRawQeury(sql);
  }

  getMaxId() async {
    Repository repository = Repository();
    return await repository.getListByRawQeury('SELECT MAX(id) as id FROM game');
  }
}
