import 'package:calculatebadminton/database/repository.dart';
import 'package:calculatebadminton/model/player_model.dart';

class PlayerRepository {
  PlayerRepository() {}
  add(PlayerModel player) async {
    Repository repository = Repository();
    return await repository.add('player', player.map());
  }

  getAll() async {
    Repository repository = Repository();
    return await repository.getAll('player');
  }

  getItem(playerID) async {
    Repository repository = Repository();
    return await repository.getItem('player', playerID);
  }

  edit(PlayerModel player) async {
    Repository repository = Repository();
    return await repository.edit('player', player.map());
  }

  delete(playerID) async {
    Repository repository = Repository();
    return await repository.delete('player', playerID);
  }

  getListByRawQeury(sql) async {
    Repository repository = Repository();
    return await repository.getListByRawQeury(sql);
  }

  getMaxId() async {
    Repository repository = Repository();
    return await repository
        .getListByRawQeury('SELECT MAX(id) as id FROM player');
  }

  count() async {
    Repository repository = Repository();
    return await repository
        .getListByRawQeury('SELECT COUNT(*) as count FROM player');
  }
}
