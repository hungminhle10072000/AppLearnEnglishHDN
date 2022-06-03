import 'package:app_learn_english/models/statistical_model.dart';

class StatisticalMasterModel {

  String fullname;
  double process;// phan tram diem so diemlm dc
  int streak;// so ngay dat 1000 diem lien tiep
  int currentScore;// so diem hien tai /1000
  List<StatisticalModel> statisticalDtoList;
  StatisticalMasterModel({
    required this.fullname,
    required this.process,
    required this.streak,
    required this.currentScore,
    required this.statisticalDtoList
  });
}