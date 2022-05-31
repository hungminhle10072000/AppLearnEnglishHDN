import 'package:app_learn_english/blocs/change_password_bloc.dart';
import 'package:app_learn_english/blocs/course_bloc.dart';
import 'package:app_learn_english/blocs/exercise_bloc.dart';

import 'package:app_learn_english/blocs/list_grammar_bloc.dart';
import 'package:app_learn_english/blocs/forgetpass_bloc.dart';
import 'package:app_learn_english/blocs/list_vocabulary_bloc.dart';
import 'package:app_learn_english/blocs/statistical_bloc.dart';
import 'package:app_learn_english/blocs/update_info_bloc.dart';
import 'package:app_learn_english/blocs/user_bloc.dart';
import 'package:app_learn_english/events/course_event.dart';
import 'package:app_learn_english/events/exercise_event.dart';
import 'package:app_learn_english/events/statistical_event.dart';
import 'package:app_learn_english/models/course_model.dart';
import 'package:app_learn_english/presentation/screens/admin_page.dart';
import 'package:app_learn_english/presentation/screens/changePass.dart';
import 'package:app_learn_english/presentation/screens/chatpage.dart';
import 'package:app_learn_english/presentation/screens/course_detail_page.dart';
import 'package:app_learn_english/presentation/screens/course_list_page.dart';
import 'package:app_learn_english/presentation/screens/edit_infor.dart';
import 'package:app_learn_english/presentation/screens/exercise_list_page.dart';
import 'package:app_learn_english/presentation/screens/forgetPasswordPage.dart';
import 'package:app_learn_english/presentation/screens/homePage.dart';
import 'package:app_learn_english/presentation/screens/home_practice_total_vocabulary.dart';
import 'package:app_learn_english/presentation/screens/list_grammar_page.dart';
import 'package:app_learn_english/presentation/screens/loginPage.dart';
import 'package:app_learn_english/presentation/screens/practice_list_topic.dart';
import 'package:app_learn_english/presentation/screens/practice_vocabulary.dart';
import 'package:app_learn_english/presentation/screens/registerPage.dart';
import 'package:app_learn_english/presentation/screens/statistical_page.dart';
import 'package:app_learn_english/presentation/screens/topic_vocabulary_Page.dart';
import 'package:app_learn_english/presentation/screens/user_information.dart';
import 'package:app_learn_english/presentation/screens/vocabulary_detail_topic_page.dart';
import 'package:app_learn_english/resources/forgetpass_service.dart';
import 'package:app_learn_english/resources/login_service.dart';
import 'package:app_learn_english/states/forgetpass_state.dart';
import 'package:app_learn_english/states/login_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'blocs/login_bloc.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //     options: FirebaseOptions(
  //   apiKey:
  //       "BL819eba8a-muymF4bvtDM5tWWFaSIxCGuXIDMWhCamtp43dozKCS0YLv10hzlr0H5AeUej0_6LiXhgDrGOxAUk",
  //   appId: "1:596522897801:android:8a1e3df22b223866449158",
  //   messagingSenderId: "596522897801",
  //   projectId: "flutterpushnotification-66a35",
  // ));
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LoginBloc(
                initialStatem: LoginState(), repo: LoginRepository())),
        BlocProvider(
            create: (context) => ForgetPassBloc(
                initialStatem: ForgetPassState(),
                repo: ForgetPassRepository())),
        BlocProvider(create: (context) => ListVocabularyBloc()),
        BlocProvider(create: (context) => ListGrammarBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => UserUpdateInfoBloc()),
        BlocProvider(create: (context) => ChangePasswordBloc())
      ],
      child: MaterialApp(
        title: 'Cùng nhau học tiếng anh',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: <String, WidgetBuilder>{
          '/listExercise': (context) => BlocProvider(
              create: (context) {
                final _exerciseBloc = ExerciseBloc();
                final _exerciseEvent = ExerciseFetchedEvent();
                _exerciseBloc.add(_exerciseEvent);
                return _exerciseBloc;
              },
              child: ExerciseListPage()),
          // 'startExercisePage': (context) => const StartExercisePage(),
          'home': (context) => HomePage(),
          'admin': (context) => adminPage(),
          'login': (context) => loginPage(),
          'register': (context) => registerPage(),
          'forget': (context) => forgetPasswordPage(),
          'topicVocabulary': (context) => topic_vocabulary_page(),
          'listVocaTopic': (context) => VocabularyDetailTopicPage(),
          'listVocaTopicPractice': (context) => PracticeListTopic(),
          'listGrammar': (context) => GrammarListPage(),
          'changepass': (context) => changePassPage(),
          'editinfor': (context) => editinforPage(),
          '/updateinfomation': (context) => UserInformation(),
          'homeTotalPracticeVocabulary': (context) =>
              HomePracticeTotalVocabulary(),
          'practiceVocabulary': (context) => PracticeVocabularyPage(),
          '/statistical': (context) => BlocProvider(
                create: (context) {
                  final _statisticalBloc = StatisticalBloc();
                  final _statisticalEvent = StatisticalFetchedEvent();
                  _statisticalBloc.add(_statisticalEvent);
                  return _statisticalBloc;
                },
                child: StatisticalPage(),
              ),
          'listCourses': (context) => BlocProvider(
                create: (context) {
                  final _courseBloc = CourseBloc();
                  final _courseEvent = CourseFetchedEvent();
                  _courseBloc.add(_courseEvent);
                  return _courseBloc;
                },
                child: CourseListPage(),
              ),
          '/courseDetail': (context) => CourseDetailPage(
              courseDetail: CourseModel(
                  id: -1,
                  name: 'Course Name',
                  introduce: 'Introduction',
                  numOfChapter: 0,
                  chapters: [],
                  image: 'This is image')),
        },
      )));
}
