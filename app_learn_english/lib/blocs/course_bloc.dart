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

  // [CourseModel(id: 1, name: "A", introduce: 'intro', image: 'https://topdev.vn/blog/wp-content/uploads/2017/09/github1.png')]

  /*@override
  Stream<CourseState> mapEventToState(CourseEvent event)  async* {

    try {
      final hasFetchedEndOfPage = (state is CourseStateSuccess) && (state as CourseStateSuccess).hasReachedEnd;
      if (event is CourseFetchedEvent && !hasFetchedEndOfPage) {
        if (state is CourseStateInitial) {
          final courses = await getAllCourses();
          yield CourseStateSuccess(courses: courses, hasReachedEnd: false);
        } else if (state is CourseStateSuccess) {
          final currentState = state as CourseStateSuccess;
          final courses = await getAllCourses();
          yield CourseStateSuccess(courses: currentState.courses + courses , hasReachedEnd: false);
        }
      } else {
        yield CourseStateFailure();
      }
    } catch (exception) {
        print(exception);
        yield CourseStateFailure();
    }


    yield CourseStateSuccess(courses: []  , hasReachedEnd: false);
  }*/
}