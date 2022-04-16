import 'package:app_learn_english/models/course_model.dart';
import 'package:equatable/equatable.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object> get props {
    return [];
  }
}

class CourseStateInitial extends CourseState {}
class CourseStateFailure extends CourseState {}
class CourseStateSuccess extends CourseState {
  final List<CourseModel> courses;
  bool hasReachedEnd;
  CourseStateSuccess({required this.courses, required this.hasReachedEnd});

  @override
  // TODO: implement props
  List<Object> get props => [courses,hasReachedEnd];

  CourseStateSuccess cloneWith({List<CourseModel>? courses, bool? hasReachedEnd}) {
    return CourseStateSuccess(courses: courses ?? this.courses, hasReachedEnd: hasReachedEnd ?? this.hasReachedEnd);
  }
}