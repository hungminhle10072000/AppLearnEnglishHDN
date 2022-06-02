import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/resources/course_service.dart';
import 'package:app_learn_english/states/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../events/course_event.dart';

class CourseBloc extends Bloc<CourseEvent,CourseState> {
  final NUMBER_OF_COURSES_PER_PAGE = 10;

  CourseBloc() : super(CourseStateInitial()) {
    on<CourseFetchedEvent>(_onLoadCourses);
  }

  void _onLoadCourses(CourseFetchedEvent event, Emitter<CourseState> emit) async {
    final courses =  await getAllCourses();
    emit(CourseStateSuccess(courses: courses,hasReachedEnd: false));
  }

}