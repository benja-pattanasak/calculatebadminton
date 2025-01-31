import 'package:calculatebadminton/database/repository.dart';
import 'package:calculatebadminton/model/betdetail_model.dart';

class BetDetailRepository {
  late Repository _repository;
  BetDetailRepository() {
    _repository = Repository();
  }

  add(BetDetailModel betdetail) async {
    return await _repository.add('betdetail', betdetail.map());
  }

  getAll() async {
    return await _repository.getAll('betdetail');
  }

  getItem(betdetailID) async {
    return await _repository.getItem('betdetail', betdetailID);
  }

  deleteAllBetDetail() async {
    String sql = "delete from betdetail";
    return await _repository.getListByRawQeury(sql);
  }

  getItemByGameID(gameID) async {
    String sql = "select * from  betdetail where gameID=" + gameID.toString();
    return await _repository.getListByRawQeury(sql);
  }

  edit(BetDetailModel betdetail) async {
    return await _repository.edit('betdetail', betdetail.map());
  }

  delete(betdetailID) async {
    return await _repository.delete('betdetail', betdetailID);
  }

  deleteBetDetail(int gameID) async {
    if (gameID > 0) {
      String sql = "delete from betdetail where gameID=" + gameID.toString();
      return await _repository.getListByRawQeury(sql);
    }
  }

  getListBetDetail(gameID, playerID) async {
    String sql = "select * from  betdetail where gameID=" +
        gameID.toString() +
        " and betPlayerID=" +
        playerID.toString();
    return await _repository.getListByRawQeury(sql);
  }

  getMaxId() async {
    Repository repository = Repository();
    return await repository
        .getListByRawQeury('SELECT MAX(id) as id FROM betdetail');
  }
}
