class PaymentModel {
  late int? playerID;
  late String? playerName;
  PaymentModel({required this.playerID, required this.playerName});
  map() {
    var mapping = Map<String, dynamic>();
    mapping['playerID'] = playerID;
    mapping['playerName'] = playerName;
    return mapping;
  }
}
