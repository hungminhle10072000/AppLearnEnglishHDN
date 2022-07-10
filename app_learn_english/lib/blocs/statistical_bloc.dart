import 'package:app_learn_english/events/statistical_event.dart';
import 'package:app_learn_english/states/statistical_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/statistical_service.dart';
import '../states/current_user_state.dart';
class StatisticalBloc extends Bloc<StatisticalEvent, StatisticalState> {
  StatisticalBloc() : super(StatisticalStateInitial()) {
    on<StatisticalFetchedEvent>(_onLoadStatisticalOfWeek);
    on<StatisticalFetchedAgoEvent>(_onLoadStatisticalOfWeekAgo);
  }
  void _onLoadStatisticalOfWeek(StatisticalFetchedEvent event,  Emitter<StatisticalState> emit) async {
    final statisticals = await getStatisticalOfWeek(CurrentUserState.id);
    emit(StatisticalStateSuccess(statisticalMaster: statisticals,id:0));
  }
  void _onLoadStatisticalOfWeekAgo(StatisticalFetchedAgoEvent event,  Emitter<StatisticalState> emit) async {
    final statisticals = await getStatisticalOfWeekByUserIdAndWeekAgo(CurrentUserState.id,event.weekAgo);
    emit(StatisticalStateSuccess(statisticalMaster: statisticals,id: event.weekAgo));
  }
}