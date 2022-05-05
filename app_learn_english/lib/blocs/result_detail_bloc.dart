import 'package:app_learn_english/events/result_detail_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../resources/result_detail_service.dart';
import '../states/result_detail_state.dart';

class ResultDetailBloc extends Bloc<ResultDetailEvent, ResultDetailState> {
  ResultDetailBloc() : super(ResultDetailInitial()) {
    on<ResultDetailAddEvent> (_onAddDetailResult);
  }

  void _onAddDetailResult(ResultDetailAddEvent event,Emitter<ResultDetailState> emit) async {
    final isSuccess = await addResultDetail(event.resultDetail);
    if (isSuccess == true) {
      emit(ResultDetailSuccess(resultDetails: event.resultDetail));
    } else {
      emit(ResultDetailFailure());
    }
  }

}