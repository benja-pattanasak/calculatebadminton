class PlayerModel {
  late int id;
  late String name;
  map() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['name'] = name;
    return mapping;
  }

  PlayerModel({required this.id, required this.name});
  factory PlayerModel.fromMap(Map<String, Object?> map) {
    return PlayerModel(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}
