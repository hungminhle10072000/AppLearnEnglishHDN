import 'package:app_learn_english/models/statistical_model.dart';

class StatisticalMasterModel {

  String fullname;
  double process;
  int streak;
  int currentScore;
  List<StatisticalModel> statisticalDtoList;
  StatisticalMasterModel({
    required this.fullname,
    required this.process,
    required this.streak,
    required this.currentScore,
    required this.statisticalDtoList
  });
}