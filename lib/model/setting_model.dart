class SettingModel {
  late int costCort;
  late int costShuttleCock;
  map() {
    var mapping = Map<String, dynamic>();
    mapping['costCort'] = costCort;
    mapping['costShuttleCock'] = costShuttleCock;
    return mapping;
  }
}
