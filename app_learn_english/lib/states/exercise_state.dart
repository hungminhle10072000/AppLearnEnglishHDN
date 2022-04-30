import 'package:app_learn_english/models/exercise_model.dart';
import 'package:equatable/equatable.dart';

class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ExerciseStateInitial extends ExerciseState {}
class ExerciseStateFailure extends ExerciseState {}
class ExerciseStateSuccess extends ExerciseState {
  final List<ExerciseModel> exercises;
  ExerciseStateSuccess({required this.exercises});

  @override
  // TODO: implement props
  List<Object?> get props => [exercises];

  ExerciseStateSuccess cloneWith({List<ExerciseModel>? exercises}) {
    return ExerciseStateSuccess(exercises: exercises ?? this.exercises);
  }
}