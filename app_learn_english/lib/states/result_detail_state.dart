import 'package:app_learn_english/models/result_detail_model.dart';
import 'package:equatable/equatable.dart';

class ResultDetailState extends Equatable {
  const ResultDetailState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ResultDetailInitial extends ResultDetailState{}
class ResultDetailFailure extends ResultDetailState{}
class ResultDetailSuccess extends ResultDetailState{
  final List<ResultDetailModel> resultDetails;
  ResultDetailSuccess({required this.resultDetails});
  @override
  // TODO: implement props
  List<Object?> get props => [resultDetails];

  ResultDetailSuccess cloneWith(List<ResultDetailModel>? resultDetails) {
    return ResultDetailSuccess(resultDetails: resultDetails ?? this.resultDetails);
  }
}
class PostResultDetailSuccess extends ResultDetailState {}