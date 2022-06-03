import 'package:app_learn_english/models/statistical_master_model.dart';
import 'package:app_learn_english/models/statistical_model.dart';
import 'package:equatable/equatable.dart';

class StatisticalState extends  Equatable {
  const StatisticalState( );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class StatisticalStateInitial extends StatisticalState {}// trang thai ban dau
class StatisticalStateFailure extends StatisticalState {}// trang thai neu bi loi
class StatisticalStateSuccess extends StatisticalState {// trang thai thanh cong
  // final List<StatisticalModel> statisticals;
  // StatisticalStateSuccess({required this.statisticals});
  final StatisticalMasterModel statisticalMaster;
  StatisticalStateSuccess({required this.statisticalMaster});

  @override
  // TODO: implement props
  List<Object?> get props => [statisticalMaster];


}