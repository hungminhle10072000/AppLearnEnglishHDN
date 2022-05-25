import 'package:app_learn_english/models/statistical_model.dart';

class StatisticalMasterModel {

  String fullname;
  double process;
  int streak;
  List<StatisticalModel> statisticalDtoList;
  StatisticalMasterModel({
    required this.fullname,
    required this.process,
    required this.streak,
    required this.statisticalDtoList
  });
}