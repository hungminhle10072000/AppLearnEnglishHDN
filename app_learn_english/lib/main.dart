import 'package:app_learn_english/blocs/course_bloc.dart';
import 'package:app_learn_english/blocs/list_vocabulary_bloc.dart';
import 'package:app_learn_english/events/course_event.dart';
import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/presentation/screens/admin_page.dart';
import 'package:app_learn_english/presentation/screens/course_detail_page.dart';
import 'package:app_learn_english/presentation/screens/course_list_page.dart';
import 'package:app_learn_english/presentation/screens/forgetPasswordPage.dart';
import 'package:app_learn_english/presentation/screens/homePage.dart';
import 'package:app_learn_english/presentation/screens/loginPage.dart';
import 'package:app_learn_english/presentation/screens/registerPage.dart';
import 'package:app_learn_english/presentation/screens/topic_vocabulary_Page.dart';
import 'package:app_learn_english/presentation/screens/vocabulary_detail_topic_page.dart';
import 'package:app_learn_english/resources/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/login_bloc.dart';

void main() {
  runApp(RepositoryProvider(
      create: (context) => LoginRepository(),
      child: BlocProvider(
      create: (context) => LoginBloc( repo: RepositoryProvider.of<LoginRepository>(context),
      ),
        child: MaterialApp(
          title: 'Cùng nhau học tiếng anh',
            debugShowCheckedModeBanner: false,
            initialRoute: 'login',
            routes: <String, WidgetBuilder>{
              'home': (context) => HomePage(),
              'admin': (context) => adminPage(),
              'login': (context) => loginPage(),
              'register': (context) => registerPage(),
              'forget': (context) => forgetPasswordPage(),
              'topicVocabulary': (context) => topic_vocabulary_page(),
              'listVocaTopic': (context) => VocabularyDetailTopicPage(),
              'listCourses': (context) => BlocProvider(
                  create: (context) {
                    final _courseBloc = CourseBloc();
                    final _courseEvent =CourseFetchedEvent();
                    _courseBloc.add(_courseEvent);
                    return _courseBloc;
                  },
                  child: CourseListPage(),
              ),
              '/courseDetail': (context) => CourseDetailPage(courseDetail: CourseModel(
                  id: -1,
                  name: 'Course Name',
                  introduce: 'Introduction',
                  numOfChapter:  0,
                  chapters: [],
                  image: 'This is image'))
            },
          ))
        ),

  );
}


      // MultiBlocProvider(
      // providers: [
      //   BlocProvider(
      //       create: (context) => LoginBloc(LoginInitState(), LoginRepository()))
      // ],
      // child: MaterialApp(
      //   title: 'Cùng nhau học tiếng anh',
      //   debugShowCheckedModeBanner: false,
      //   initialRoute: 'login',
      //   routes: <String, WidgetBuilder>{
      //     'home': (context) => HomePage(),
      //     'login': (context) => loginPage(),
      //     'register': (context) => registerPage(),
      //     'forget': (context) => forgetPasswordPage(),
      //     'topicVocabulary': (context) => topic_vocabulary_page(),
      //     'listVocaTopic': (context) => VocabularyDetailTopicPage(),
      //     'listCourses': (context) => BlocProvider(
      //         create: (context) {
      //           final _courseBloc = CourseBloc();
      //           final _courseEvent =CourseFetchedEvent();
      //           _courseBloc.add(_courseEvent);
      //           return _courseBloc;
      //         },
      //         child: CourseListPage(),
      //     ),
      //     '/courseDetail': (context) => CourseDetailPage(courseDetail: CourseModel(
      //         id: -1,
      //         name: 'Course Name',
      //         introduce: 'Introduction',
      //         numOfChapter:  0,
      //         chapters: [],
      //         image: 'This is image'))
      //   },
      // )));
//}
