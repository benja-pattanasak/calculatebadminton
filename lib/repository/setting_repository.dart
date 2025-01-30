import 'package:calculatebadminton/database/repository.dart';
import 'package:calculatebadminton/model/setting_model.dart';

class SettingRepository {
  late Repository _repository;
  SettingRepository() {
    _repository = Repository();
  }
  add(SettingModel setting) async {
    return await _repository.add('setting', setting.map());
  }

  getAll() async {
    return await _repository.getAll('setting');
  }

  getItem(settingID) async {
    return await _repository.getItem('setting', settingID);
  }

  edit(SettingModel setting) async {
    return await _repository.edit('setting', setting.map());
  }

  delete(settingID) async {
    return await _repository.delete('setting', settingID);
  }
}
