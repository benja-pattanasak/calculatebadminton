class SettingModel {
  late int id;
  late int costCort;
  late int costShuttleCock;
  map() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['costCort'] = costCort;
    mapping['costShuttleCock'] = costShuttleCock;
    return mapping;
  }
}
