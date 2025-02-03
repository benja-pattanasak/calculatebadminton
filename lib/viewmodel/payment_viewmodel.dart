import 'package:calculatebadminton/model/payment_model.dart';
import 'package:calculatebadminton/model/player_model.dart';

class PaymentViewmodel {
  List<PlayerModel> listPlayerModel = [];
  PaymentModel paymentModel;
  int gameCount;
  String payPlayerID;
  String payPlayerName;
  int countShuttleCock;
  int costShuttleCock;
  double calculateCostShuttleCock;
  double costBetExpenses;
  int costCort;
  double costSumary;
  double costBetRevenue;
  PaymentViewmodel(
      {required this.listPlayerModel,
      required this.paymentModel,
      required this.gameCount,
      required this.payPlayerID,
      required this.payPlayerName,
      required this.countShuttleCock,
      required this.costShuttleCock,
      required this.calculateCostShuttleCock,
      required this.costBetExpenses,
      required this.costCort,
      required this.costSumary,
      required this.costBetRevenue}) {}
}
