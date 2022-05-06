import 'package:app_learn_english/models/result_detail_model.dart';
import 'package:equatable/equatable.dart';

class ResultDetailEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ResultDetailAddEvent extends ResultDetailEvent {
  List<ResultDetailModel> resultDetail;
  ResultDetailAddEvent({required this.resultDetail});
}
class ResultDetailFetchEvent extends ResultDetailEvent {
  int userId;
  int exerciseId;
  ResultDetailFetchEvent({required this.userId, required this.exerciseId});
}