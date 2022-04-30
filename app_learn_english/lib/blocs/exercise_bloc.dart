import 'package:app_learn_english/events/exercise_event.dart';
import 'package:app_learn_english/states/exercise_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/exercise_service.dart';

class ExerciseBloc extends Bloc<ExerciseEvent,ExerciseState> {

  ExerciseBloc() : super(ExerciseStateInitial()) {
    print('ExerciseBloc');
    on<ExerciseFetchedEvent>(_onLoadExercises);
  }
  void _onLoadExercises(ExerciseFetchedEvent event, Emitter<ExerciseState> emit) async {
    final exercises = await getAllExercises();
    emit(ExerciseStateSuccess(exercises: exercises));
  }
}